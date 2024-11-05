import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../Utils/ThemeColors.dart';
import '../Buttons/SubscriptionButton.dart';

class SubscriptionCard extends StatefulWidget {
  final String type;
  final String details;
  final String price;
  final NetworkImage image;
  final VoidCallback onClick;
  final int duration;

  const SubscriptionCard({
    super.key,
    required this.type,
    required this.details,
    required this.price,
    required this.image,
    required this.onClick,
    required this.duration,
  });

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: GestureDetector(
        onTap: () {
          widget.onClick();
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
        onTapUp: (_) {
          Future.delayed(const Duration(milliseconds: 35), () {
            setState(() {
              isTapped = false;
            });
          });
        },
        child: ShowUpAnimation(
          animationDuration:  Duration(milliseconds: widget.duration),
          curve: Curves.decelerate,
          direction: Direction.horizontal,
          offset: 0.6,
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
              padding: EdgeInsets.symmetric(vertical: Get.height*0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: widget.image, // Use the NetworkImage directly
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0.0, 2.0), // (dx, dy)
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.02,
                  horizontal: Get.width * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.details,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.06),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${widget.price} PKR",
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width * 0.2,),
                          const Expanded(
                            child: SubscriptionButton(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
