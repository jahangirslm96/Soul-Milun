import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/ProfileModel/ProfileOverview.model.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/view_model/SoulProfilesTimeline_ViewModel.dart';

import '../../Utils/ThemeColors.dart';
import '../../view_model/SoulProfile_ViewModel.dart';
import '../AlertBox/DialogBox1.dart';

class ProfileCard extends StatefulWidget {
  ProfileOverview? profile;
  final String title;
  int? tabIndex = -1;

   ProfileCard({super.key,
      this.title = "Similar",
      this.profile,
      this.tabIndex,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel = Provider.of<SoulProfilesTimeline_ViewModel>(context, listen: false);
     SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
    return GestureDetector(
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
        Future.delayed(const Duration(milliseconds: 55), () {
          setState(() {
            isTapped = false;
          });
        });
      },
      onTap: () => onTapProfile(widget.profile!, soulProfilesTimeline_ViewModel, soulProfile_ViewModel),
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
          width: Get.width * 0.39,
          height: Get.height * 0.39,
          margin: EdgeInsets.only(right: Get.width * 0.02),
          decoration: BoxDecoration(
            color: ThemeColors().containerColor,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: ThemeColors().containerOutlineColor,
              width: 1.5,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(fileUrl + widget.profile!.profileData!.profilePicture!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.03,
                  bottom: Get.height * 0.01,
                  right: Get.width * 0.03,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: SizedBox()),
                    Text.rich(
                      TextSpan(
                        text: widget.profile!.profileData!.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          const TextSpan(
                            text: ', ',
                          ),
                          TextSpan(
                            text: widget.profile!.profileData!.age.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  onTapProfile(ProfileOverview pov, SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel, SoulProfile_ViewModel soulProfile_ViewModel) async {
    if(soulProfilesTimeline_ViewModel.isTimelineLoaded && pov.profileData?.gender != null){
      soulProfilesTimeline_ViewModel.setCurrentProfilePreview(pov);
      // previewProfile = profile!;
      Get.toNamed(RoutesClass.membersProfileScreen, arguments: widget.title);
    }else{
      soulProfilesTimeline_ViewModel.LoadSpecificProfile(soulProfile_ViewModel.profileVerification!.uID!, pov.profileData!.uId!, soulProfile_ViewModel.profileVerification!.getAccessToken(), widget.tabIndex!);
      //load the profile
    }
  }
}
