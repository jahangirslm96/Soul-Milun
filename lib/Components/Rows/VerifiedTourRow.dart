import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/Controller/constant.dart';
import '../../Utils/ThemeColors.dart';

class VerifiedTourRow extends StatefulWidget {
  const VerifiedTourRow({Key? key}) : super(key: key);

  @override
  State<VerifiedTourRow> createState() => _VerifiedTourRowState();
}

class _VerifiedTourRowState extends State<VerifiedTourRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * 0.2,
              height: Get.width * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ThemeColors().profileBorderColor,
                  width: 2,
                ),
              ),
              child: ClipOval(
                child:  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  image: DecorationImage(
                    image: NetworkImage("$fileUrl${currentTourProfile.profilePicture}"), // Use the NetworkImage directly
                    fit: BoxFit.cover,
                  ),
                ),
                )
              ),
            ),
          ],
        ),
        SizedBox(width: Get.width * 0.05,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  currentTourProfile.name ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: ThemeColors().onBoardingHeadingColor,
                  ),
                ),
                SizedBox(width: Get.width * 0.02,),
                Image.asset(
                  "assets/images/gold_badge.png",
                  scale: 2,
                )
              ],
            ),
            Text(
              "Soul Milan Partner",
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 15,
                color: ThemeColors().onBoardingHeadingColor,
              ),
            ),
            Text(
              "Verified",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: ThemeColors().onBoardingHeadingColor,
              ),
            ),
          ],
        )
      ],
    );
  }
}
