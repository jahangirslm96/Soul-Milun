import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soul_milan/Components/Tabs/ExploreTab.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';

import '../../Components/NavigationBar/CustomBottomNavigationBar.dart';
import '../../Utils/Constants.dart';
import '../../Utils/ThemeColors.dart';
import '../../view_model/SoulProfile_ViewModel.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

  }

  void loadData() async {
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
    soulProfile_ViewModel.LoadProfileExplore();

    // var response = await connector.get("$intereaction${userProfile.id}");

    // //print("response");
    // if (response["success"] != null && response["success"]) {
    //   setState(() {
    //     interact = response["intereact"];
    //     isLoading = true;
    //     _tabController = TabController(length: interact.length, vsync: this);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Consumer<SoulProfile_ViewModel>(builder: (context, value, child) => 
            _buildUI(value)
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        ),
      ),
    );
  }

  _buildUI(SoulProfile_ViewModel soulProfile_ViewModel){
    if(soulProfile_ViewModel.interaction!.interact!.isEmpty){
      soulProfile_ViewModel.LoadProfileExplore();
      return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: chatScreenHeaderPadding,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Explore',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22,
                                        color: ThemeColors()
                                            .onBoardingHeadingColor,
                                      ),
                                    ),
                                    Text(
                                      "Explore and view all your interactions.",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ThemeColors().buttonColor,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ],
                                ),
                                /*Image.asset(
                                  "assets/icons/filter_icon.png",
                                  scale: 1.6,
                                  fit: BoxFit.cover,
                                ),*/
                              ],
                            ),
                          ],
                        ),
                      ),
                      Shimmer.fromColors(
                        period: const Duration(seconds: 2),
                        direction: ShimmerDirection.ltr,
                        baseColor: ThemeColors().dividerColor,
                        highlightColor: ThemeColors().deleteFromThisDevice,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.045),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: Get.height * 0.06,
                                      color: ThemeColors().deleteFromThisDevice,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: Get.height * 0.06,
                                      color: ThemeColors().deleteFromThisDevice,
                                    ),
                                  ),
                                  SizedBox(
                                      width: Get.width *
                                          0.01), // Space between the containers
                                  Expanded(
                                    child: Container(
                                      height: Get.height * 0.06,
                                      color: ThemeColors().deleteFromThisDevice,
                                    ),
                                  ),
                                  SizedBox(
                                      width: Get.width *
                                          0.01), // Space between the containers
                                  Expanded(
                                    child: Container(
                                      height: Get.height * 0.06,
                                      color: ThemeColors().deleteFromThisDevice,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.04,
                                  horizontal: Get.width * 0.06),
                              child: Container(
                                height: Get.height * 0.03,
                                color: ThemeColors().dividerColor,
                              ),
                            ),
                            Padding(
                              padding: tab1Padding,
                              child: GridView.builder(
                                primary: false,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 0.80,
                                ),
                                itemCount: 8,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: Get.width * 0.39,
                                    height: Get.height * 0.39,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color:
                                            ThemeColors().containerOutlineColor,
                                        width: 1.5,
                                      ),
                                    ), // Placeholder color
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
    }

     _tabController = TabController(length: soulProfile_ViewModel.interaction!.interact!.length, vsync: this);
    return Column(
                  children: [
                    Padding(
                      padding: chatScreenHeaderPadding,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Explore',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                      color:
                                          ThemeColors().onBoardingHeadingColor,
                                    ),
                                  ),
                                  Text(
                                    "Explore and view all your interactions.",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ThemeColors().buttonColor,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ],
                              ),
                             /*Image.asset(
                                "assets/icons/filter_icon.png",
                                scale: 1.6,
                                fit: BoxFit.cover,
                              ),*/
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.045),
                            child: TabBar(
                              controller: _tabController,
                              splashFactory: InkRipple.splashFactory,
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Urbanist",
                                fontWeight: FontWeight.bold,
                              ),
                              unselectedLabelStyle: const TextStyle(
                                fontSize: 12,
                                fontFamily: "Urbanist",
                              ),
                              unselectedLabelColor: ThemeColors().buttonColor,
                              indicatorColor: Colors.white,
                              labelColor: Colors.white,
                              indicatorPadding: EdgeInsets.zero,
                              labelPadding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.08),
                              indicatorWeight: 0,
                              indicator: BoxDecoration(
                                color: ThemeColors().buttonColor,
                              ),
                              isScrollable: true,
                              tabs: soulProfile_ViewModel.interaction!.interact!.map((e) {
                                return Tab(
                                  text: e.name,
                                );
                              }).toList(),
                            ),
                          ),
                          Expanded(
                              child: TabBarView(
                            controller: _tabController,
                            children: soulProfile_ViewModel.interaction!.interact!.map((e) {
                              return ExploreTab(
                                tabIndex: soulProfile_ViewModel.interaction!.interact!.indexOf(e),
                                details: e.details!,
                                profiles: e.interactWith!,
                                image: e.image == null ? "1.png" : e.image!
                              );
                            }).toList(),
                          )),
                        ],
                      ),
                    ),
                  ],
                );

  }
}
