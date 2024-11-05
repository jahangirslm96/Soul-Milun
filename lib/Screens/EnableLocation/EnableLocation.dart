import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Components/AlertBox/DialogBox1.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/Routes.dart';
import '../../Utils/Common/CommonFunction.dart';
import '../../Utils/Controller/model/Cities.model.dart';
import '../../Utils/Controller/model/ProfileModel/profileVerification.model.dart';
import '../../Utils/Controller/model/mainFilter.model.dart';
import '../../Utils/Controller/model/preferred.model.dart';
import '../../Utils/Controller/model/profile.model.dart';
import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';

import 'package:geolocator/geolocator.dart';

import '../../view_model/InstantChat_ViewModel.dart';
import '../../view_model/SoulProfile_ViewModel.dart';
import '../../view_model/SubscriptionPackage_ViewModel.dart';

class EnableLocation extends StatefulWidget {
  const EnableLocation({Key? key}) : super(key: key);

  @override
  State<EnableLocation> createState() => _EnableLocationState();
}

class _EnableLocationState extends State<EnableLocation> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connector = Connector(storge.read("token"));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: subscriptionBodyPadding,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.018,
                    ),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: "SOUL",
                          style: TextStyle(
                            color: ThemeColors().soulColor,
                            fontSize:
                                CustomTheme().soulMilanSubscriptionFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: " MILUN",
                              style: TextStyle(
                                color: ThemeColors().milanColor,
                                fontSize:
                                    CustomTheme().soulMilanSubscriptionFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: mainBodyPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Oops! It seems your Location is Disabled!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: ThemeColors().buttonColor,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Get.height * 0.1),
                          child: Image.asset(
                            "assets/images/enable_location.png",
                            scale: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: mainBodyPadding,
                child: Padding(
                  padding: EdgeInsets.only(bottom: Get.height * 0.06),
                  child: Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Note:",
                          style: TextStyle(
                            color: CustomTheme().errorColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  " To ensure a seamless connection with nearby souls, enabling location access is mandatory.",
                              style: TextStyle(
                                color: ThemeColors().buttonColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.01),
                        child: CustomButton(
                          name: "Enable Location",
                          isLoading: isLoading,
                          onClick: _determinePosition,
                          color: ThemeColors().buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogBox1(
            heading: "Location Access Denied",
            subHeading: "It is mandatory to allow Location Permission.",
            buttonText: "OK",
            onTap: () {
              Get.back();
            },
          );
        },
      );
      return;
    } else if (permission == LocationPermission.deniedForever) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogBox1(
              heading: "Location Access Denied Permanently",
              subHeading: "Please enable location permissions from settings to continue.",
              buttonText: "OK",
              onTap: (){
                Get.back();
                Geolocator.openAppSettings();
              }
          );
        },
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    Position position = await Geolocator.getCurrentPosition();
    var url = "profile/${storge.read("uid")}/$updateLocation";
    for(int i = 0; i < 3; i++){
      var respone = await connector.post(url, {
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString(),
    });

    dynamic data = await InitiateLogin();
    if (respone != null && data != null && data["success"]) {
      storge.write("screen", RoutesClass.homeScreen);
      Get.offAndToNamed(RoutesClass.homeScreen);
    }
    }
    
  }

  dynamic InitiateLogin() async{
    CommonFunction commonFunction = CommonFunction();
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
    dynamic data = await soulProfile_ViewModel.LoginAccount(storge.read('email'), "", storge.read('token'));
      InstantChats_ViewModel instantChats_ViewModel = Provider.of<InstantChats_ViewModel>(context, listen: false);
   var screen = RoutesClass.homeScreen;
        storge.write("profileVerification", soulProfile_ViewModel.profileVerification!.toJson());

        String uId = soulProfile_ViewModel.profileVerification!.uID!;
        String token = soulProfile_ViewModel.profileVerification!.getAccessToken();
        
        instantChats_ViewModel.LoadInstantChats(uId, token);

        storge.write("uid", data["ProfileData"]["uID"]);
        storge.write("token", data["ProfileData"]["token"]["access"]["token"]);

        var temp = data["ProfileData"];

        temp['profileDetails']["id"] = temp["uID"];
        userProfile = Profiles.fromJson(temp['profileDetails']);

        
        var mainFilterData = await api.getWithToken(
            "$prefer/filter/$uId",
            token);

        if (mainFilterData != null && mainFilterData["success"]) {
          storge.write("mainFilterData", mainFilterData);

          selectedHeightInRange = {
            "min": mainFilterData["minHeightFilter"],
            "max": mainFilterData["maxHeightFilter"]
          };

          age =
              "${mainFilterData["minAgeFilter"]} - ${mainFilterData["maxAgeFilter"]}";
          mainFilter = MainFilter.fromJson(mainFilterData);

        } else {
          selectedHeightInRange = {
            "min": heightInRangeElement[0]["min"]!,
            "max": heightInRangeElement[0]["max"]!
          };
          age = ageItems[0];
          List<String> ageValues = age.split(" - ");
          String minAge = ageValues[0];
          String maxAge = ageValues[1];
          mainFilter = MainFilter(
              minAgeFilter: minAge,
              maxAgeFilter: maxAge,
              minHeightFilter: heightInRangeElement[0]["min"].toString(),
              maxHeightFilter: heightInRangeElement[0]["max"].toString(),
              educationFilter: educationItems[0],
              cityDataFilter: CityData(
                  cid: "6b090cf8", nid: "", name: "Karachi", status: 1));
        }

        var cityData = await api.get("$getdropDown/cities");
        cities = Cities.fromJson({"cityList": cityData["cityList"]});

        var preferenceFilter = await api.getWithToken("$prefer/$uId",token);
        print(preferenceFilter);
        if (preferenceFilter["success"] != null &&
            preferenceFilter["success"] == true) {
          var preferData = preferenceFilter["response"];
          storge.write("preferData", preferData);
          preferenceInfo = preferData;
          preferredFilter = PreferredFilter(
              marriagePlans: preferData["marriagePlans"] != null
                  ? [
                      marriagePlansItems[commonFunction.getIndexOf(marriagePlansItems,
                          marriagePlansItems[preferData["marriagePlans"]])]
                    ]
                  : [],
              relocationPlans: preferData["relocationPlans"] != null
                  ? [
                      relocationItems[commonFunction.getIndexOf(relocationItems,
                          relocationItems[preferData["relocationPlans"]])]
                    ]
                  : [],
              familyPlans: preferData["familyPlans"] != null
                  ? List<String>.from(jsonDecode(preferData["familyPlans"]))
                  : [],
              religiousPractices: preferData["religiousPractices"] != null
                  ? [
                      religiousPracticeItems[commonFunction.getIndexOf(
                          religiousPracticeItems,
                          religiousPracticeItems[
                              preferData["religiousPractices"]])]
                    ]
                  : [],
              praying: preferData["praying"] != null
                  ? [
                      prayingItems[commonFunction.getIndexOf(prayingItems,
                          prayingItems[int.parse(preferData["praying"])])]
                    ]
                  : [],
              islamicDress: preferData["islamicDress"] != null
                  ? [
                      islamicDressItems[commonFunction.getIndexOf(
                          islamicDressItems,
                          islamicDressItems[
                              int.parse(preferData["islamicDress"])])]
                    ]
                  : []);
        } else {
          preferredFilter = PreferredFilter(
            marriagePlans: [],
            relocationPlans: [],
            familyPlans: [],
            religiousPractices: [],
            praying: [],
            islamicDress: [],
          );
        }
        // var userPackage = await api.getWithToken("$package/info/$uId",token);

        // if (userPackage["success"] != null &&
        //     userPackage["success"] == true &&
        //     userPackage != null) {
        //   packageDetails = PackageDetails.fromJson(userPackage["response"]);
        //   currentPackageType = getPackageFromString(packageDetails.package!);
        // } else if (userPackage["response"] == null) {
        //   packageDetails = PackageDetails();
        //   currentPackageType = PackageType.NONE;
        // } else {}

        ProfileVerification profileVerification = soulProfile_ViewModel.profileVerification!;
        if(profileVerification != null){
          String token = soulProfile_ViewModel.profileVerification!.getAccessToken();
          SubscriptionPackage_ViewModel subscriptionPackage_ViewModel = Provider.of<SubscriptionPackage_ViewModel>(context, listen: false);
          await subscriptionPackage_ViewModel.LoadSubscriptionPackages();
          await subscriptionPackage_ViewModel.CheckMemberShip(soulProfile_ViewModel.profileVerification!.uID!,token,instantChats_ViewModel);
          // await CheckMemberShip(soulProfile_ViewModel.profileVerification!.uID!, token);
        }

        return data;
  }
}
