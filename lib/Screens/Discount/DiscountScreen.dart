import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Components/Card/DiscountCard.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/Routes.dart';

import '../../Components/Headers/CustomHeader.dart';
import '../../Components/NavigationBar/CustomBottomNavigationBar.dart';

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({Key? key}) : super(key: key);


  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: subscriptionBodyPadding,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.018,
                    ),
                    const CustomHeader(
                      name: "Deals and Coupons",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: mainBodyPadding,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: discountTypes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
                      child: GestureDetector(
                        onTap: (){
                          Get.toNamed(RoutesClass.restaurantsScreen);
                        },
                        child: Container(
                          height: Get.height * 0.15,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            image: DecorationImage(
                              image: AssetImage(imageArray[index]),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.srcOver),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, bottom: Get.height * 0.03,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  discountTypes[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                    },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
