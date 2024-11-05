// InterestsScreen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';

import '../../Components/InterestSelection/CustomInterestSelection.dart';
import '../../Components/Buttons/CustomButton.dart';
import '../../Components/Headers/HeaderWithBackIcon.dart';
import '../../Utils/Constants.dart';
import '../../Utils/CustomTheme.dart';
import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<String> selectedInterestsArray = [];
  late List<dynamic> response;
  int selectedCount = 0;
  bool isLoader = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    response = [];
    _getData();
  }

  void _getData() async {
    var temp = await connector.get(interest);

    if (temp != null && temp["success"] != null && temp["success"]) {
      setState(() {
        response = temp["data"];
        isLoader = true;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: headerPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: HeaderWithBackIcon(
                        title: "Interests",
                        subtitle: "Select your interests",
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: ThemeColors().containerOutlineColor,
                thickness: Get.height * 0.0005,
              ),
              Padding(
                padding: mainBodyPadding,
                child: isLoader
                    ? Column(
                        children: [
                          ListView.builder(
                              itemCount: response.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  CustomInterestSelection(
                                    image: response[index]['image'],
                                    name: response[index]['name'],
                                    padding: index == 0 ? 0 : 0.06,
                                    nameOfArray: response[index]['tagsDetails'],
                                    selectionInterestArray:
                                        selectedInterestsArray,
                                    onSelectionChanged:
                                        _updateSelectedCount, // Pass the callback
                                  )),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Get.height * 0.06),
                            child: CustomButton(
                              isLoading: isLoading,
                              name: "OK",
                              onClick: nextScreen,
                              color: ThemeColors().buttonColor,
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: ThemeColors().buttonColor,
                        ),
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: null,
          enableFeedback: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                selectedCount >= 5 ? Icons.check_circle : Icons.error,
                size: 25,
              ),
              SizedBox(
                width: Get.width * 0.02,
              ),
              Text(
                'Selected: $selectedCount/15',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          backgroundColor: selectedCount >= 5
              ? CustomTheme().successColor
              : CustomTheme().errorColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
    );
  }

  void _updateSelectedCount() {
    setState(() {
      selectedCount = selectedInterestsArray.length;
    });
  }

  void nextScreen() async {
    if (selectedInterestsArray.length >= 5) {
      setState(() {
        isLoading = true;
      });
      var route = RoutesClass.selfieCheckScreen;

      var response = await connector.post(postInterest + storge.read("uid"),
          {"selectedInterest": selectedInterestsArray.toString()});

      if (response != null &&
          response["success"] != null &&
          response["success"]) {
        storge.write("screen", route);
        Get.offAndToNamed(route);
      } else {
        Get.snackbar(
          "Error",
          response["message"] ?? "Something went wrong",
          backgroundColor: CustomTheme().errorColor,
          colorText: Colors.white,
        );
      }

      setState(() {
        isLoading = false;
      });
    } else {
      Get.snackbar(
        "Minimum Interests Not Reached",
        "Please select at least 5 interests.",
        backgroundColor: CustomTheme().errorColor,
        colorText: Colors.white,
      );
    }
  }
}
