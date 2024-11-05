import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Components/Buttons/GradientButton.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/TourPartners.model.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';

import '../../Utils/Constants.dart';
import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';
import '../Buttons/CustomButton.dart';

class VerifiedSoulsCard extends StatelessWidget {
  final String name;
  final String fullName;
  final String tagline;
  final String age;
  final String city;
  final String country;
  final String rate;
  final VoidCallback onClick;
  final TourProfile selectedTourProfile;
  final String imageUrl;

  const VerifiedSoulsCard({
    super.key,
    required this.name,
    required this.fullName,
    required this.tagline,
    required this.age,
    required this.city,
    required this.country,
    required this.rate,
    required this.onClick,
    required this.selectedTourProfile,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: (){
        currentTourProfile = selectedTourProfile;
        Get.toNamed(RoutesClass.verifiedSoulsProfileScreen);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.width * 0.02,),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: Get.width * 0.015,
                      top: Get.height * 0.01,
                      right: Get.width * 0.01,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              "assets/images/gold_badge.png",
                              scale: 2.0,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 90,
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
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
                      height: 170,
                    ),
                  ),
                  Positioned(
                    bottom: Get.height * 0.01,
                    left: Get.width * 0.015,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            name.length > 10 ? '${name.substring(0, 10)}...' : name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                        ),
                        Text(
                          age,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: city,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                            ),
                            children: [
                              const TextSpan(
                                text: ", ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              TextSpan(
                                text: country,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w200,
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
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          fullName,
                          style: TextStyle(
                            fontSize: 14,
                            color: ThemeColors().buttonColor,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: rate,
                            style: TextStyle(
                              fontSize: 14,
                              color: ThemeColors().buttonColor,
                              fontWeight: FontWeight.bold,
                            ),
                            children:[
                              TextSpan(
                                text: " PKR/Hr",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColors().buttonColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/rating_star_icon_filled.png",
                          scale: 1.8,
                        ),
                        Image.asset(
                          "assets/icons/rating_star_icon_filled.png",
                          scale: 1.8,
                        ),
                        Image.asset(
                          "assets/icons/rating_star_icon_filled.png",
                          scale: 1.8,
                        ),
                        Image.asset(
                          "assets/icons/rating_star_icon.png",
                          scale: 1.8,
                        ),
                        Image.asset(
                          "assets/icons/rating_star_icon.png",
                          scale: 1.8,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "“$tagline”",
                        style: const TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    CustomButton(
                      name: "Let's Tour",
                      onClick: onClick,
                      color: ThemeColors().buttonColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


