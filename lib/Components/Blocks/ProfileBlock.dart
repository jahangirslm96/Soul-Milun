import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Components/AlertBox/DialogBox1.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/PackageDetails.model.dart';
import 'package:soul_milan/Utils/Controller/model/ProfileModel/ProfileOverview.model.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soul_milan/view_model/SoulProfilesTimeline_ViewModel.dart';
import 'package:soul_milan/view_model/SubscriptionPackage_ViewModel.dart';

import '../../../Utils/ThemeColors.dart';
import '../../Utils/Common/Function.dart';
import '../../Utils/Routes.dart';
import '../AlertBox/EarnDialogBox.dart';
import '../Card/ProfileCard.dart';

class ProfileBlock extends StatefulWidget {
  final String title;
  final List<ProfileOverview>? profile;
  final bool isLoading;
  const ProfileBlock(
      {Key? key,
      required this.title,
      this.profile,
      required this.isLoading})
      : super(key: key);

  @override
  State<ProfileBlock> createState() => _ProfileBlockState();
}

class _ProfileBlockState extends State<ProfileBlock> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.35,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: Get.height * 0.040,
              bottom: Get.height * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    (widget.title == 'Preferred' && checkPreferFilter() == false) ?
                    Padding(
                      padding: EdgeInsets.only(right: Get.width * 0.01),
                      child: Icon(
                        Icons.lock,
                        size: 28,
                        color: ThemeColors().milanColor,
                      ),
                    ) : const SizedBox(),
                    Text(
                      "${widget.title} Souls",
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeColors().buttonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Consumer<SoulProfilesTimeline_ViewModel>(builder: (context, soulProfilesTimeline_ViewModel, child) => 
                  Consumer<SubscriptionPackage_ViewModel>(builder: (context, subscriptionPackage_ViewModel, child) =>
                      InkWell(
                        onTap: () => {
                          if (widget.title == 'Preferred' && subscriptionPackage_ViewModel.currentPackageType == PackageType.NONE)
                            {
                              showDialog(
                                context: context,
                                builder: (context) => DialogBox1(
                                    heading: "Preferred Souls are LOCKED",
                                    subHeading: "Fill in the preferred form to view souls based on preference",
                                    buttonText: "Proceed",
                                    onTap: (){
                                      Get.snackbar(
                                          "Buy Subscription",
                                          "You must have subscription to avail this.",
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                    }
                                ),
                              )
                            }
                          else{
                            
                            if(widget.title != "Preferred"){
                              if(soulProfilesTimeline_ViewModel.switchProfileTime(widget.title)){
                                Get.snackbar(
                                  "No "+widget.title+" profiles left",
                                  "You have watched all the profiles",
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                )
                              }else{
                                  soulProfilesTimeline_ViewModel.setCurrentProfilePreview(widget.profile![0]),
                                // previewProfile = widget.profile[0];
                                Get.toNamed(
                                  RoutesClass.membersProfileScreen,
                                  arguments: widget.title,
                                )
                              }
                            }else{
                               if(checkPreferFilter()){
                                soulProfilesTimeline_ViewModel.setCurrentProfilePreview(widget.profile![0]),
                                // previewProfile = widget.profile[0];
                                Get.toNamed(
                                  RoutesClass.membersProfileScreen,
                                  arguments: widget.title,
                                )
                               }else{
                                  Get.toNamed(
                                  RoutesClass.preferredFormScreen
                                )
                               }
                            }
                          }
                        },
                        child: Text(
                          "View More",
                          style: TextStyle(
                            fontSize: 14,
                            color: ThemeColors().buttonColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
          if (widget.isLoading && widget.profile!.isEmpty)
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.02, horizontal:  Get.width * 0.01),
                    height: Get.height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ThemeColors().dividerColor,
                    ),
                    child: Center(
                      child: Text(
                        "No match Found in ${widget.title} Souls",
                        style: TextStyle(
                          fontSize: 15,
                          color: ThemeColors().buttonColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ConditionalBuilder(
            condition: widget.isLoading,
            builder: (BuildContext context) {
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // physics: widget.title == 'Preferred'? const NeverScrollableScrollPhysics(): const ScrollPhysics(),
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.profile!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = widget.profile![index];
                    return AspectRatio(
                      aspectRatio: 0.8,
                      child: ProfileCard(profile: item, title: widget.title),
                    );
                  },
                ),
              );
            },
            fallback: (BuildContext context) {
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5, // Number of shimmer placeholders
                  itemBuilder: (BuildContext context, int index) {
                    return Shimmer.fromColors(
                      period: const Duration(seconds: 2),
                      direction: ShimmerDirection.ltr,
                      baseColor: ThemeColors().dividerColor,
                      highlightColor: ThemeColors().deleteFromThisDevice,
                      child: AspectRatio(
                        aspectRatio: 0.8,
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: Get.width * 0.39,
                          height: Get.height * 0.39,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: ThemeColors().containerOutlineColor,
                              width: 1.5,
                            ),
                          ), // Placeholder color
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

bool checkPreferFilter(){
  if(preferredFilter.marriagePlans.isNotEmpty || preferredFilter.relocationPlans.isNotEmpty ||
  preferredFilter.familyPlans.isNotEmpty || preferredFilter.religiousPractices.isNotEmpty || 
  preferredFilter.praying.isNotEmpty || preferredFilter.islamicDress.isNotEmpty){
    return true;
  }

  return false;
}
