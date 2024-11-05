import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Constants.dart';

import '../../../Components/Headers/Header.dart';
import '../../../Components/Textfields/CustomPasswordTextfield.dart';
import '../../../Utils/Routes.dart';
import '../../../Utils/ThemeColors.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  bool isLoading = false;
  String _uid = "";
  final _formKey = GlobalKey<FormState>();

  TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _uid = storge.read("uid").toString();
    if (_uid.isEmpty) {
      storge.write("screen", RoutesClass.logInPage);
      Get.offAndToNamed(RoutesClass.logInPage);
    }
    // await api.get
  }

  @override
  void dispose() {
    createPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
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
                    const Header(
                      title: "New Password",
                      subtitle: "Enter New Password for your Account.",
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Padding(
                      padding: mainBodyPadding,
                      child: Column(
                        children: [
                          CustomPasswordTextfield(
                            controller: createPasswordController,
                            label: 'Password',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{6,}$')
                                  .hasMatch(value)) {
                                return 'Password must contain at least: \n\n1  Uppercase \n1  Lowercase \n1  Number \n1  Special character';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          CustomPasswordTextfield(
                            controller: confirmPasswordController,
                            label: 'Confirm Password',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm Password is required';
                              }
                              if (value != createPasswordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.405),
                            child: CustomButton(
                                isLoading: isLoading,
                                name: 'Continue',
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
      ),
    );
  }

  void nextScreen() async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      if (confirmPasswordController.text == createPasswordController.text) {
        var uid = storge.read("uid").toString();
        // await api.get
        var response = await api.post(updatePassword, {
          "uid": uid,
          "password": createPasswordController.text,
        });

        //print(response);

        if (response["success"] == true) {
          storge.write("screen", RoutesClass.logInPage);
          Get.toNamed(RoutesClass.logInPage);
        } else {
          Get.snackbar("Passwords not update", response["message"] ?? "");
        }
      } else {
        Get.snackbar("Password", "Password Not Matched");
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}
