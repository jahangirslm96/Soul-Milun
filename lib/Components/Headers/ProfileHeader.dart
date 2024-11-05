import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';

class ProfileHeader extends StatelessWidget {
  final String title;

  const ProfileHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: ThemeColors().onBoardingHeadingColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
