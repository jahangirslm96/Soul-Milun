import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../Components/CheckBox/CheckBoxLabeled.dart';
import '../../Components/Headers/HeaderWithBackIcon.dart';
import '../../Components/Textfields/CustomTextfield.dart';
import '../../Utils/Constants.dart';
import '../../Utils/Routes.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  TextEditingController nameOnCardController = TextEditingController();



  @override
  void dispose() {
    cardNumberController.dispose();
    expiryController.dispose();
    cvcController.dispose();
    nameOnCardController.dispose();
    super.dispose();
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
                padding: headerPadding,
                child: const HeaderWithBackIcon(
                  title: "Add A Card",
                  subtitle: "Enter Credit Card or Debit Card Details.",
                ),
              ),
              Padding(
                padding: mainBodyPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextfield(
                      controller: cardNumberController,
                      label: "Card Number",
                      inputType: TextInputType.number,
                      inputFormatters: [MaskTextInputFormatter(mask: "####-####-####-####")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CustomTextfield(
                            controller: expiryController,
                            label: "MM/YY",
                            inputType: TextInputType.number,
                            inputFormatters: [MaskTextInputFormatter(mask: "##/##")],
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.05,
                        ),
                        Expanded(
                          child: CustomTextfield(
                            controller: cvcController,
                            label: "CVC",
                            inputType: TextInputType.number, // Set the keyboard type to number
                          ),
                        ),
                      ],
                    ),
                    CustomTextfield(
                      controller: nameOnCardController,
                      label: "Name On Card",
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.02),
                      child: const CheckBoxLabeled(
                        label: "Save this card for future checkouts.",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.05),
                      child: CustomButton(
                          name: "Save Card",
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
    );
  }
  void nextScreen() async {
    /*if (_formKey.currentState!.validate()) {*/
    Get.toNamed(RoutesClass.subscriptionScreen2Payment);
    /*}*/
  }
}
