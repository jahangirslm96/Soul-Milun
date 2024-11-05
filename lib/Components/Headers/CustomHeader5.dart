import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Utils/CustomTheme.dart';
import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';
import '../../view_model/SoulProfilesTimeline_ViewModel.dart';
import '../Buttons/CustomButton.dart';

class CustomHeader5 extends StatefulWidget {
  final String name;
  VoidCallback? onTap;

  CustomHeader5({
    super.key,
    required this.name,
    this.onTap,
  });

  @override
  State<CustomHeader5> createState() => _CustomHeader5State();
}

class _CustomHeader5State extends State<CustomHeader5> {
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
                    fontSize: CustomTheme().onBoardingSubHeadingFontSize,
                    color: ThemeColors().buttonColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 23,
              child: PopupMenuButton(
                position: PopupMenuPosition.under,
                splashRadius: 20,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                    value: 'report',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.report,
                          color: ThemeColors().milanColor,
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Text(
                          'Report',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: ThemeColors().buttonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                    value: 'block',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.block,
                          color: CustomTheme().errorColor,
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Text(
                          'Block',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: ThemeColors().buttonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                onSelected: (String value) {
                  if (value == 'report') {
                    Get.toNamed(RoutesClass.reportProfileScreen);
                  } else if (value == 'block') {
                    showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05,
                              vertical: Get.height * 0.01,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text.rich(
                                    TextSpan(
                                      text: "SOUL",
                                      style: TextStyle(
                                        color: ThemeColors().soulColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: " MILUN",
                                          style: TextStyle(
                                            color: ThemeColors().milanColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: Get.height * 0.02),
                                    child: Text(
                                      "Are you sure you want to Block this User ?",
                                      style: TextStyle(
                                        color: ThemeColors().buttonColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: Get.height * 0.02),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Consumer<SoulProfilesTimeline_ViewModel>(builder: (context, value, child) =>
                                        CustomButton(
                                          name: 'Yes',
                                          onClick: () {
                                            widget.onTap!();
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) =>
                                                  SimpleDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal:
                                                              Get.width * 0.05,
                                                          vertical:
                                                              Get.height * 0.02,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            CircularProgressIndicator(
                                                              color:
                                                                  ThemeColors()
                                                                      .soulColor,
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    Get.height *
                                                                        0.02),
                                                            Text(
                                                              "Blocking User...",
                                                              style: TextStyle(
                                                                color: ThemeColors()
                                                                    .buttonColor,
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          color: ThemeColors().soulColor,
                                        )
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.04,
                                      ),
                                      Expanded(
                                        child: CustomButton(
                                          name: 'No',
                                          onClick: () {
                                            Get.back();
                                          },
                                          color: ThemeColors().milanColor,
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
                    );
                  }
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  void previousScreen() {
    Get.back();
  }
}


