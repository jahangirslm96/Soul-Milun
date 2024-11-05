import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Components/Rows/PolicyRow.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

import '../../Components/CheckBox/CheckBoxLabeled.dart';
import '../../Components/Headers/SubscriptionHeaderWithBackIcon.dart';
import '../../Utils/Routes.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  bool isAgree = false;
  bool isChecked = false;
  bool isLoading = false;

  List<dynamic> policy = [];

  @override
  void initState() {
    super.initState();

    isChecked = Get.arguments == null ? Get.arguments != "signUp" : false;
    getPolicy();
  }

  void getPolicy() async {
    var response = await api.get(getPolicyDetails);

    if (response["data"] != null) {
      setState(() {
        policy = response["data"];
        isLoading = true;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      Get.snackbar("Error", response["message"]);
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
                padding: subscriptionBodyPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.018,
                    ),
                    const SubscriptionHeader(
                      text1: "SOUL",
                      text2: " MILUN",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: mainBodyPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.015),
                      child: Text(
                        "Our Policy",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.02),
                        child: isLoading
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: policy.length,
                                shrinkWrap: true,
                                itemExtent: 45,
                                itemBuilder: (context, index) {
                                  return PolicyRow(
                                    details: policy[index]["Details"],
                                  );
                                },
                              )
                            : SizedBox(
                                height: 100,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: ThemeColors().buttonColor,
                                  ),
                                ),
                              )),
                    isChecked
                        ? Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.08),
                            child: CheckBoxLabeled(
                              value: isAgree,
                              onChanged: (value) => setState(() {
                                isAgree = !isAgree;
                              }),
                              label:
                                  "Yes, I have read & agree to Soul Milun Policy.",
                            ),
                          )
                        : SizedBox(
                            height: Get.height * (policy.length * 0.02),
                          ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.02),
                      child: CustomButton(
                        name: isChecked ? "Continue" : "Back",
                        onClick: isChecked ? nextScreen : goBackScreen,
                        color: ThemeColors().buttonColor,
                        isDisable: isChecked ? !isAgree : false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void nextScreen() async {
    if (isAgree) {
      Get.offAndToNamed(RoutesClass.publicInfoScreen);
      storge.write("screen", RoutesClass.publicInfoScreen);
    }
  }

  void goBackScreen() {
    Get.back();
  }
}
