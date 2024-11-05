import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

class CustomRadioButtons2 extends StatefulWidget {
  const CustomRadioButtons2({Key? key}) : super(key: key);

  @override
  State<CustomRadioButtons2> createState() => _CustomRadioButtons2State();
}

class _CustomRadioButtons2State extends State<CustomRadioButtons2> {
  String radioItem = '';


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              radioItem = 'Item 1';
            });
          },
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Transform.scale(
              scale: 1.0,
              child: Radio(
                activeColor: ThemeColors().buttonColor,
                groupValue: radioItem,
                value: 'Item 1',
                onChanged: (value) {
                  setState(() {
                    radioItem = value.toString();
                  });
                },
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/PaymentImage/payment_easypaisa.png",
                  scale: 1.8,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              radioItem = 'Item 2';
            });
          },
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Transform.scale(
              scale: 1.0,
              child: Radio(
                activeColor: ThemeColors().buttonColor,
                groupValue: radioItem,
                value: 'Item 2',
                onChanged: (value) {
                  setState(() {
                    radioItem = value.toString();
                  });
                },
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/PaymentImage/payment_sadapay.png",
                  scale: 1.8,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              radioItem = 'Item 3';
            });
          },
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Transform.scale(
              scale: 1.0,
              child: Radio(
                activeColor: ThemeColors().buttonColor,
                groupValue: radioItem,
                value: 'Item 3',
                onChanged: (value) {
                  setState(() {
                    radioItem = value.toString();
                  });
                },
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/PaymentImage/payment_nayapay.png",
                  scale: 1.8,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
