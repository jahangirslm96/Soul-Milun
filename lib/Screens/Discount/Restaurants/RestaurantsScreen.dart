import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Components/Headers/CustomHeader4.dart';

import '../../../Utils/Constants.dart';
import '../../../Utils/ThemeColors.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: subscriptionBodyPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomHeader4(
                      name: "Restaurants",
                    ),
                    TextFormField(
                      cursorColor: ThemeColors().labelTextColor,
                      style: TextStyle(
                        color: ThemeColors().onBoardingHeadingColor,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(
                            color: ThemeColors().enabledBorderColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(
                            width: 2,
                            color: ThemeColors().labelTextColor,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.020, horizontal: Get.width * 0.04),
                        hintStyle: TextStyle(
                          color: ThemeColors().buttonColor,
                          fontSize: 14,
                        ),
                        hintText: "Search",
                        suffixIconConstraints: const BoxConstraints (minWidth: 24, minHeight: 24,),
                        suffixIcon: GestureDetector(
                          onTap: (){},
                          child: Padding(
                            padding: EdgeInsets.only(right: Get.width * 0.05,),
                            child: Icon(
                              Icons.search,
                              size: 20,
                              color: ThemeColors().iconColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: ThemeColors().containerOutlineColor,
                thickness: Get.height *0.0005,
              ),
              Padding(
                padding: mainBodyPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Exclusive Discounts",
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeColors().buttonColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.02,),
                      child: GridView.builder(
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: restaurantTypes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Image.asset(restaurantImageArray[index], fit: BoxFit.cover,),
                              Padding(
                                padding: EdgeInsets.only(top: Get.height * 0.01),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      restaurantTypes[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ThemeColors().buttonColor,
                                      ),
                                    ),
                                    Text(
                                      "15% off",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: ThemeColors().buttonColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
