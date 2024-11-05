  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:soul_milan/Utils/Common/CommonFunction.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';
import 'package:soul_milan/view_model/InstantChat_ViewModel.dart';
import 'package:soul_milan/view_model/SubscriptionPackage_ViewModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../Utils/Constants.dart';
import '../../Utils/Controller/model/Cities.model.dart';
import '../../Utils/Controller/model/PackageDetails.model.dart';
import '../../Utils/Controller/model/mainFilter.model.dart';
import '../../Utils/Controller/model/preferred.model.dart';
import '../../Utils/Routes.dart';
import '../../view_model/SoulProfile_ViewModel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      _initializeApp();
    });
  }

  void _initializeApp() async {
    await checkInternetConnectivity()
        ? goToRoute()
        : Get.offAndToNamed(RoutesClass.noInternetScreen);
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  goToRoute() async {
    CommonFunction commonFunction = CommonFunction();

    storge = GetStorage();
    var isUserLogin = (storge.read('uid')) ?? "";

    var profileVerification = storge.read("profileVerification");

    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
    InstantChats_ViewModel instantChats_ViewModel = Provider.of<InstantChats_ViewModel>(context, listen: false);

    if (profileVerification != null) {
      soulProfile_ViewModel.LoadProfileVerification_FromStorage(profileVerification);
      connector = Connector(soulProfile_ViewModel.profileVerification!.getAccessToken());
      instantChats_ViewModel.LoadInstantChats(soulProfile_ViewModel.profileVerification!.uID!, soulProfile_ViewModel.profileVerification!.getAccessToken());
    } else {
      connector = Connector(storge.read('token'));
    }

    var mainFilterData = storge.read("mainFilterData");
    if (mainFilterData != null) {
      selectedHeightInRange = {
        "min": mainFilterData["minHeightFilter"],
        "max": mainFilterData["maxHeightFilter"]
      };

      age = "${mainFilterData["minAgeFilter"]} - ${mainFilterData["maxAgeFilter"]}";
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
        cityDataFilter: CityData(cid: "6b090cf8", nid: "", name: "Karachi", status: 1),
      );
    }

    var preferData = storge.read("preferData");
    if (preferData != null) {
      preferenceInfo = preferData;
      preferredFilter = PreferredFilter(
        marriagePlans: preferData["marriagePlans"] != null
            ? [marriagePlansItems[commonFunction.getIndexOf(marriagePlansItems, marriagePlansItems[preferData["marriagePlans"]])]]
            : [],
        relocationPlans: preferData["relocationPlans"] != null
            ? [relocationItems[commonFunction.getIndexOf(relocationItems, relocationItems[preferData["relocationPlans"]])]]
            : [],
        familyPlans: preferData["familyPlans"] != null ? List<String>.from(jsonDecode(preferData["familyPlans"])) : [],
        religiousPractices: preferData["religiousPractices"] != null
            ? [religiousPracticeItems[commonFunction.getIndexOf(religiousPracticeItems, religiousPracticeItems[preferData["religiousPractices"]])]]
            : [],
        praying: preferData["praying"] != null
            ? [prayingItems[commonFunction.getIndexOf(prayingItems, prayingItems[int.parse(preferData["praying"])])]]
            : [],
        islamicDress: preferData["islamicDress"] != null
            ? [islamicDressItems[commonFunction.getIndexOf(islamicDressItems, islamicDressItems[int.parse(preferData["islamicDress"])])]]
            : [],
      );
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

    if (profileVerification != null) {
      String token = soulProfile_ViewModel.profileVerification!.getAccessToken();
      await loadCities();
      SubscriptionPackage_ViewModel subscriptionPackage_ViewModel = Provider.of<SubscriptionPackage_ViewModel>(context, listen: false);
      await subscriptionPackage_ViewModel.LoadSubscriptionPackages();
      await subscriptionPackage_ViewModel.CheckMemberShip(soulProfile_ViewModel.profileVerification!.uID!, token, instantChats_ViewModel);
    } else {
      await Future.delayed(Duration(seconds: 0));
    }
    var screen = storge.read('screen') ?? RoutesClass.onBoardingScreen;
    Get.offAndToNamed(screen);
  }

  loadCities() async {
    var cityData = await api.get("$getdropDown/cities");
    if (cityData["success"] != null && cityData["success"] == true && cityData != null) {
      cities = Cities.fromJson({"cityList": cityData["cityList"]});
    } else {
      loadCities();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShowUpAnimation(
              animationDuration: const Duration(milliseconds: 800),
              curve: Curves.linear,
              direction: Direction.vertical,
              offset: 0,
              child: Image.asset(
                'assets/images/soulmilan_flower_logo.png',
              ),
            ),
            ShowUpAnimation(
              animationDuration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutSine,
              direction: Direction.vertical,
              offset: 20,
              child: Text.rich(
                TextSpan(
                  text: 'SOUL',
                  style: TextStyle(color: ThemeColors().soulColor, fontSize: 40, fontWeight: FontWeight.bold,),
                  children: [
                    TextSpan(
                      text: ' MILUN',
                      style: TextStyle(color: ThemeColors().milanColor, fontSize: 40, fontWeight: FontWeight.bold,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
