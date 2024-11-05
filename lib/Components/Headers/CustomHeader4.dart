import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/ThemeColors.dart';

class CustomHeader4 extends StatefulWidget {
  final String name;

  const CustomHeader4({
    super.key,
    required this.name,
});

  @override
  State<CustomHeader4> createState() => _CustomHeader4State();
}

class _CustomHeader4State extends State<CustomHeader4> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height * 0.018,
        ),
        GestureDetector(
          onTapDown: (_) {
            setState(() {
              isTapped = true;
            });
          },
          onTapCancel: () {
            setState(() {
              isTapped = false;
            });
          },
          onTapUp: (_) {
            Future.delayed(const Duration(milliseconds: 35), () {
              setState(() {
                isTapped = false;
              });
            });
          },
          onTap: () {
            Get.back();
          },
          child: ColorFiltered(
            colorFilter: isTapped
                ? ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.srcATop,
            )
                : const ColorFilter.mode(
              Colors.transparent,
              BlendMode.srcATop,
            ),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                      color: ThemeColors().buttonColor
                  )
              ),
              child: ColorFiltered(
                colorFilter: isTapped
                    ? ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.srcATop,
                )
                    : const ColorFilter.mode(
                  Colors.transparent,
                  BlendMode.srcATop,
                ),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 20,
                  color: ThemeColors().buttonColor,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
          child: Text(
            widget.name,
            style: TextStyle(
              color: ThemeColors().buttonColor,
              fontSize: 22,
            ),
          ),
        ),
      ],
    );
  }

  void previousScreen() {
    Get.back();
  }
}
