import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';
import '../Buttons/CustomButton.dart';

class DiscountDialogBox extends StatelessWidget {
  const DiscountDialogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05,vertical: Get.height * 0.01),
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
                    children:[
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
                  child: Text(
                    "Deals & Coupons",
                    style: TextStyle(
                      color: ThemeColors().buttonColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02, vertical: Get.height * 0.04),
                child: ListBody(
                  children:[
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.005),
                      leading: Image.asset(
                        "assets/icons/green_tick_icon.png",
                        scale: 2,
                      ),
                      title: Text(
                        "You can Earn Money by offering or getting tour offer",
                        style: TextStyle(
                          fontSize: 16,
                          color: ThemeColors().buttonColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.000005),
                      leading: Image.asset("assets/icons/green_tick_icon.png", scale: 2,),
                      title: Text(
                        "You can spend money by hiring verified soul member by offering them tour",
                        style: TextStyle(
                          fontSize: 16,
                          color: ThemeColors().buttonColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                name: "Proceed",
                onClick: (){
                  Get.toNamed(RoutesClass.discountsScreen);
                },
                color: ThemeColors().buttonColor,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: (){
                  Get.back();
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.013),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 15,
                        color: ThemeColors().buttonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
