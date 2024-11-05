import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:soul_milan/Components/Textfields/OtpInputTextfield.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

import '../../../Components/Buttons/CustomButton.dart';
import '../../../Components/Headers/HeaderWithBackIcon.dart';
import '../../../Utils/Constants.dart';
import '../../../Utils/Routes.dart';

class VerificationScreenOTP extends StatefulWidget {
  const VerificationScreenOTP({Key? key}) : super(key: key);

  @override
  State<VerificationScreenOTP> createState() => _VerificationScreenOTPState();
}

class _VerificationScreenOTPState extends State<VerificationScreenOTP> {
  final _formKey = GlobalKey<FormState>();
  late String tempCode;
  late String code;
  final List<TextEditingController> _controllers =
      List.generate(5, (index) => TextEditingController());

  int timerRunning = 30;
  bool isResend = false;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    tempCode = storge.read("otp") ?? "";
    if (tempCode == "") {
      Get.offAndToNamed(RoutesClass.verificationScreen);
    }

    timer();
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
                  const HeaderWithBackIcon(
                    title: "OTP Verification",
                    subtitle:
                        "Enter OTP code we sent you on your Mobile Number.",
                  ),
                  Padding(
                    padding: mainBodyPadding,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.001,
                        ),
                        OtpInputTextfield(controllers: _controllers),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.06),
                          child: Center(
                            child: Text(
                              "00:$timerRunning",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.02),
                          child: Center(
                            child: TextButton(
                              onPressed: isResend ? resendOTP : () => {},
                              child: Text(
                                "Resend($tempCode)",
                                style: TextStyle(
                                    fontSize: CustomTheme().fontSize,
                                    color: isResend
                                        ? ThemeColors().onBoardingSubTextColor
                                        : ThemeColors().deleteFromThisDevice,
                                    fontWeight: isResend
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.405),
                          child: CustomButton(
                            name: "Confirm Verification",
                            onClick: nextScreen,
                            color: ThemeColors().buttonColor,
                            isDisable: _controllers[4].text.isEmpty,
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

  void resendOTP() {
    Get.back();
  }

  void timer() async {
    if (timerRunning != 0) {
      setState(() {
        timerRunning--;
      });

      await Future.delayed(const Duration(seconds: 1));
      timer();
    } else {
      setState(() {
        isResend = true;
      });
      // resendOTP();
    }
  }

  String getOtpType() {
    List<String> otp = [];

    for (var i = 0; i < 5; i++) {
      otp.add(_controllers[i].text);
    }

    return otp
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll(" ", "")
        .replaceAll(",", "");
  }

  void nextScreen() async {
    if (_formKey.currentState!.validate()) {
      var getCode = getOtpType();

      var isOtp = await connector.post("$verifyOtp/${storge.read("uid")}/otp/",
          {"otp": getCode, "type": "PhoneNumber"});

      if (isOtp["success"] == true) {
        storge.write("screen", RoutesClass.policyScreen);
        Get.offAndToNamed(RoutesClass.policyScreen);
      } else {
        //print(isOtp);
        Get.snackbar("Otp not match", isOtp["message"]);
      }
    }
  }
}
