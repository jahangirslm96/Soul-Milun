import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';

import '../../Utils/ThemeColors.dart';
import '../AlertBox/DiscountDialogBox.dart';

class ProfileInfoRow2 extends StatefulWidget {
  const ProfileInfoRow2({Key? key}) : super(key: key);

  @override
  State<ProfileInfoRow2> createState() => _ProfileInfoRow2State();
}

class _ProfileInfoRow2State extends State<ProfileInfoRow2> {
  bool isTapped = false;
  bool isTapped2 = false;
  bool isTapped3 = false;
  bool isTapped4 = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Get.width * 0.15,
              height: Get.width * 0.15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ThemeColors().profileBorderColor,
                  width: 2,
                ),
              ),
              child: Consumer<SoulProfile_ViewModel>(builder: (context, soulProfile_ViewModel, child) =>
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
                    onTap: () => Get.toNamed(RoutesClass.getMyProfileRoute()),
                    child: soulProfile_ViewModel.profileOverview != null
                        ? ClipOval(
                      child: ColorFiltered(
                        colorFilter: isTapped
                            ? ColorFilter.mode(
                          Colors.black.withOpacity(0.3),
                          BlendMode.srcATop,
                        )
                            : const ColorFilter.mode(
                          Colors.transparent,
                          BlendMode.srcATop,
                        ),
                        child: Image.network(
                          "$fileUrl${soulProfile_ViewModel.profileOverview!.profileData!.profilePicture!}",
                          scale: 3,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        : ClipOval(
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
                        child: Image.asset(
                          defaultImage,
                          scale: 3,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.04,
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
              onTap: () => Get.toNamed(RoutesClass.getMyProfileRoute()),
              child: Consumer<SoulProfile_ViewModel>(
                builder: (context, value, child) => _buildUI(value),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: Get.height * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                  Get.toNamed(RoutesClass.subscriptionScreen);
                },
                child: ColorFiltered(
                  colorFilter: isTapped2 ? ColorFilter.mode(
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
                      color: ThemeColors().soulColor,
                    ),
                    child: const Icon(
                      Icons.store_mall_directory,
                      color: Colors.white,
                      size: 21,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.04,
              ),
              GestureDetector(
                onTapDown: (_) {
                  setState(() {
                    isTapped3 = true;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isTapped3 = false;
                  });
                },
                onTapUp: (_) {
                  Future.delayed(const Duration(milliseconds: 35), () {
                    setState(() {
                      isTapped3 = false;
                    });
                  });
                },
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const DiscountDialogBox(),
                  );
                },
                child: ColorFiltered(
                  colorFilter: isTapped3 ? ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.srcATop,
                  )
                      : const ColorFilter.mode(
                    Colors.transparent,
                    BlendMode.srcATop,
                  ),
                  child: Image.asset(
                    "assets/icons/discount_icon.png",
                    scale: 1.6,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.04,
              ),
              GestureDetector(
                onTapDown: (_) {
                  setState(() {
                    isTapped4 = true;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isTapped4 = false;
                  });
                },
                onTapUp: (_) {
                  Future.delayed(const Duration(milliseconds: 35), () {
                    setState(() {
                      isTapped4 = false;
                    });
                  });
                },
                onTap: () {
                  Get.toNamed(RoutesClass.matchMyPerfectSoulScreen);
                },
                child: ColorFiltered(
                  colorFilter: isTapped4
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
                      color: ThemeColors().hintTextColor,
                      border: Border.all(
                        color: ThemeColors().buttonColor
                      )
                    ),
                    child: ColorFiltered(
                      colorFilter: isTapped4
                          ? ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.srcATop,
                      )
                          : const ColorFilter.mode(
                        Colors.transparent,
                        BlendMode.srcATop,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/icons/filter_icon.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        )
      ],
    );
  }

  _buildUI(SoulProfile_ViewModel soulProfile_ViewModel){
    if(soulProfile_ViewModel.profileOverview != null){
    return  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    soulProfile_ViewModel.profileOverview!.profileData!.name!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ThemeColors().onBoardingHeadingColor,
                    ),
                  ),
                  Text(
                    "${soulProfile_ViewModel.profileOverview!.profileData!.city}, Pakistan",
                    style: TextStyle(
                      fontSize: 12,
                      color: ThemeColors().buttonColor,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              );
    }

    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "-",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ThemeColors().onBoardingHeadingColor,
                    ),
                  ),
                  Text(
                    "-, Pakistan",
                    style: TextStyle(
                      fontSize: 12,
                      color: ThemeColors().buttonColor,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              );
  }
}
