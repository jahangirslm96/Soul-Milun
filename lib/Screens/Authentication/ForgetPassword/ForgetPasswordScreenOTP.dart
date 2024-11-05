import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:soul_milan/Components/Textfields/OtpInputTextfield.dart';

import '../../../Components/Buttons/CustomButton.dart';
import '../../../Components/Textfields/CustomTextfield2.dart';
import '../../../Components/Headers/HeaderWithBackIcon.dart';
import '../../../Utils/Routes.dart';
import '../../../Utils/ThemeColors.dart';
import '../../../Utils/Constants.dart';

class ForgetPasswordScreenOTP extends StatefulWidget {
  const ForgetPasswordScreenOTP({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreenOTP> createState() =>
      _ForgetPasswordScreenOTPState();
}

class _ForgetPasswordScreenOTPState extends State<ForgetPasswordScreenOTP> {
  bool isLoading = false;
  var tempCode = "";
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> _controllers =
      List.generate(5, (index) => TextEditingController());

  @override
  void initState() {
    // TODO: implement initState
    tempCode = storge.read('otp').toString();
    super.initState();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderWithBackIcon(
                    title: "OTP Verification",
                    subtitle:
                        "Enter the Verification Code we just sent you on your Email Address.",
                  ),
                  Padding(
                    padding: mainBodyPadding,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        OtpInputTextfield(controllers: _controllers),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn't receive a Code ($tempCode)?",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Resend",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.435),
                          child: CustomButton(
                              name: 'Reset Password',
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

  bool isCodeVeried() {
    bool isVerified = true;

    for (var i = 0; i < 5; i++) {
      if (_controllers[i].text != tempCode[i]) {
        isVerified = false;
      }
    }

    return isVerified;
  }

  void nextScreen() async {
    if (_formKey.currentState!.validate()) {
      if (isCodeVeried()) {
        storge.write("screen", RoutesClass.newPasswordScreen);
        Get.offAndToNamed(RoutesClass.newPasswordScreen);
      } else {
        Get.snackbar("Otp not match", "Your otp is not match");
      }
    }
  }
}
