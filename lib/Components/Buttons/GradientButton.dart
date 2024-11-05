import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

class GradientButton extends StatelessWidget {
  final String name;
  final VoidCallback onClick;
  final Color color1;
  final Color color2;
  final Color color3;

  const GradientButton({
    super.key,
    required this.name,
    required this.onClick,
    required this.color1,
    required this.color2,
    required this.color3,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.0065),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [color1, color2, color3,]
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}