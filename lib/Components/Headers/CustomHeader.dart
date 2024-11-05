import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';

class CustomHeader extends StatefulWidget {
  final String name;

  const CustomHeader({
    super.key,
    required this.name,
  });

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  bool isTapped = false;
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
                    fontSize: CustomTheme().onBoardingSubHeadingFontSize,
                    color: ThemeColors().buttonColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 23,
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
