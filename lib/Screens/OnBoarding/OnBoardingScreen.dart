import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Components/OnBoardingComponent/OnBoradingComponent.dart';
import 'package:soul_milan/Utils/Common/Function.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  bool isLastScreen = false;

  Color buttonColor = ThemeColors().buttonColor;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  OnBoardingComponent(
                    image: "assets/images/ob1.jpg",
                    scale: 1,
                    heading: "Compatible Partners",
                    subHeading:
                    "Discover your perfect match based on shared interests and values.",
                  ),
                  OnBoardingComponent(
                    image: "assets/images/ob2.jpg",
                    scale: 1,
                    heading: "Earn Money",
                    subHeading:
                    "Explore new income opportunities and start earning today.",
                  ),
                  OnBoardingComponent(
                    image: "assets/images/ob3.jpg",
                    scale: 1,
                    heading: "Exclusive Discounts",
                    subHeading:
                    "Unlock unique savings with our platform. Access special deals and offers.",
                  ),
                  OnBoardingComponent(
                    image: "assets/images/sample_onboardingscreen_pic.jpg",
                    scale: 1,
                    heading: "Secure Chat",
                    subHeading:
                    "Chat with confidence using our secure messaging. Your privacy is protected with encrypted conversations.",
                  ),
                  OnBoardingComponent(
                    image: "assets/images/ob5.jpg",
                    scale: 1,
                    heading: "Careers",
                    subHeading:
                    "Unlock your potential with exciting career opportunities.",
                    showArrow: false,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5, (index) => Indicator(isActive: index == _currentPage),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Get.height * 0.03, bottom: Get.height * 0.03),
                  child: _currentPage == 4 ? ShowUpAnimation(
                      animationDuration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutSine,
                      direction: Direction.vertical,
                      offset: 5,
                      child: GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            buttonColor = ThemeColors().buttonColorOnTap;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            buttonColor = ThemeColors().buttonColor;
                          });
                          moveForword(RoutesClass.welcomePage);
                        },
                        onTapCancel: () {
                          setState(() {
                            buttonColor = ThemeColors().buttonColor;
                          });
                        },
                        child: Padding(
                          padding: mainBodyPadding4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: buttonColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                              child: Text(
                                "Continue",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: _isTapped ? const Color(0xE6FFFFFF) : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                  ) : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                    child: Text(
                      "",
                      style: TextStyle(
                        fontSize: 15,
                        color: ThemeColors().buttonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;

  const Indicator({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 7),
      width:
      isActive ? 30 : 10, // Width of circular rectangle for selected page
      height: 10,
      decoration: BoxDecoration(
        borderRadius: isActive
            ? BorderRadius.circular(5)
            : BorderRadius.circular(
            5), // BorderRadius.circular(5) for unselected pages
        shape: BoxShape.rectangle,
        color:
        isActive ? Colors.white : ThemeColors().deleteFromThisDevice,
      ),
    );
  }
}
