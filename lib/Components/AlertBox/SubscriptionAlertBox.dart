import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/view_model/SubscriptionPackage_ViewModel.dart';

import '../../Utils/Controller/constant.dart';
import '../../Utils/Controller/model/SubscriptionPackages.model.dart';
import '../../Utils/CustomTheme.dart';
import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';
import '../Buttons/CustomButton.dart';

class SubscriptionAlertBox extends StatelessWidget {
  final Package package;

  const SubscriptionAlertBox({
    super.key,
    required this.package

  });

    String calculateTimePeriod(int days) {
  if (days >= 365) {
    int years = days ~/ 365;
    return years == 1 ? '$years year' : '$years years';
  } else if (days >= 30) {
    int months = days ~/ 30;
    return months == 1 ? '$months month' : '$months months';
  } else if (days >= 7) {
    int weeks = days ~/ 7;
    return weeks == 1 ? '$weeks week' : '$weeks weeks';
  } else {
    return days == 1 ? '$days day' : '$days days';
  }
}

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05,),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                package.name,
                style: TextStyle(
                  fontSize: CustomTheme().onBoardingHeadingFontSize,
                  color: ThemeColors().buttonColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Duration: ${calculateTimePeriod(package.daysLimit)}",
                  style: TextStyle(
                    fontSize: 14,
                    color: ThemeColors().buttonColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: package.price.toString(),
                  style: TextStyle(
                    color: ThemeColors().soulColor,
                    fontSize: CustomTheme().subDetails,
                    fontWeight: FontWeight.bold,
                  ),
                  children:[
                    TextSpan(
                      text: " PKR",
                      style: TextStyle(
                        color: ThemeColors().buttonColor,
                        fontSize: CustomTheme().subDetails,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
             for (var item in package.given)
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.000005),
                  leading: const Icon(Icons.check, color: Colors.green),
                  title: Text(
                    item,
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeColors().buttonColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomButton(
                        name: "Cancel",
                        onClick: () => {
                          Get.back()
                        },
                        color: CustomTheme().errorColor,
                        onTapColor: Colors.red.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Expanded(
                      flex: 1,
                      child: Consumer<SubscriptionPackage_ViewModel>(builder: (context, value, child) => 
                        CustomButton(
                        name: "Proceed",
                        onClick: () => nextScreen(value, context),
                        color: ThemeColors().buttonColor,
                      )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  nextScreen(SubscriptionPackage_ViewModel subscriptionPackage_ViewModel, BuildContext context) async {
    // selectedPackage = package;
      Navigator.pop(context);
      subscriptionPackage_ViewModel.setScreenCode("package");
      subscriptionPackage_ViewModel.setSelectedPackage(package);
      Get.toNamed(RoutesClass.subscriptionScreen2Payment);
  }
}
