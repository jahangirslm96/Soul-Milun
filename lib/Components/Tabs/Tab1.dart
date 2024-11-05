import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/ProfileModel/ProfileOverview.model.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';
import 'package:soul_milan/view_model/SoulProfilesTimeline_ViewModel.dart';
import 'package:soul_milan/view_model/SubscriptionPackage_ViewModel.dart';

import '../../Utils/Constants.dart';
import '../../Utils/Controller/model/TourPartners.model.dart';
import '../../view_model/SoulProfile_ViewModel.dart';
import '../Blocks/ProfileBlock.dart';

class Tab1 extends StatefulWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  @override
  void initState() {
    super.initState();

    currentTourProfile = TourProfile(uId: "");
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<SoulProfilesTimeline_ViewModel>(builder: (context, value, child) => _BuildTimeline(value),),
    );
  }

  _BuildTimeline(SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel){

    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
    SubscriptionPackage_ViewModel subscriptionPackage_ViewModel = Provider.of<SubscriptionPackage_ViewModel>(context, listen: false);

    if(!soulProfilesTimeline_ViewModel.isTimelineLoaded){

    List<String> ageFilter = [mainFilter.minAgeFilter, mainFilter.maxAgeFilter];
    Map<String, dynamic> filter = {
      "gender": soulProfile_ViewModel.getGender().toString(),
      "age": ageFilter.toString(),
      "preferenceFilter": jsonEncode(preferenceInfo),
      "education": mainFilter.educationFilter
      // "height": '0',
      // "education" : "0",
      // "city": "0"
    };

    print(subscriptionPackage_ViewModel.getPackageStringName());
    soulProfilesTimeline_ViewModel.showProfiles(
      soulProfile_ViewModel.profileVerification!.uID!, 
      filter, 
      soulProfile_ViewModel.profileVerification!.getAccessToken(),
      subscriptionPackage_ViewModel.currentPackageType
    );
    return Padding(
        padding: tab1Padding,
        child: Column(
          children: [
            ProfileBlock(
              title: 'Preferred',
              profile: dummyProfileCardData(),
              isLoading: false,
            ),
            ProfileBlock(
              title: 'Similar',
              profile: dummyProfileCardData(),
              isLoading: false,
            ),
            ProfileBlock(
              title: 'NearBy',
              profile: dummyProfileCardData(),
              isLoading: false,
            )
          ],
        ),
      );
    }

  return Padding(
  padding: tab1Padding,
  child: Column(
    children: [
      ProfileBlock(
        title: 'Preferred',
        profile: soulProfilesTimeline_ViewModel.soulProfilesTimeline!.preferred!,
        isLoading: true,
      ),
      ProfileBlock(
        title: 'Similar',
        profile: soulProfilesTimeline_ViewModel.soulProfilesTimeline!.similar!,
        isLoading: true,
      ),
      ProfileBlock(
        title: 'NearBy',
        profile: soulProfilesTimeline_ViewModel.soulProfilesTimeline!.nearBy!,
        isLoading: true,
      )
    ],
  ),
);
}

 List<ProfileOverview> dummyProfileCardData(){
  List<ProfileOverview> dummyData = [];

  ProfileOverview profileOverview = ProfileOverview();
  for(int i = 0; i < 5; i++){
    dummyData.add(profileOverview);
  }

  return dummyData;
 }
}
