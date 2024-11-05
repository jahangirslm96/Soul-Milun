import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/view_model/TourPartners_ViewModel.dart';

import '../../Utils/Controller/model/TourPartners.model.dart';
import '../../Utils/ThemeColors.dart';
import '../Card/CustomProfileCard.dart';
import '../Card/ProfileCard.dart';

class TourBlock extends StatefulWidget {
  final String title;
  final Image image;
  final List<TourProfile>? tourProfiles; //this can be males or female.
  final bool IsLoaded;
  final String tourCode_;

  const TourBlock({
    super.key,
    required this.title,
    required this.image,
    this.tourProfiles,
    required this.IsLoaded,
    required this.tourCode_
  });

  @override
  State<TourBlock> createState() => _TourBlockState();
}

class _TourBlockState extends State<TourBlock> {

  @override
  void initState() {
    // TODO: implement initState
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
                top: Get.height * 0.05, bottom: Get.height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeColors().buttonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.015,
                    ),
                    widget.image,
                  ],
                ),
                Consumer<TourPartners_ViewModel>(builder: (context, value, child) =>
                    InkWell(
                      onTap: () {
                        if((widget.tourCode_ == "male" || widget.tourCode_ == "female") && widget.tourProfiles!.isNotEmpty){
                          value.setTourCode(widget.tourCode_);
                          Get.toNamed(RoutesClass.verifiedSoulsScreen);
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
                    ),
                ),
              ],
            ),
          ),
          ConditionalBuilder(
            condition: widget.IsLoaded && widget.tourProfiles!.isNotEmpty,
            builder: (BuildContext context) {
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.tourProfiles?.length,
                  itemBuilder: (BuildContext context, int index) {
                    // var item = widget.profile[index];
                    return AspectRatio(
                      aspectRatio: 0.8,
                      child: CustomProfileCard(tourProfile: widget.tourProfiles![index], title: widget.title),
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
