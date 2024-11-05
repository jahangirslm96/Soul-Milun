import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';
import 'package:soul_milan/view_model/SubscriptionPackage_ViewModel.dart';
import 'package:video_player/video_player.dart';

import '../../Utils/Constants.dart';
import '../../Utils/Routes.dart';
import '../AlertBox/DialogBox1.dart';

class InstantChatsCard extends StatefulWidget {
  Map<String, dynamic>? data;
  final bool hasSubscription; // New property to determine if the user has a subscription
  InstantChatsCard({
    super.key,
    this.hasSubscription = false, // Default is no subscription
    this.data,
  });

  @override
  State<InstantChatsCard> createState() => _InstantChatsCardState();
}

class _InstantChatsCardState extends State<InstantChatsCard> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTapped = true;
        });
        Future.delayed(const Duration(milliseconds: 25), () {
          if (!widget.hasSubscription) {
            showDialog(
                context: context,
                builder: (BuildContext context) => DialogBox1(
                  buttonText: "Back",
                  heading: "Instant Chats Locked!",
                  subHeading: "Subscription is required for buying instant chats",
                  onTap: (){
                    Get.back();
                  },
                )
            );
            setState(() {
              isTapped = false;
            });
          }
          else{
            setState(() {
              isTapped = true;
            });
            setScreenCode("chats");
            setState(() {
              isTapped = false;
            });
          }
        });
      },
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
      child: ShowUpAnimation(
        animationDuration: Duration(milliseconds: widget.data!["duration"]),
        curve: Curves.decelerate,
        direction: Direction.horizontal,
        delayStart: const Duration(milliseconds: 700),
        offset: 0.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Card content
            Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * 0.02),
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
                  padding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.01, horizontal: Get.width * 0.02),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: widget.data!["gradientColors"],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, 2.0), // (dx, dy)
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.data!["type"],
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        widget.data!["details"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.08),
                      Text(
                        widget.data!["price"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.010),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.010,
                            horizontal: Get.width * 0.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: Text(
                          "Get Now",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.0,
                            color: ThemeColors().buttonColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Lock icon (conditionally shown based on subscription status)
            if (!widget.hasSubscription)
              const Opacity(
                opacity: 0.6,
                child: Icon(
                  Icons.lock,
                  size: 40,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }


  setScreenCode(String screenCode){
    SubscriptionPackage_ViewModel subscriptionPackage_ViewModel = Provider.of<SubscriptionPackage_ViewModel>(context, listen:  false);
    subscriptionPackage_ViewModel.setScreenCode(screenCode);
    subscriptionPackage_ViewModel.setCurrentChatPackage(widget.data);
    Get.toNamed(RoutesClass.subscriptionScreen2Payment);
  }
}
