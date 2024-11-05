import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';

import '../../../Components/Buttons/CustomButton.dart';
import '../../../Components/Headers/HeaderWithBackIcon.dart';
import '../../../Utils/CustomTheme.dart';
import '../../../Utils/Routes.dart';
import '../../../Utils/ThemeColors.dart';
import '../../../Utils/Constants.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;

  TextEditingController phoneNumberController = TextEditingController();

  late bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
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
                  const HeaderWithBackIcon(
                    title: "Verification",
                    subtitle: "Enter your Mobile Number.",
                  ),
                  Padding(
                    padding: mainBodyPadding,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        TextFormField(
                          cursorColor: ThemeColors().labelTextColor,
                          maxLength: 10,
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Phone Number';
                            }
                            if (value.startsWith("0")) {
                              return "Please remove 0 from the start";
                            }
                            if (value.length < 10) {
                              return 'Phone Number Incomplete';
                            }
                            return null;
                          },
                          style: Theme.of(context).textTheme.labelSmall,
                          decoration: InputDecoration(
                            prefixIconConstraints: const BoxConstraints(
                                minWidth: 24, minHeight: 15, maxHeight: 19),
                            prefixIcon: Container(
                              height: 19,
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      color:
                                          ThemeColors().deleteFromThisDevice),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.02),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: selectCountryCode,
                                    child: Text(
                                      countryCode?.dialCode ?? "+92",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeColors().enabledBorderColor,
                              ),
                            ),
                            errorStyle: const TextStyle(height: 0),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: CustomTheme().errorColor,
                                width: CustomTheme().errorBorderWidth,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: ThemeColors().labelTextColor,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.all(CustomTheme().paddingInput),
                            hintStyle: TextStyle(
                              color: ThemeColors().buttonColor,
                            ),
                            /*labelText: "Phone Number",*/
                            hintText: "Phone Number",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.04),
                          child: Text(
                            "You're safe to provide your phone number as we'll never show your number on profile. It is only \nneeded for verification process.",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.45),
                          child: CustomButton(
                            name: "Send OTP",
                            isLoading: isLoading,
                            onClick: nextScreen,
                            color: ThemeColors().buttonColor,
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

  void selectCountryCode() async {
    final code = await countryPicker.showPicker(context: context);
    setState(() {
      countryCode = code;
    });
  }

  void nextScreen() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      var obj = {
        "typeOfUser": "PhoneNumber",
        "address": phoneNumberController.text.toString(),
        "uid": storge.read("uid").toString(),
      };

      var data = await connector.post(getOtp, obj);

      //print(data);

      if (data['success'] == false) {
        Get.snackbar("Phone Number Exist",
            data['message']['message'] ?? "Phone Already Exist",
            backgroundColor: CustomTheme().errorColor, colorText: Colors.white);
      } else {}

      // just for now
      storge.write("otp", data['otp']);
      storge.write("screen", RoutesClass.verificationScreenOTP);
      Get.toNamed(RoutesClass.verificationScreenOTP);
      setState(() {
        isLoading = false;
      });
    }
  }
}
