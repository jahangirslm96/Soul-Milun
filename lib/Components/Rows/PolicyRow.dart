import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

class PolicyRow extends StatelessWidget {
  final dynamic details;

  const PolicyRow({
    super.key,
    required this.details,

  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(5),
      dense: true,
      leading: Padding(
        padding: EdgeInsets.only(left: Get.width * 0.025),
        child: Image.asset(
          "assets/icons/bullet_icon.png",
          scale: 2,
        ),
      ),
      title: Text(
        details,
        style: TextStyle(
          fontSize: 14,
          color: ThemeColors().blackColor,
        )
      ),
    );
  }
}
