import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Common/CommonFunction.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/Cities.model.dart';
import 'package:soul_milan/Utils/Controller/model/ProfileModel/profileVerification.model.dart';
import 'package:soul_milan/Utils/Controller/model/mainFilter.model.dart';
import 'package:soul_milan/Utils/Controller/model/preferred.model.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';

import '../../../Components/Buttons/CustomButton.dart';
import '../../../Components/Textfields/CustomPasswordTextfield.dart';
import '../../../Components/Textfields/CustomTextfield3.dart';
import '../../../Utils/Controller/model/PackageDetails.model.dart';
import '../../../Utils/Routes.dart';
import '../../../Utils/ThemeColors.dart';
import '../../../Utils/Constants.dart';
import '../../../view_model/InstantChat_ViewModel.dart';
import '../../../view_model/SoulProfilesTimeline_ViewModel.dart';
import '../../../view_model/SubscriptionPackage_ViewModel.dart';
import '../../../view_model/TourPartners_ViewModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark, // status bar color
    ));
    return 
        AbsorbPointer(
          absorbing:  isLoading, //value.loading,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: mainBodyPadding,
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.01),
                            child: Image.asset(
                              'assets/images/soulmilan_flower_logo.png',
                              height: Get.height * 0.25,
                              width: Get.width * 0.6,
                            ),
                          ),
                        ),
                        Center(
                          child: Text.rich(
                            TextSpan(
                                text: 'SOUL',
                                style: Theme.of(context).textTheme.displayLarge,
                                children: [
                                  TextSpan(
                                    text: ' MILUN',
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        CustomTextfield3(
                            controller: emailController,
                            label: "Email"),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        CustomPasswordTextfield(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                            },
                          controller: passwordController,
                          label: "Password",
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: toForgetPassScreen,
                              child: Text(
                                'Forget Password?',
                                style: Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.snackbar("Sorry, we are working on it", "we will update it soon");
                            },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Alternative Login',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Image.asset(
                            'assets/images/fingerprint.png',
                            height: Get.height * 0.05,
                            width: Get.width * 0.15,
                          ),
                        ],
                      ),
                    ),
                    Consumer<SoulProfile_ViewModel>(builder: (context, value, child) =>
                        CustomButton(
                          isLoading: isLoading,//value.loading,
                          name: "Login",
                          color: ThemeColors().buttonColor,
                          onClick: () => ProceedLogin(value),
                        )
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        GestureDetector(
                          onTap: toSignUpScreen,
                          child: Text(
                            "Sign Up",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toForgetPassScreen() async {
    Get.toNamed(RoutesClass.forgetPasswordScreen);
  }

  void toSignUpScreen() async {
    storge.write("screen", RoutesClass.signupPage);
    Get.offAndToNamed(RoutesClass.signupPage);
  }

  // int _indexOf(List<dynamic> arrayToSearch, dynamic element) {
  //   return arrayToSearch.indexOf(element);
  // }

  ProceedLogin(SoulProfile_ViewModel soulProfile_ViewModel){
    nextScreen(soulProfile_ViewModel);
  }

  nextScreen(SoulProfile_ViewModel soulProfile_ViewModel) async {
    setState(() {
      isLoading = true;
    });
    resetDataFromProvider();
    await Future.delayed(const Duration(milliseconds: 100));

    if (_formKey.currentState!.validate()) {

      CommonFunction commonFunction = CommonFunction();
      dynamic data = await soulProfile_ViewModel.LoginAccount(emailController.text, passwordController.text, "");
      InstantChats_ViewModel instantChats_ViewModel = Provider.of<InstantChats_ViewModel>(context, listen: false);
      // if correct then go to home screen
      if (data != null && data["success"]) {
        var screen = RoutesClass.homeScreen;
        storge.write("profileVerification", soulProfile_ViewModel.profileVerification!.toJson());

        String uId = soulProfile_ViewModel.profileVerification!.uID!;
        String token = soulProfile_ViewModel.profileVerification!.getAccessToken();
        
        instantChats_ViewModel.LoadInstantChats(uId, token);

        storge.write("uid", data["ProfileData"]["uID"]);
        storge.write("token", data["ProfileData"]["token"]["access"]["token"]);
        storge.write('email',emailController.text);
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

        if (profileVerification.isVerified == 0) {
          screen = RoutesClass.verificationScreen;
        } else if (profileVerification.isProfileComplete == 0) {
          screen = RoutesClass.publicInfoScreen;
        } else if (profileVerification.isInterest != null && profileVerification.isInterest == 0) {
          screen = RoutesClass.interestScreen;
        } else if (profileVerification.isSelfieVerified != null && profileVerification.isSelfieVerified == 0) {
          screen = RoutesClass.selfieCheckScreen;
        } else if ((profileVerification.isLocation != null && profileVerification.isLocation == 0) &&
            !(await Permission.location.status.isGranted)) {
          screen = RoutesClass.enableLocationScreen;
        }
        storge.write("screen", screen);
        Get.offAndToNamed(screen);
      } else {
        Get.snackbar("Incorrect Email, Password",
            "User not found, pls recheck your email and password");
      }
    }

    setState(() {
      isLoading = false;
    });
  }

    resetDataFromProvider(){
    InstantChats_ViewModel instantChats_ViewModel = Provider.of<InstantChats_ViewModel>(context, listen: false);
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
    SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel = Provider.of<SoulProfilesTimeline_ViewModel>(context, listen: false);
    SubscriptionPackage_ViewModel subscriptionPackage_ViewModel = Provider.of<SubscriptionPackage_ViewModel>(context, listen: false);
    TourPartners_ViewModel tourPartners_ViewModel = Provider.of<TourPartners_ViewModel>(context, listen: false);

    instantChats_ViewModel.resetData();
    soulProfile_ViewModel.resetData();
    soulProfilesTimeline_ViewModel.resetData();
    subscriptionPackage_ViewModel.resetData();
    tourPartners_ViewModel.resetData();
  }
}
