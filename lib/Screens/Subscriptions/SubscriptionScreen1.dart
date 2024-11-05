import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Components/AlertBox/SubscriptionAlertBox.dart';
import 'package:soul_milan/Components/Card/SubscriptionCard.dart';
import 'package:soul_milan/Components/Headers/SubscriptionHeaderWithBackIcon.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/Controller/model/PackageDetails.model.dart';
import 'package:soul_milan/view_model/InstantChat_ViewModel.dart';
import 'package:soul_milan/view_model/SubscriptionPackage_ViewModel.dart';

import '../../Components/Card/InstantChatsCard.dart';
import '../../Components/Rows/CustomRow.dart';
import '../../Utils/Controller/constant.dart';
import '../../Utils/Controller/model/SubscriptionPackages.model.dart';
import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
 bool isLoaded = false;

 Color tileColor = ThemeColors().labelTextColor;
 Color textColor = Colors.white;

  @override
  void initState() {
    super.initState();
  }

  Future<void> showSubscriptionPackages() async {
    isLoaded = false;
    await loadPackageList(); // Assuming loadChat is an asynchronous function
    setState(() {
      print("Package list loaded.");
    });
  }

  loadPackageList() async {
    var response =
        await connector.get(connector.api.getPackageList);
    if (response['success'] == true) {
       print(response);
      subscriptionPackages = SubscriptionPackages.fromJson({"packages": response["packages"]});
      isLoaded = true;
    } else {
      
    }
  }

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
    SubscriptionPackage_ViewModel subscriptionpackageViewmodel = Provider.of<SubscriptionPackage_ViewModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SubscriptionHeader(
                        text1: "SOUL",
                        text2: " SHOP",
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width *0.02, right: Get.width *0.02, top: Get.height *0.04,),
                      child: Text(
                        "Subscription Plans",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors().buttonColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: mainBodyPadding2,
                child: _subscriptionPackagesUI(subscriptionpackageViewmodel),
              ),
              Padding(
                padding: subscriptionBodyPadding,
                child: Padding(
                  padding: EdgeInsets.only(left: Get.width *0.02, right: Get.width *0.02, top: Get.height *0.02,),
                  child: Text(
                    "Instant Chats",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors().buttonColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: mainBodyPadding2,
                child: Consumer<SubscriptionPackage_ViewModel>(builder: (context, subscriptionPackage_ViewModel, child) => 
                Consumer<InstantChats_ViewModel>(builder: (context, instantChats_ViewModel, child) => 
                  GridView.builder(
                  itemCount: instantChats_ViewModel.instantChatsData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                    childAspectRatio: 0.75, // Adjust this aspect ratio as needed
                  ),
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = instantChats_ViewModel.instantChatsData[index];
                    return InstantChatsCard(
                      data: data,
                      hasSubscription: subscriptionPackage_ViewModel.currentPackageType == PackageType.NONE ? false : true,
                    );
                  },
                )
                ),
                ),
              ),
              SizedBox(height: Get.height * 0.025,),
            ],
          ),
        ),
      ),
    );
  }

  _subscriptionPackagesUI(SubscriptionPackage_ViewModel subscriptionPackageViewModel){
    if(subscriptionPackageViewModel.loading){
      return const Column(
          children: [
            Text(
              "Loading",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
      );
    }

    return  Column(
        children: [
          ListView.builder(
            itemCount: subscriptionPackageViewModel.GetSubscriptionPackages?.packages.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => SubscriptionCard(
              type: subscriptionPackageViewModel.GetSubscriptionPackages!.packages[index].name,
              details: "${calculateTimePeriod(subscriptionPackageViewModel.GetSubscriptionPackages!.packages[index].daysLimit)} Subscription ",
              price: subscriptionPackageViewModel.GetSubscriptionPackages!.packages[index].price.toString(),
              image: NetworkImage("${assestUrl}SubscriptionImage/${subscriptionPackageViewModel.GetSubscriptionPackages!.packages[index].coverPicture}"),
              onClick: () => {
                Future.delayed(const Duration(milliseconds: 50), () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SubscriptionAlertBox(
                        package: subscriptionPackageViewModel.GetSubscriptionPackages!.packages[index],
                      );
                    },
                  );
                })
              },
              duration: durationSubscriptionCard[index],
            ),
          ),
        ],
    );
  }
}
