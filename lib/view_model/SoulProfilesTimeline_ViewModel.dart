
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:soul_milan/Utils/Controller/model/PackageDetails.model.dart';
import 'package:soul_milan/Utils/Controller/model/ProfileModel/ProfileOverview.model.dart';
import 'package:soul_milan/Utils/Controller/model/ProfileModel/main/SoulProfilesTimeline.model.dart';
import 'package:soul_milan/repo/SoulTimelineRepository.dart';

import '../Utils/Routes.dart';

class SoulProfilesTimeline_ViewModel with ChangeNotifier{
  
  final _myRepo = SoulTimelineRepository();

  bool _isTimelineLoaded = false;
  bool get isTimelineLoaded => _isTimelineLoaded;

  //Main model of soul profile timelines
  SoulProfilesTimeline? soulProfilesTimeline;
  //================

  //current Selected Profile Preview
  ProfileOverview? _profileOverview;
  ProfileOverview get profileOverview => _profileOverview!;
  int tabIndex = -1;
  //================

  SoulProfilesTimeline_ViewModel(){
    //load initial data here.
  }

    resetData(){
      _isTimelineLoaded = false;
      soulProfilesTimeline = null;
      _profileOverview = null;
      tabIndex = -1;
      notifyListeners();
  }

  setLoading(bool value){
    _isTimelineLoaded = value;
    notifyListeners();
  }


  viewNextProfile(ProfileOverview profileOverview){
    if(profileOverview.profileData!.profileType == "Preferred"){

      return removeProfileFrom(soulProfilesTimeline!.preferred ,profileOverview);

    }else if(profileOverview.profileData!.profileType == "Similar"){

      return removeProfileFrom(soulProfilesTimeline!.similar ,profileOverview);

    }else if(profileOverview.profileData!.profileType == "NearBy"){

      return removeProfileFrom(soulProfilesTimeline!.nearBy ,profileOverview);

    }else{
      return removeProfileFrom(soulProfilesTimeline!.explore ,profileOverview);
    }

  }

  switchProfileTime(String profileType){
    if(profileType == "Preferred"){
       return checkIsTimeLineEmpty(soulProfilesTimeline!.preferred);

    }else if(profileType == "Similar"){

       return checkIsTimeLineEmpty(soulProfilesTimeline!.similar);

    }else if(profileType == "NearBy"){

       return checkIsTimeLineEmpty(soulProfilesTimeline!.nearBy);

    }else{
       return checkIsTimeLineEmpty(soulProfilesTimeline!.explore);
    }
  }

  checkIsTimeLineEmpty(List<ProfileOverview>? profileTimeline){
    if(profileTimeline!.isEmpty){
      return true;
    }else{
       ProfileOverview nextProfile = profileTimeline[0];
       _profileOverview = nextProfile;
       notifyListeners();
      return false;
    }
  }

  removeProfileFrom(List<ProfileOverview>? profileTimeline, ProfileOverview currentProfile){
    bool isRemoved = false;
    int index = -1;
    index = profileTimeline!.isNotEmpty ? profileTimeline
      .indexWhere((element) => element.profileData!.uId == currentProfile.profileData!.uId) : -1;

      if(index != -1){
        profileTimeline.removeAt(index);
        if(profileTimeline.isNotEmpty){
          ProfileOverview nextProfile = profileTimeline[0];
          _profileOverview = nextProfile;
          isRemoved = true;
        }else{
          isRemoved = false;
        }
      }
      notifyListeners();

      return isRemoved;
  }

  setCurrentProfilePreview(ProfileOverview profileOverview){
    _profileOverview = profileOverview;
    notifyListeners();
  }

  Future<dynamic> LoadSpecificProfile(String uId, String otherUid, String token, int selectedTabIndex) async {
    try {
      var value = await _myRepo.loadSpecificProfile(uId, otherUid, token);
      ProfileOverview profileOverview = ProfileOverview.fromJson(value["profileOverview"]);
      soulProfilesTimeline!.explore = [];
      soulProfilesTimeline!.explore!.add(profileOverview);
      setCurrentProfilePreview(profileOverview);
      tabIndex = selectedTabIndex;
      Get.toNamed(RoutesClass.soulProfileScreen);
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> showProfiles(String uId, dynamic body, String token, PackageType packageType) async {
  try {
    var value = await _myRepo.loadProfileTimeline(uId, body, token);
    soulProfilesTimeline = SoulProfilesTimeline.fromJson(value["profiles"]);
    if(packageType == PackageType.NONE){
      soulProfilesTimeline!.preferred = [];
    }

    setLoading(true);
  } catch (error) {
    print(error);
  }
}

}