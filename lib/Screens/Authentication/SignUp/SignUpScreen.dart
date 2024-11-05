import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:soul_milan/Components/Headers/HeaderWithBackIcon.dart';
import 'package:soul_milan/Components/Textfields/CustomPasswordTextfield.dart';
import 'package:soul_milan/Components/Textfields/CustomTextfield3.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';

import '../../../Components/Buttons/CustomButton.dart';
import '../../../Utils/CustomTheme.dart';
import '../../../Utils/Routes.dart';
import '../../../Utils/ThemeColors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController signUpScreenNameController = TextEditingController();
  TextEditingController signUpScreenEmailController = TextEditingController();
  TextEditingController signUpScreenPasswordController =
      TextEditingController();
  TextEditingController signUpScreenConfirmPasswordController =
      TextEditingController();

  bool formFill = false;

  @override
  void dispose() {
    signUpScreenNameController.dispose();
    signUpScreenEmailController.dispose();
    signUpScreenPasswordController.dispose();
    signUpScreenConfirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: headerPadding,
                  child: const HeaderWithBackIcon(
                    title: "Create Account",
                    subtitle: "Please, create your Account.",
                  ),
                ),
                Padding(
                  padding: mainBodyPadding,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      CustomTextfield3(
                        controller: signUpScreenNameController,
                        label: "Name",
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      CustomTextfield3(
                        controller: signUpScreenEmailController,
                        label: "Email",
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      CustomPasswordTextfield(
                        controller: signUpScreenPasswordController,
                        label: 'Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          if (!RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{6,}$')
                              .hasMatch(value)) {
                            return 'Password must contain at least: \n 1 Alphabet character \n 1 Numeric character';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      CustomPasswordTextfield(
                        controller: signUpScreenConfirmPasswordController,
                        label: 'Confirm Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password is required';
                          }
                          if (value != signUpScreenPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Before Sign up, make sure you read our",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: toPolicyScreen,
                                  child: Text(
                                    "Privacy policy.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        child: CustomButton(
                          isLoading: formFill,
                          name: "Sign Up",
                          onClick: nextScreen,
                          color: ThemeColors().buttonColor,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          GestureDetector(
                            onTap: toLoginScreen,
                            child: Text(
                              "Login",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ],
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

  void toLoginScreen() async {
    storge.write("screen", RoutesClass.logInPage);
    Get.toNamed(RoutesClass.logInPage);
  }

  void nextScreen() async {
    setState(() {
      formFill = true;
    });
    if (_formKey.currentState!.validate()) {
      var apiBOdy = {
        "name": signUpScreenNameController.text,
        "email": signUpScreenEmailController.text,
        "password": signUpScreenPasswordController.text
      };

      var data = await api.getPost(register, apiBOdy);
      // if correct then go to home screen
      if (data != null && data["success"] != null && data["success"]) {
        storge.write("uid", data["soulprofile"]["uid"]);
        storge.write("token", data["soulprofile"]["token"]["access"]["token"]);
        storge.write("email", signUpScreenEmailController.text);
        
        connector = Connector(data["soulprofile"]["token"]["access"]["token"]);

        Get.snackbar(
          backgroundColor: CustomTheme().successColor,
          colorText: Colors.white,
          "ACCOUNT CREATED",
          data["message"] ?? "Something went wrong.",
        );

        storge.write("screen", RoutesClass.verificationScreen);

        // userProfile = Profiles.fromJson({
        //   "id": data["soulprofile"]["uid"],
        //   "name": apiBOdy["name"]!,
        // });

        Get.offAndToNamed(RoutesClass.verificationScreen);
      } else {
        // if incorrect then show error
        Get.snackbar(
          backgroundColor: CustomTheme().errorColor,
          colorText: Colors.white,
          "Error",
          data["message"] ?? "Something went wrong.",
        );
      }
    } else {
      // if incorrect then show error
      Get.snackbar(
        backgroundColor: CustomTheme().errorColor,
        colorText: Colors.white,
        "Error",
        "Fields Missing.",
      );
    }

    setState(() {
      formFill = false;
    });
  }

  void toPolicyScreen() async {
    Get.toNamed(RoutesClass.policyScreen, arguments: "signUp");
  }
}
