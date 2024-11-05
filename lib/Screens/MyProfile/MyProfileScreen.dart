import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';

import '../../Components/Headers/CustomHeader3.dart';
import '../../Components/Headers/CustomHeader5.dart';
import '../../Components/Tabs/CustomTabForProfile.dart';
import '../../Utils/Controller/model/ProfileModel/ProfileOverview.model.dart';
import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';

import '../../view_model/SoulProfile_ViewModel.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with TickerProviderStateMixin {
  int selectedTab = 0;
  bool isReady = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    isReady = false;
    //loadProfileOverView();
  }

  Future<void> loadProfileOverView() async {
    await myProfileOverView(); // Assuming loadChat is an asynchronous function
    setState(() {
      print("Profile overview loaded");
    });
  }

  myProfileOverView() async {
    setState(() {
      isReady = false;
    });
    var response =
        await connector.get("${getprofile}overview/${userProfile.id}");
    if (response['success'] == true && response["success"] != null) {
      setState(() {
        profileOverView = ProfileOverview.fromJson({
          "profileData": response["profileData"],
          "interest": response["interest"]
        });
         _tabController = TabController(
        length: profileOverView.interest!.keys.length + 1, vsync: this);
        isReady = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 12),
                child: const Column(
                  children: [
                    CustomHeader3(
                      name: "My Soul Profile",
                    ),
                  ],
                ),
              ),
              Divider(
                color: ThemeColors().containerOutlineColor,
                thickness: Get.height *0.0005,
              ),
              Consumer<SoulProfile_ViewModel>(builder: (context, value, child) => _UI(value),)
            ],
          ) 
        ),
      )
    );
  }

  _UI(SoulProfile_ViewModel soulProfile_ViewModel){
     if(!soulProfile_ViewModel.isProfileOverviewLoaded){
    return  Shimmer.fromColors(
                direction: ShimmerDirection.ltr,
                baseColor: ThemeColors().dividerColor,
                highlightColor: ThemeColors().deleteFromThisDevice,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Get.height * 0.01,
                                horizontal: Get.width * 0.02),
                            child: Column(
                              children: [
                                Container(
                                  height: Get.height * 0.035,
                                  color:
                                  ThemeColors().deleteFromThisDevice,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: Get.height * 0.005),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: Get.height * 0.025,
                                        width: Get.width * 0.3,
                                        color: ThemeColors()
                                            .deleteFromThisDevice,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // profileOverView.profileData.tagline.isNotEmpty
                          //     ? Padding(
                          //   padding: EdgeInsets.only(
                          //       top: Get.height * 0.02),
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       borderRadius:
                          //       BorderRadius.circular(6),
                          //       border: Border.all(
                          //         color: ThemeColors()
                          //             .gridPartnerProfileColor,
                          //       ),
                          //     ),
                          //     child: Column(
                          //       crossAxisAlignment:
                          //       CrossAxisAlignment.start,
                          //       children: [
                          //         Container(
                          //           height: Get.height * 0.065,
                          //           color: ThemeColors()
                          //               .deleteFromThisDevice,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // )
                          //     : Container(),
                          Padding(
                            padding:
                            EdgeInsets.only(top: Get.height * 0.02),
                            child: SizedBox(
                              height: Get.height * .35,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: Get.width * 0.02),
                                    child: Container(
                                      width: Get.width * 0.65,
                                      height: Get.height * 0.45,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: ThemeColors()
                                            .deleteFromThisDevice,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(top: Get.height * 0.02),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.06,
                                    color: ThemeColors()
                                        .deleteFromThisDevice,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.06,
                                    color: ThemeColors()
                                        .deleteFromThisDevice,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.06,
                                    color: ThemeColors()
                                        .deleteFromThisDevice,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(top: Get.height * 0.02),
                            child: Container(
                              height: Get.height * 0.25,
                              color: ThemeColors().deleteFromThisDevice,
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(top: Get.height * 0.02),
                            child: Container(
                              height: Get.height * 0.25,
                              color: ThemeColors().deleteFromThisDevice,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
     }


           _tabController = TabController(
        length: soulProfile_ViewModel.profileOverview!.interest!.keys.length + 1, vsync: this);
    return Container(
      child: Column(
        children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: soulProfile_ViewModel.profileOverview?.profileData!.name,
                                  style: TextStyle(
                                    color: ThemeColors().buttonColor,
                                    fontSize: CustomTheme().subDetails,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ", ",
                                      style: TextStyle(
                                        color: ThemeColors().buttonColor,
                                        fontSize: CustomTheme().onBoardingHeadingFontSize,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextSpan(
                                      text: soulProfile_ViewModel.profileOverview?.profileData!.age.toString(),
                                      style: TextStyle(
                                        color: ThemeColors().buttonColor,
                                        fontSize: CustomTheme().onBoardingHeadingFontSize,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: Get.height * 0.001),
                            child: Text(
                              "${soulProfile_ViewModel.profileOverview?.profileData!.city} Pakistan",
                              style: TextStyle(
                                color: ThemeColors().buttonColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    soulProfile_ViewModel.profileOverview?.profileData!.tagline != null
                        ? Padding(padding: EdgeInsets.only(top: Get.height * 0.02),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: ThemeColors().gridPartnerProfileColor,
                          ),
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.04,
                                vertical: Get.height * 0.01,
                              ),
                              child: Text(
                                soulProfile_ViewModel.profileOverview!.profileData!.tagline!,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: ThemeColors().buttonColor,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        : Container(),
                    Padding(padding: EdgeInsets.only(top: Get.height * 0.02),
                      child: SizedBox(
                        height: Get.height * .35,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: soulProfile_ViewModel.profileOverview?.profileData!.pictures!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(padding: EdgeInsets.only(right: Get.width * 0.01),
                              margin: EdgeInsets.only(right: Get.width * 0.01),
                              width: Get.width * .65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: ThemeColors().dividerColor,
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(connector.api.fileUrl + soulProfile_ViewModel.profileOverview!.profileData!.pictures![index],
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                              ),
                            );},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.02,),
              Padding(padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      splashFactory: InkRipple.splashFactory,
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: "Urbanist",
                      ),
                      unselectedLabelColor: ThemeColors().buttonColor,
                      indicatorColor: ThemeColors().buttonColor,
                      labelColor: ThemeColors().buttonColor,
                      indicatorPadding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                      indicatorWeight: 2,
                      isScrollable: true,
                      tabs: [const Tab(child: Text('About me')),
                        for (var i in soulProfile_ViewModel.profileOverview!.interest!.keys)
                          Tab(child: Text(i)),
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          CustomTabForProfile(
                            array: soulProfile_ViewModel.profileOverview?.profileData!.about(),
                            similar: soulProfile_ViewModel.profileOverview?.profileData!.about(),
                          ),
                          for (var i in soulProfile_ViewModel.profileOverview!.interest!.keys)
                            CustomTabForProfile(
                              array: soulProfile_ViewModel.profileOverview?.getSelectedInterest()[i],
                              similar: soulProfile_ViewModel.profileOverview?.getSelectedInterest()[i] ?? [],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: Get.height * 0.001),
                child: Divider(
                  color: ThemeColors().gridPartnerProfileColor,
                  thickness: Get.height * 0.0005,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: Get.height * .01,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Bio",
                      style: TextStyle(
                        fontSize: CustomTheme().onBoardingHeadingFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04, top: Get.height * 0.015),
                      child: Text(
                        soulProfile_ViewModel.profileOverview!.profileData!.bio!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: Get.height * 0.001),
                child: Divider(
                  color: ThemeColors().gridPartnerProfileColor,
                  thickness: Get.height * 0.0005,
                ),
              ),
              SizedBox(
                height: Get.height * 0.2,)
        ],
      ),
    );
  }
}
