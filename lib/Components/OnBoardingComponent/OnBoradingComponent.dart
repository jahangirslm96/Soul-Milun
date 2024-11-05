import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

class OnBoardingComponent extends StatefulWidget {
  final String heading;
  final String subHeading;
  final String image;
  final double scale;
  final bool showArrow;

  OnBoardingComponent({
    required this.heading,
    required this.subHeading,
    required this.image,
    required this.scale,
    this.showArrow = true,
  });

  @override
  _OnBoardingComponentState createState() => _OnBoardingComponentState();
}

class _OnBoardingComponentState extends State<OnBoardingComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _highlightAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _highlightAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.white54,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return Stack(
      children: [
        Image.asset(
          widget.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              stops: const [0,0.8],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height*0.2,
                    ),
                    ShowUpAnimation(
                      animationDuration: const Duration(milliseconds: 700),
                      curve: Curves.decelerate,
                      direction: Direction.horizontal,
                      offset: 0.6,
                      child: Padding(
                        padding: mainBodyPadding4,
                        child: Text(
                          widget.heading,
                          style: TextStyle(
                            fontSize: CustomTheme().onBoardingHeadingFontSize,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ShowUpAnimation(
                      animationDuration: const Duration(milliseconds: 900),
                      curve: Curves.decelerate,
                      direction: Direction.horizontal,
                      offset: 0.1,
                      child: Padding(
                        padding: mainBodyPadding4,
                        child: Text(
                          widget.subHeading,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: CustomTheme().onBoardingSubHeadingFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    widget.showArrow ?
                    Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.05),
                        child: AnimatedBuilder(
                          animation: _highlightAnimation,
                          builder: (context, child) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_back,
                                      color: _highlightAnimation.value!,
                                    ),
                                    SizedBox(width: Get.width * 0.02),
                                    Text(
                                      "Swipe left",
                                      style: TextStyle(
                                        color: _highlightAnimation.value!,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ) :
                    SizedBox(height: Get.height*0.09,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
