import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/view_model/SoulProfilesTimeline_ViewModel.dart';

import '../../Utils/Constants.dart';
import '../../Utils/ThemeColors.dart';
import '../DropDowns/CustomDropDown1.dart';
import '../DropDowns/CustomDropDown2.dart';

class CustomHeader2 extends StatefulWidget {
  const CustomHeader2({
    super.key,
  });

  @override
  State<CustomHeader2> createState() => _CustomHeader2State();
}

class _CustomHeader2State extends State<CustomHeader2> {
  bool isTapped = false;
  bool isTapped2 = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel = Provider.of<SoulProfilesTimeline_ViewModel>(context , listen:  false);
    profileFilters = profileFiltersItems[_indexOf(profileFiltersItems,soulProfilesTimeline_ViewModel.profileOverview.profileData!.profileType!)];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTapDown: (_) {
            setState(() {
              isTapped2 = true;
            });
          },
          onTapCancel: () {
            setState(() {
              isTapped2 = false;
            });
          },
          onTapUp: (_) {
            Future.delayed(const Duration(milliseconds: 35), () {
              setState(() {
                isTapped2 = false;
              });
            });
          },
          onTap: () {
            Get.back();
          },
          child: ColorFiltered(
            colorFilter: isTapped2
                ? ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.srcATop,
            )
                : const ColorFilter.mode(
              Colors.transparent,
              BlendMode.srcATop,
            ),
            child: const SizedBox(
              width: 23,
              height: 23,
              child: Icon(
                Icons.arrow_back_ios_rounded,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Flexible(
          child: Center(
            child: CustomDropDown2(
                product: profileFilters,
                productItems: profileFiltersItems,
                onChanged: dropDownValueProfileFilter,
                label: "Select",
              ),
          ),
        ),
        /*GestureDetector(
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
          onTap: () {
            Get.toNamed(RoutesClass.matchMyPerfectSoulScreen);
          },
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
            child: SizedBox(
              height: 30,
              width: 30,
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
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    "assets/icons/filter_icon.png",
                    fit: BoxFit.cover,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),*/
      ],
    );
  }

  void previousScreen() {
    Get.toNamed(RoutesClass.homeScreen);
  }

  void dropDownValueProfileFilter(String? value) {
    setState(() {
      profileFilters = (value) as String;
    });

    SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel = Provider.of<SoulProfilesTimeline_ViewModel>(context , listen:  false);
    if(soulProfilesTimeline_ViewModel.switchProfileTime(profileFilters)){
      //switch screen
      Get.toNamed(RoutesClass.homeScreen);
    }


  }

    int _indexOf(List<String> arrayToSearch, String element) {
    return arrayToSearch.indexOf(element);
  }
}
