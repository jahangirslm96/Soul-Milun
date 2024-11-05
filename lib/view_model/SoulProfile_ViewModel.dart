
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/ProfileModel/profileVerification.model.dart';

import '../Utils/Controller/model/Interaction.Model.dart';
import '../Utils/Controller/model/ProfileModel/ProfileOverview.model.dart';
import '../repo/SoulProfileRepository.dart';

class SoulProfile_ViewModel with ChangeNotifier{
  
  final _myRepo = SoulProfileRepository();

  bool _loading = false;
  bool get loading => _loading;

  //Verification Infos - start
  ProfileVerification? profileVerification;
  //Verification Infos - end

  //ProfileOverview - start
  bool isProfileOverviewLoaded = false;
  ProfileOverview? profileOverview;
  //ProfileOverview - end

  //Profile Explore - start
  Interaction? interaction = Interaction.fromJson({});
  //Profile Explore - end

  int pictureDeletingIndex = -1;

  SoulProfile_ViewModel(){
    //load initial data here.
  }

    resetData(){
      _loading = false;
      profileVerification = null;
      isProfileOverviewLoaded = false;
      profileOverview = null;
      interaction = Interaction.fromJson({});
      pictureDeletingIndex = -1;
      notifyListeners();
  }

  updateProfilePictures(List<String> pictures){
    profileOverview!.profileData!.pictures = pictures;
    profileOverview!.profileData!.profilePicture = pictures[0];
    notifyListeners();
  }

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  notify(){
    notifyListeners();
  }

  setPictureDelete(int index){
    pictureDeletingIndex = index;
    notifyListeners();
  }


void addInteraction(InteractWith interactWith) {

  if (interaction!.interact!.isNotEmpty) {
    // Check if the profile exists in any category
    int existingIndex = interaction!.interact!.indexWhere(
      (element) => element.interactWith!
          .any((existingProfile) => existingProfile.uId == interactWith.uId),
    );

    if (existingIndex != -1) {
      // Remove the profile from the existing category
      interaction!.interact![existingIndex].interactWith!
          .removeWhere((existingProfile) => existingProfile.uId == interactWith.uId);
    }

    // Find the index of the target category
    int targetIndex = interaction!.interact!
        .indexWhere((element) => element.name == interactWith.category);

    if (targetIndex != -1) {
      // Add the profile to the target category
      interaction!.interact![targetIndex].interactWith!.add(interactWith);
    }

    notifyListeners();
  }
}


  int getGender(){
    return profileOverview != null ? profileOverview!.profileData!.gender == "male" ? 0 : 1 : 0;
  }

   Future<dynamic> LoadProfileExplore() async {
    try {
      var value = await _myRepo.GetProfileExploreDetails(profileVerification!.uID!,profileVerification!.getAccessToken());
      interaction = Interaction.fromJson(value);
      setLoading(false);
    } catch (error) {
      print(error);
    }
  }

 Future<dynamic> LoadProfileOverView() async {
  isProfileOverviewLoaded = false;
  notifyListeners();
  try {
    var value = await _myRepo.ProfileOverView(profileVerification!.uID!, profileVerification!.getAccessToken());
    profileOverview = ProfileOverview.fromJson(value);
    isProfileOverviewLoaded = true;
    notifyListeners();
  } catch (error) {
    print(error);
  }
}
  
  LoadProfileVerification_FromStorage(Map<String, dynamic> json) async{
    profileVerification = ProfileVerification.fromJson(json);
    await LoadProfileOverView();
  }

 Future<dynamic> LoginAccount(String email, String password, String token) async {
  setLoading(true);
  try {
    var value = await _myRepo.Login(email, password, token);
    profileVerification =
        ProfileVerification.fromJson(value["ProfileData"]["profileVerification"]);
    profileOverview = ProfileOverview.fromJson(value["ProfileData"]["profileOverview"]);
    isProfileOverviewLoaded = true;
    connector = Connector(profileVerification!.getAccessToken());
    setLoading(false);
    return value;
  } catch (error) {
    setLoading(false);
    print(error);
  }
}

}