import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

class SubscriptionButton extends StatelessWidget {
  final Color color;

  const SubscriptionButton({
    super.key,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.005,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0.0, 2.0), // (dx, dy)
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
        child: Text(
          "View Plan",
          textAlign: TextAlign.center,
          style: TextStyle(
                fontSize: 13.0,
              color: ThemeColors().buttonColor,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}