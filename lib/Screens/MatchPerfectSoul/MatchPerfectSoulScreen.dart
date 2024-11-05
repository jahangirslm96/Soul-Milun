import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Common/CommonFunction.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/view_model/SoulProfilesTimeline_ViewModel.dart';

import '../../Components/Buttons/CustomButton.dart';
import '../../Components/DropDowns/CustomDropDown1.dart';
import '../../Components/Headers/CustomHeader.dart';
import '../../Components/Headers/HeaderWithBackIcon.dart';

import '../../Components/MultipleSelectionButtons/MultipleCheckBox.dart';
import '../../Components/Sliders/AgeRangeSlider.dart';
import '../../Utils/Common/varaible.dart';
import '../../Utils/Constants.dart';
import '../../Utils/Controller/model/Cities.model.dart';
import '../../Utils/Controller/constant.dart';
import '../../Utils/Controller/model/profile.model.dart';
import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import '../../view_model/SoulProfile_ViewModel.dart';
import '../../view_model/SubscriptionPackage_ViewModel.dart';

class MatchPerfectSoulScreen extends StatefulWidget {
  const MatchPerfectSoulScreen({Key? key}) : super(key: key);

  @override
  State<MatchPerfectSoulScreen> createState() => _MatchPerfectSoulScreenState();
}

class _MatchPerfectSoulScreenState extends State<MatchPerfectSoulScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  List<String> selectedInterests = [];

  bool isLoading = false;
  Map<String, CityData> dropDownCities = {};

  CityData? selectedCity;
  late RangeValues rangeValues;
  CommonFunction commonFunction = CommonFunction();

  @override
  void initState() {
    // TODO: implement initState

    for (var city in cities.cityList) {
      dropDownCities[city.name] = CityData(
          cid: city.cid, nid: city.nid, name: city.name, status: city.status);
    }

    selectedCity = findCity(mainFilter.cityDataFilter);
    selectedEducation = [
      educationItems[commonFunction.getIndexOf(educationItems, mainFilter.educationFilter)]
    ];
    var tempSelectedHeightInRange = selectedHeightInRange;
    Map<String, dynamic>? matchedRange =
        findMatchingRange(heightInRangeElement, selectedHeightInRange);
    if (matchedRange != null) {
      selectedHeightInRange = matchedRange;
      heightInRange = commonFunction.formatHeightRange(selectedHeightInRange);
      // print("matching range found.");
    } else {
      // print("No matching range found.");
    }
    rangeValues = RangeValues(
        mainFilter.minAgeFilter != null
            ? int.parse(mainFilter.minAgeFilter).toDouble()
            : 18,
        mainFilter.maxAgeFilter != null
            ? int.parse(mainFilter.maxAgeFilter).toDouble()
            : 55);
    //rangeValues = RangeValues(18, 20);
    super.initState();
  }

  Map<String, dynamic>? findMatchingRange(
      List<Map<String, dynamic>> ranges, Map<String, dynamic> selectedRange) {
    for (var range in ranges) {
      if (range['min'] == selectedRange['min'] &&
          range['max'] == selectedRange['max']) {
        return range;
      }
    }
    return null;
  }

  CityData? findCity(CityData cityObject) {
    try {
      return dropDownCities.values
          .firstWhere((city) => city.cid == cityObject.cid);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: AbsorbPointer(
              absorbing: isLoading,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 12),
                    child:  const Column(
                      children: [
                        CustomHeader(
                          name: "Main Filter",
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: ThemeColors().containerOutlineColor,
                    thickness: Get.height *0.0005,
                  ),
                  Padding(
                    padding: mainBodyPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add your interest you want to look in your Partner. We’ll use this info to suggest matches.",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        /*Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.04),
                          child: Text(
                            "Age",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        CustomDropDown1(
                          product: age,
                          productItems: ageItems,
                          onChanged: dropDownValueAge,
                          label: "Age",
                        ),*/
                        AgeRangeSlider(
                          initialAge: 18,
                          maxAge: 55,
                          onChanged: onAgeRangeChanged,
                          rangeValues: rangeValues,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.04),
                          child: Text(
                            "Height",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        DropdownButtonFormField<String>(
                            value: heightInRange,
                            items: heightInRangeElement.map((element) {
                              return DropdownMenuItem<String>(
                                  value: commonFunction.formatHeightRange(element),
                                  child: Text(commonFunction.formatHeightRange(element)));
                            }).toList(),
                            onChanged: (newValue) {
                              heightInRange = newValue as String;
                            }),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.04),
                          child: Text(
                            "Education",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        MultipleCheckBox(
                          arrayNameOptions: educationItems,
                          selectionArray: selectedEducation,
                          allowMultipleSelection: false,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.04),
                          child: Text(
                            "City",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        DropdownButtonFormField<CityData>(
                          value: selectedCity,
                          items: dropDownCities.values.map((city) {
                            return DropdownMenuItem<CityData>(
                                value: city, child: Text(city.name));
                          }).toList(),
                          onChanged: (CityData? newValue) {
                            setState(() {
                              selectedCity = newValue;
                              mainFilter.cityDataFilter = newValue!;
                            });
                          },
                        ),
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
      ),
    );
  }

  // String _formatHeightRange(Map<String, dynamic> element) {
  //   // double min = element["min"]!;
  //   // double max = element["max"]!;
  //   // return '${_formatHeight(min)} - ${_formatHeight(max)}';
  //   String min = element["min"]!.toStringAsFixed(1).replaceAll(".", "'");
  //   String max = element["max"]!.toStringAsFixed(1).replaceAll(".", "'");
  //   return "$min - $max";
  // }

  // String _formatHeight(double value) {
  //   int feet = value.floor();
  //   int inches = ((value - feet) * 12).toInt(); // Change rounding to toInt()

  //   // Handle carryover to feet if inches exceed 12
  //   if (inches >= 12) {
  //     feet += inches ~/ 12;
  //     inches %= 12;
  //   }

  //   return '$feet\'$inches';
  // }

  nextScreen(SoulProfile_ViewModel soulProfile_ViewModel) async {
    setState(() {
      isLoading = true;
    });

    if (selectedEducation.isEmpty) {
      Get.snackbar(
        backgroundColor: CustomTheme().errorColor,
        colorText: Colors.white,
        "Error",
        "Fields Missing.",
      );

      setState(() {
        isLoading = false;
      });
      return;
    }
    mainFilter.educationFilter = selectedEducation[0];
    List<String> ageList;
    ageList = age.split("-").map((age) => age.trim()).toList();
    List<String> heightList = heightInRange.split(" - ").map((height) {
      height = height.replaceAll("'", ".");
      return height;
    }).toList();

    print(ageList);
    print(heightList);

    Map<String, dynamic> filter = {
      "uID": soulProfile_ViewModel.profileOverview!.profileData!.uId!,
      "gender": soulProfile_ViewModel.getGender().toString(),
      "age": ageList.toString(),
      "height": heightList.toString(),
      "education": selectedEducation[0].toString(),
      "city": selectedCity?.cid.toString(),
    };
    var response = await connector.post("$prefer/filter", filter);

    if (response != null && response["success"]) {

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
        selectedHeightInRange = {
          "min": mainFilterData["minHeightFilter"].toDouble(),
          "max": mainFilterData["maxHeightFilter"].toDouble()
        };
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
      //     "Main Filter",
      //     "Your changes have been updated.",
      //     duration: const Duration(seconds: 2),
      //   );
      // } else {
      //   Get.snackbar(
      //     backgroundColor: CustomTheme().errorColor,
      //     colorText: Colors.white,
      //     "Error",
      //     "Fields Missing.",
      //   );
      // }

      setState(() {
        isLoading = false;
      });

      Get.snackbar(
          backgroundColor: ThemeColors().buttonColor,
          colorText: Colors.white,
          "Main Filter",
          "Your changes have been updated.",
          duration: const Duration(seconds: 2),
        );
    }

    // if (_formKey.currentState!.validate()) {
    // await Future.delayed(const Duration(seconds: 2));
    // Get.back();
    // Get.snackbar(
    //   backgroundColor: ThemeColors().buttonColor,
    //   colorText: Colors.white,
    //   "Main Filter",
    //   "Your changes have been updated.",
    //   duration: const Duration(seconds: 5),
    // );

    //update the main filter

    //}
    else {
      setState(() {
        isLoading = false;
      });
      Get.snackbar(
        backgroundColor: CustomTheme().errorColor,
        colorText: Colors.white,
        "Error",
        "Fields Missing.",
      );
    }
  }

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

  void dropDownValueAge(value) {
    setState(() {
      age = value as String;
    });
  }

  void dropDownValueHeightInRange(value) {
    setState(() {
      heightInRange = value as String;
    });
  }

  void dropDownValueCity(value) {
    setState(() {
      city2 = value as String;
    });
  }

  void homeScreenRefresh() async {
    Get.toNamed(RoutesClass.homeScreen);
  }

  void onAgeRangeChanged(RangeValues newRange) {
    age = "${newRange.start} - ${newRange.end}";
    mainFilter.minAgeFilter = ((newRange.start).toInt()).toString();
    mainFilter.maxAgeFilter = ((newRange.end).toInt()).toString();
    rangeValues = newRange;
    // Handle changes to the age range slider here
    // You can update your state variables or perform any desired actions
    // ...
  }
}
