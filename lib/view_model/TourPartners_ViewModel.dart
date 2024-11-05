
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul_milan/repo/TourerProfileRepository.dart';

import '../Utils/Controller/model/TourPartners.model.dart';

class TourPartners_ViewModel with ChangeNotifier{
  
  final _myRepo = TourerProfileRepository();

  bool _isTimelineLoaded = false;
  bool get isTimelineLoaded => _isTimelineLoaded;

  //Tourer Timeline
  TourPartners? tourPartners;
  TourProfile? currentTourProfile; //for showing specific tour profile in detail
  String tourCode = "";

  bool isCreatingTourReq = false;
  //Tourer Timeline - end

  TourPartners_ViewModel(){
    //load initial data here.
  }

  resetData(){
      _isTimelineLoaded = false;
      tourPartners = null;
      currentTourProfile = null;
      tourCode = "";
      isCreatingTourReq = false;
      notifyListeners();
  }

  setTourLoading(bool value){
    isCreatingTourReq = value;
    notifyListeners();
  }
  
  getTourerTimeline(String gender){
    return gender == "male" ? tourPartners!.tourTimeline!.males : tourPartners!.tourTimeline!.females;
  }

  selectTourerProfile(TourProfile tourProfile){
    currentTourProfile = tourProfile;
  }

  setTourCode(String value){
    tourCode = value;
  }


  setLoading(bool value){
    _isTimelineLoaded = value;
    notifyListeners();
  }

    LoadTourerTimeline(String uID, String token) async {
     await _myRepo.LoadTourers(uID, token).then((value){
      tourPartners = value["response"] != null ? TourPartners.fromJson({"TourTimeline":value["response"]}) : TourPartners();
        setLoading(true);
      }).onError((error, stackTrace){
        print(error);
      });
  }

}
