import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Components/MultipleSelectionButtons/MultipleCheckBox.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/Routes.dart';

import '../../Components/Buttons/CustomButton.dart';
import '../../Components/DropDowns/CustomDropDown1.dart';
import '../../Components/Headers/HeaderWithBackIcon.dart';

import '../../Components/RadioButtons/CustomRadioButtons.dart';
import '../../Utils/Common/varaible.dart';
import '../../Utils/Constants.dart';
import '../../Utils/Controller/model/profile.model.dart';
import '../../Utils/ThemeColors.dart';
import 'package:soul_milan/Utils/Controller/api.dart';

import '../../view_model/SoulProfile_ViewModel.dart';
import '../../view_model/SoulProfilesTimeline_ViewModel.dart';
import '../../view_model/SubscriptionPackage_ViewModel.dart';

class PreferredFormScreen extends StatefulWidget {
  const PreferredFormScreen({Key? key}) : super(key: key);

  @override
  State<PreferredFormScreen> createState() => _PreferredFormScreenState();
}

class _PreferredFormScreenState extends State<PreferredFormScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController ageController = TextEditingController();

  List<String> selectedInterests = [];

  bool isLoading = false;
  int isRelocate = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: headerPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: HeaderWithBackIcon(
                        title: "Preferred Filter",
                        subtitle:
                            "Connecting like-minded individuals through preference.",
                        onTap: (){
                          Get.back();
                        },
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: mainBodyPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.02),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title: Text(
                            "Marriage Plans",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          children: [
                            MultipleCheckBox(
                              arrayNameOptions: marriagePlansItems,
                              // selectionArray: selectedMarriagePlans,
                              selectionArray: preferredFilter.marriagePlans,
                              allowMultipleSelection: false,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.02),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title: Text(
                            "Relocation Plans",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          children: [
                            MultipleCheckBox(
                              arrayNameOptions: relocationItems,
                              // selectionArray: selectedRelocation,
                              selectionArray: preferredFilter.relocationPlans,
                              allowMultipleSelection: false,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.02),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title: Text(
                            "Family Plans",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          children: [
                            MultipleCheckBox(
                              arrayNameOptions: familyPlansItems,
                              // selectionArray: selectedFamilyPlans,
                              selectionArray: preferredFilter.familyPlans,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.02),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title: Text(
                            "Religious Practice",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          children: [
                            MultipleCheckBox(
                              arrayNameOptions: religiousPracticeItems,
                              // selectionArray: selectedReligiousPractice,
                              selectionArray:
                                  preferredFilter.religiousPractices,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.02),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title: Text(
                            "Praying",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          children: [
                            MultipleCheckBox(
                              arrayNameOptions: prayingItems,
                              // selectionArray: selectedPraying,
                              selectionArray: preferredFilter.praying,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.02),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title: Text(
                            "Islamic Dress",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          children: [
                            MultipleCheckBox(
                              arrayNameOptions: islamicDressItems,
                              // selectionArray: selectedIslamicDress,
                              selectionArray: preferredFilter.islamicDress,
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: Get.height * 0.02),
                      //   child: ExpansionTile(
                      //       tilePadding: EdgeInsets.zero,
                      //       title: Text(
                      //         "Education",
                      //         style: Theme.of(context).textTheme.labelMedium,
                      //       ),
                      //       children: [
                      //         MultipleCheckBox(
                      //           arrayNameOptions: educationItems,
                      //           selectionArray: selectedEducation,),
                      //       ],
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.06),
                        child: Consumer<SoulProfile_ViewModel>(builder: (context, soulProfile_ViewModel, child) => 
                           CustomButton(
                            // isDisabled: false,
                            name: "Update",
                            isLoading: isLoading,
                            onClick: () => nextScreen(soulProfile_ViewModel),
                            color: ThemeColors().buttonColor,
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _indexOf(List<String> arrayToSearch, String element) {
    return arrayToSearch.indexOf(element).toString();
  }

  void nextScreen(SoulProfile_ViewModel soulProfile_ViewModel) async {
    setState(() {
      isLoading = true;
    });

    if (preferredFilter.marriagePlans.isEmpty &&
        preferredFilter.relocationPlans.isEmpty &&
        preferredFilter.familyPlans.isEmpty &&
        preferredFilter.religiousPractices.isEmpty &&
        preferredFilter.praying.isEmpty &&
        preferredFilter.islamicDress.isEmpty) {
      Get.snackbar(
        backgroundColor: CustomTheme().errorColor,
        colorText: Colors.white,
        "Error",
        "Atleast fill one(1) Field",
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    Map<String, dynamic> preferfilter = {
      "uID": soulProfile_ViewModel.profileOverview!.profileData!.uId!,
      "marriagePlans": preferredFilter.marriagePlans.isNotEmpty
          ? _indexOf(marriagePlansItems, preferredFilter.marriagePlans[0])
          : "null",
      "relocationPlans": preferredFilter.relocationPlans.isNotEmpty
          ? _indexOf(relocationItems, preferredFilter.relocationPlans[0])
          : "null",
      "familyPlans": "${preferredFilter.familyPlans.toString()}",
      "religiousPractices": preferredFilter.religiousPractices.isNotEmpty
          ? _indexOf(
              religiousPracticeItems, preferredFilter.religiousPractices[0])
          : "null",
      "praying": preferredFilter.praying.isNotEmpty
          ? _indexOf(prayingItems, preferredFilter.praying[0])
          : "null",
      "islamicDress": preferredFilter.islamicDress.isNotEmpty
          ? _indexOf(islamicDressItems, preferredFilter.islamicDress[0])
          : "null",
    };
    var response = await connector.post("$prefer/add", preferfilter);
    if (response != null && response["success"]) {
      preferenceInfo = preferfilter;
      List<String> ageList;
      ageList = age.split("-").map((age) => age.trim()).toList();
      
      await updateMainFilter(soulProfile_ViewModel,{
        "gender": soulProfile_ViewModel.getGender().toString(),
        "age": ageList.toString(),
        "preferenceFilter": jsonEncode(preferenceInfo),
        "education": mainFilter.educationFilter
        // "height": '0',
        // "education" : "0",
        // "city": "0"
      });

      var mainFilterData = await api.getWithToken(
          "$prefer/filter/${soulProfile_ViewModel.profileOverview!.profileData!.uId!}", soulProfile_ViewModel.profileVerification!.getAccessToken());
      if (mainFilterData != null && mainFilterData["success"]) {
        storge.write("mainFilterData", mainFilterData);
      }

      var preferenceFilter = await api.getWithToken(
          "$prefer/${soulProfile_ViewModel.profileOverview!.profileData!.uId!}", soulProfile_ViewModel.profileVerification!.getAccessToken());
      if (preferenceFilter["success"] != null &&
          preferenceFilter["success"] == true) {
        var preferData = preferenceFilter["response"];
        storge.write("preferData", preferData);
        preferenceInfo = preferData;
      }

      // if (responseFilter != null && responseFilter["success"]) {
      //   Get.snackbar(
      //     backgroundColor: ThemeColors().buttonColor,
      //     colorText: Colors.white,
      //     "Match My Perfect Soul",
      //     "Your changes have been updated.",
      //     duration: const Duration(seconds: 1),
      //   );
      // } else {
      //   Get.snackbar(
      //     backgroundColor: CustomTheme().errorColor,
      //     colorText: Colors.white,
      //     "Error",
      //     "Fields Missing.",
      //   );
      // }
    } else {
      Get.snackbar(
        backgroundColor: CustomTheme().errorColor,
        colorText: Colors.white,
        "Error",
        "Fields Missing.",
      );
    }

    setState(() {
      isLoading = false;
    });
    Get.snackbar(
          backgroundColor: ThemeColors().buttonColor,
          colorText: Colors.white,
          "Preference",
          "Your preference have been updated.",
          duration: const Duration(seconds: 1),
        );
  }

  void dropDownValueMarriagePlans(value) {
    setState(() {
      marriagePlans = value as String;
    });
  }

  // updateMainFilter(filter) async {
  //   var response = await connector.post("$match/${userProfile.id}", filter);

  //   if (response["success"] != null && response["success"]) {
  //     for (var element in response["profiles"].keys.toList()) {
  //       user[element] = response["profiles"][element].map<Profiles>((e) {
  //         return Profiles.fromJson(e);
  //       }).toList();
  //     }
  //   }
  //   return response;
  // }

  updateMainFilter(SoulProfile_ViewModel soulProfile_ViewModel,filter) async {
    //var response = await connector.post("$match/${userProfile.id}", filter);

    SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel = Provider.of<SoulProfilesTimeline_ViewModel>(context, listen:  false);
     SubscriptionPackage_ViewModel subscriptionPackage_ViewModel = Provider.of<SubscriptionPackage_ViewModel>(context, listen: false);

    await soulProfilesTimeline_ViewModel.showProfiles(
      soulProfile_ViewModel.profileOverview!.profileData!.uId!, 
      filter,
      soulProfile_ViewModel.profileVerification!.getAccessToken(),
      subscriptionPackage_ViewModel.currentPackageType
      );    

    // if (response["success"] != null && response["success"]) {
    //   for (var element in response["profiles"].keys.toList()) {
    //     user[element] = response["profiles"][element].map<Profiles>((e) {
    //       return Profiles.fromJson(e);
    //     }).toList();
    //   }
    // }
    // return response;
  }
}
