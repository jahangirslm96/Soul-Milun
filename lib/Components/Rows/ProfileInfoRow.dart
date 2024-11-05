import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';

import '../../Utils/ThemeColors.dart';

class ProfileInfoRow extends StatelessWidget {
  const ProfileInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
            child: Image.network(
              "$fileUrl${soulProfile_ViewModel.profileOverview!.profileData!.profilePicture}",
              scale: 2.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    soulProfile_ViewModel.profileOverview!.profileData!.name!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: ThemeColors().onBoardingHeadingColor,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  // userProfile.subscribe != 0
                  //     ? Image.asset(
                  //         "assets/images/gold_badge.png",
                  //         scale: 2,
                  //       )
                  //     : Container(),
                ],
              ),
              /*Text(
                "Show my Profile as User.",
                style: TextStyle(
                  fontSize: 12,
                  color: ThemeColors().buttonColor,
                  fontWeight: FontWeight.w100,
                ),
              ),*/
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ],
    );
  }
}
