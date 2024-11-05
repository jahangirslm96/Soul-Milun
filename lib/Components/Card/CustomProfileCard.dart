import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';
import 'package:soul_milan/Utils/Routes.dart';

import '../../Utils/Controller/model/TourPartners.model.dart';
import '../../Utils/ThemeColors.dart';
import '../AlertBox/DialogBox1.dart';

class CustomProfileCard extends StatefulWidget {
  final TourProfile? tourProfile;
  final String title;

  const CustomProfileCard({super.key,
      this.title = "Similar",
      required this.tourProfile,
  });

  @override
  State<CustomProfileCard> createState() => _CustomProfileCardState();
}

class _CustomProfileCardState extends State<CustomProfileCard> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
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
      onTap: onTapProfile,
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
                      image: NetworkImage(fileUrl + widget.tourProfile!.profilePicture!),
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
                        text: widget.tourProfile?.name,
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
                            text: widget.tourProfile?.age.toString(),
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
        ),
      ),
    );
  }

  onTapProfile() {
    currentTourProfile = widget.tourProfile!;
    Get.toNamed(RoutesClass.verifiedSoulsProfileScreen);
  }
}
