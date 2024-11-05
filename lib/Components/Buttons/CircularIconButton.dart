import "package:flutter/material.dart";
import "package:get/get.dart";


class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final onTap;

  const CircularIconButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.onTap,
    this.iconColor = Colors.white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.height * 0.07,
      height: Get.width * 0.2,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          backgroundColor: color,
          onPressed: onTap,
          child: Icon(
            icon,
            color: iconColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
