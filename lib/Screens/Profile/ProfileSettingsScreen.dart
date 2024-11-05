import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:soul_milan/Components/Rows/CustomRow.dart';
import 'package:share/share.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/view_model/InstantChat_ViewModel.dart';
import 'package:soul_milan/view_model/SoulProfilesTimeline_ViewModel.dart';
import 'package:soul_milan/view_model/SubscriptionPackage_ViewModel.dart';
import 'package:soul_milan/view_model/TourPartners_ViewModel.dart';

import '../../Components/AlertBox/DialogBox1.dart';
import '../../Components/AlertBox/EarnDialogBox.dart';
import '../../Components/AlertBox/LogoutDialog.dart';
import '../../Components/Headers/ProfileHeader.dart';
import '../../Components/NavigationBar/CustomBottomNavigationBar.dart';
import '../../Components/Rows/ProfileInfoRow.dart';
import '../../Utils/Constants.dart';
import '../../Utils/Controller/model/PackageDetails.model.dart';
import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';
import '../../view_model/SoulProfile_ViewModel.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool isSubscribed = true;
  bool isTapped1 = false;
  bool isTapped2 = false;

  List<Color> originalGradientColors = [Colors.purple, Colors.pink.shade400, ThemeColors().soulColor];


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark, // status bar color
    ));

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                /*Padding(
                  padding: mainBodyPadding4,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.018,
                      ),
                      const ProfileHeader(
                        title: "Settings",
                      ),
                    ],
                  ),
                ),*/
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.02,
                      horizontal: Get.width * 0.06),
                  child: const ProfileInfoRow(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: Get.height * 0.02, left: Get.width * 0.05, right: Get.width * 0.05),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                              setState(() {
                                isTapped1 = true;
                              });
                              Get.toNamed(RoutesClass.subscriptionScreen);
                              setState(() {
                                isTapped1 = false;
                              });
                          },
                          onTapDown: (_) {
                            setState(() {
                              isTapped1 = true;
                            });
                          },
                          onTapCancel: () {
                            setState(() {
                              isTapped1 = false;
                            });
                          },
                          child: ColorFiltered(
                            colorFilter: isTapped1
                                ? ColorFilter.mode(
                              Colors.black.withOpacity(0.5),
                              BlendMode.srcATop,
                            )
                                : const ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.srcATop,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: Get.height * 0.02, horizontal: Get.width * 0.02),
                              height: Get.height * 0.27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: originalGradientColors,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(0.0, 2.0), // (dx, dy)
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Consumer<SubscriptionPackage_ViewModel>(builder: (context, subscriptionPackage_ViewModel, child) => 
                                  _buildSubscriptionBox(subscriptionPackage_ViewModel)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.09,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                              setState(() {
                                isTapped2 = true;
                              });
                              Get.toNamed(RoutesClass.subscriptionScreen);
                              setState(() {
                                isTapped2 = false;
                              });
                          },
                          onTapDown: (_) {
                            setState(() {
                              isTapped2 = true;
                            });
                          },
                          onTapCancel: () {
                            setState(() {
                              isTapped2 = false;
                            });
                          },
                          child: ColorFiltered(
                            colorFilter: isTapped2
                                ? ColorFilter.mode(
                              Colors.black.withOpacity(0.5),
                              BlendMode.srcATop,
                            )
                                : const ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.srcATop,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: Get.height * 0.02, horizontal: Get.width * 0.02),
                              height: Get.height * 0.27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: originalGradientColors,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(0.0, 2.0), // (dx, dy)
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                   Consumer<InstantChats_ViewModel>(builder: (context, value, child) {
                                    return  _InstantChatUI(value);
                                   },),
                                    const Text(
                                      "Instant Chats",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    const Text(
                                      "Get free instant daily chats with our premium packages!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.02),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.012, horizontal: Get.width * 0.04),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: const Text(
                                        "Get More",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: Divider(
                    color: ThemeColors().containerOutlineColor,
                    thickness: Get.height *0.0005,
                  ),
                ),
                ListView.builder(
                  itemCount: profileSettingsRows.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CustomRow(
                    index: index,
                    isSpecial: profileSettingsRows[index]["title"] ==
                        "Become Income Generator" || profileSettingsRows[index]["title"] ==
                        "Preffered Form",
                    onClick: onClickMenu,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        ),
      ),
    );
  }

  _buildSubscriptionBox(SubscriptionPackage_ViewModel subscriptionPackage_ViewModel){

    if(subscriptionPackage_ViewModel.currentPackageType != PackageType.NONE){
      return
     Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      subscriptionPackage_ViewModel.getPackageStringName(),
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      "Subscribed",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    const Text(
                                      "Premium features and exclusive content available!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.02),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.012, horizontal: Get.width * 0.04),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: const Text(
                                        "Upgrade",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
    }

    return  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Buy",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      "Subscriptions",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    const Text(
                                      "Unlock premium features and exclusive content!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.02),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.012, horizontal: Get.width * 0.04),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: const Text(
                                        "Upgrade",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
  }

  _Test(int value){
    print("testing "+value.toString());
  }
  _InstantChatUI(InstantChats_ViewModel instantChats_ViewModel){
    if(instantChats_ViewModel.loading){
      return const Text(
              "-",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
    }

    return Text(
            instantChats_ViewModel.GetInstantChats!.chats.toString(),
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
  }

  onClickMenu(int index) {
    if (profileSettingsRows[index]["route"] != null) {
      Get.toNamed(profileSettingsRows[index]["route"]);
    } else if (profileSettingsRows[index]["method"] == 1) {
      inviteFriend();
    } else if (profileSettingsRows[index]["method"] == 3) {
      incomeGenerator();
    } else if (profileSettingsRows[index]["method"] == 4){
      reDirectToPreferredForm();
    } 
    else {
      logout();
    }
  }

  incomeGenerator() {
    SubscriptionPackage_ViewModel subscriptionPackage_ViewModel = Provider.of<SubscriptionPackage_ViewModel>(context, listen: false);
    if (subscriptionPackage_ViewModel.currentPackageType != PackageType.NONE) {
      Get.toNamed(RoutesClass.incomeGeneratorScreen);
    } else {
      showDialog(
        context: context,
        builder: (context) => const EarnDialogBox(),
      );
    }
  }

   reDirectToPreferredForm() {
    SubscriptionPackage_ViewModel subscriptionPackage_ViewModel = Provider.of<SubscriptionPackage_ViewModel>(context, listen: false);
    if (subscriptionPackage_ViewModel.currentPackageType != PackageType.NONE) {
      Get.toNamed(RoutesClass.preferredFormScreen);
    } else {
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
      );
    }
  }

  inviteFriend() {
    Share.share('$text $url');
  }

  logout() async {
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => LogoutDialog(
        onLogout: () async {
          var response = await  connector.get('auth/logout/${soulProfile_ViewModel.profileVerification!.uID}');
          if(response["success"] == true){
            IsFCMLoaded = false;
            initStaticVariable().initialization();
            storge.erase();
            storge.write("screen", RoutesClass.logInPage);
            Get.offAllNamed(RoutesClass.logInPage);
            isLogout = true;
            selectedIndex = 0;
          }
        },
      ),
    );
  }
}
