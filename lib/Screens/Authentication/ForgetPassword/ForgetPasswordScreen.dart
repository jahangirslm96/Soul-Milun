import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:soul_milan/Components/Textfields/CustomTextfield3.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Constants.dart';

import '../../../Components/Buttons/CustomButton.dart';
import '../../../Components/Headers/HeaderWithBackIcon.dart';
import '../../../Utils/Routes.dart';
import '../../../Utils/ThemeColors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailForgetScreenController = TextEditingController();

  @override
  void dispose() {
    emailForgetScreenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: headerPadding,
              child: Column(
                children: [
                  const HeaderWithBackIcon(
                    title: "Forget Password",
                    subtitle:
                        "Enter the Email Address associated with your Account.",
                  ),
                  Padding(
                    padding: mainBodyPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        CustomTextfield3(
                          controller: emailForgetScreenController,
                          label: "Email",
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.53),
                          child: CustomButton(
                              isLoading: isLoading,
                              name: 'Next',
                              onClick: nextScreen,
                              color: ThemeColors().buttonColor),
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

  void nextScreen() async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      var response = await api.getPost(getOtp, {
        "address": emailForgetScreenController.text,
        "typeOfUser": "email",
        "uid": "",
      });

      //print(response);

      if (response["success"]) {
        storge.write('uid', response["uid"]);
        storge.write('otp', response["otp"]);
        Get.toNamed(RoutesClass.forgetPassScreenOTP);
      } else {
        Get.snackbar("Issues in Email, not Exist", response["message"]);
      }
    }

    setState(() {
      isLoading = false;
    });
  }
}
