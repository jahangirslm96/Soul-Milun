import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Routes.dart';

import '../../Utils/ThemeColors.dart';

class CustomHeader3 extends StatefulWidget {
  final String name;

  const CustomHeader3({
   super.key,
   required this.name,
});

  @override
  State<CustomHeader3> createState() => _CustomHeader3State();
}

class _CustomHeader3State extends State<CustomHeader3> {
  bool isTapped = false;
  bool isTapped2 = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            Flexible(
              child: Center(
                child: Text(
                  widget.name,
                  style: TextStyle(
                    color: ThemeColors().onBoardingHeadingColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ),
            ),
            GestureDetector(
              onTapDown: (_) {
                setState(() {
                  isTapped2 = true;
                });
              },
              onTapCancel: () {
                setState(() {
                  isTapped2 = false;
                });
              },
              onTapUp: (_) {
                Future.delayed(const Duration(milliseconds: 35), () {
                  setState(() {
                    isTapped2 = false;
                  });
                });
              },
              onTap: () {
                Get.toNamed(RoutesClass.editProfileScreen);
              },
              child: ColorFiltered(
                colorFilter: isTapped2
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
                      ),
                  ),
                  child: ColorFiltered(
                    colorFilter: isTapped2
                        ? ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.srcATop,
                    )
                        : const ColorFilter.mode(
                      Colors.transparent,
                      BlendMode.srcATop,
                    ),
                    child: Icon(
                      Icons.settings,
                      size: 20,
                      color: ThemeColors().buttonColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void previousScreen() {
    Get.back();
  }
}
