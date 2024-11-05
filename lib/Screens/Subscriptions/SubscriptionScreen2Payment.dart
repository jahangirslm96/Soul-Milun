import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Components/Headers/HeaderWithBackIcon.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/view_model/InstantChat_ViewModel.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';
import 'package:soul_milan/view_model/SubscriptionPackage_ViewModel.dart';

import '../../Components/Buttons/CustomButton.dart';
import '../../Components/RadioButtons/CustomRadioButtons2.dart';
import '../../Utils/Controller/constant.dart';
import '../../Utils/Controller/model/PackageDetails.model.dart';
import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';

class SubscriptionScreen2Payment extends StatefulWidget {
  const SubscriptionScreen2Payment({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen2Payment> createState() => _SubscriptionScreen2PaymentState();
}

class _SubscriptionScreen2PaymentState extends State<SubscriptionScreen2Payment> {
  late bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: headerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWithBackIcon(
                  title: "Payment",
                  subtitle: "Select Payment Method.",
                ),
                Padding(
                  padding: mainBodyPadding,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      const CustomRadioButtons2(),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.02),
                        child: Divider(
                          color: ThemeColors().containerOutlineColor,
                          thickness: Get.height *0.0005,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.04),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15.0),
                          onTap: toAddCardScreen,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: Get.height * 0.02, horizontal: Get.width * 0.08),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add_card_outlined,
                                  size: 20,
                                  color: ThemeColors().iconColor,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: Get.width *  0.02),
                                  child: Text(
                                    "Add Card",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.3),
                        child: Consumer<SoulProfile_ViewModel>(builder: (context, soulProfile_ViewModel, child) => 
                          Consumer<SubscriptionPackage_ViewModel>(builder: (context, subscriptionPackage_ViewModel, child) => 
                             CustomButton(
                              name: "Confirm Payment",
                              isLoading: subscriptionPackage_ViewModel.loading,
                              onClick: () => nextScreen(soulProfile_ViewModel,subscriptionPackage_ViewModel),
                              color: ThemeColors().buttonColor,
                            )
                          ),
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
    );
  }
  void toAddCardScreen() async {
    Get.toNamed(RoutesClass.addCardScreen);
  }

  PackageType getPackageFromString(String packageString) {
    switch (packageString) {
      case "BASIC":
        return PackageType.BASIC;
      case "SILVER":
        return PackageType.SILVER;
      case "GOLD":
        return PackageType.GOLD;
      case "PLATINIUM":
        return PackageType.PLATINIUM;
      default:
        return PackageType.NONE;
    }
  }

   nextScreen(SoulProfile_ViewModel soulProfile_ViewModel, SubscriptionPackage_ViewModel subscriptionPackage_ViewModel) async {
    // setState(() {
    //   isLoading = true;
    // });
    
    if(subscriptionPackage_ViewModel.screenCode == "package"){

      Map<String, dynamic> PackageDetail = {
        "pID": subscriptionPackage_ViewModel.getSelectedPackage!.pid,
        "uID": soulProfile_ViewModel.profileOverview!.profileData!.uId,
        "startingDate": DateTime.now().toLocal().toString(),
        "expiryDate": DateTime.now().add(Duration(days: subscriptionPackage_ViewModel.getSelectedPackage!.daysLimit)).toString(),
      };

      if(subscriptionPackage_ViewModel.currentPackageType == PackageType.NONE){
        subscriptionPackage_ViewModel.buySubscription(PackageDetail, soulProfile_ViewModel.profileVerification!.getAccessToken());
      }else{
        Get.snackbar(
        backgroundColor: CustomTheme().errorColor,
        colorText: Colors.white,
        "Already Subscribed",
        "You already subscribed to the membership",
        duration: const Duration(seconds: 2),
      );
      }
    }else{

      InstantChats_ViewModel instantChats_ViewModel = Provider.of<InstantChats_ViewModel>(context, listen:  false);
      if(instantChats_ViewModel.GetInstantChats!.chats! > 0){
        Get.snackbar(
        backgroundColor: CustomTheme().errorColor,
        colorText: Colors.white,
        "Use Instant Chats",
        "Use remaining chats first.",
        duration: const Duration(seconds: 2),
      );
        return;
      }
      await instantChats_ViewModel.AddInstantChat(subscriptionPackage_ViewModel.currentChatPackage!["chats"], soulProfile_ViewModel.profileOverview!.profileData!.uId!, soulProfile_ViewModel.profileVerification!.getAccessToken());
      Get.toNamed(RoutesClass.profileSettingsScreen);
    }
    
    // var response =
    //     await connector.post(connector.api.package+"activate",PackageDetail);

    // print(response);
    // if(response != null && response["success"] == true){
    //   currentPackageType = getPackageFromString(selectedPackage.name);
    //   Get.toNamed(RoutesClass.congratsScreen);
    // }
   
    // Get.snackbar(
    //   backgroundColor: CustomTheme().successColor,
    //   colorText: Colors.white,
    //   "Payment Successful",
    //   response != null ? response["message"] : "",
    //   duration: const Duration(seconds: 5),
    // );
    // setState(() {
    //   isLoading = false;
    // });
  }

/*  void nextScreen() async {
    if (_formKey.currentState!.validate()) {
      Get.toNamed(RoutesClass.newPasswordScreen);
    }
  }*/
}
