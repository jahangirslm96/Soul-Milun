
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:soul_milan/repo/InstantChatRepository.dart';
import 'package:soul_milan/repo/SubscriptionPackageRepository.dart';
import 'package:soul_milan/view_model/InstantChat_ViewModel.dart';

import '../Utils/Controller/constant.dart';
import '../Utils/Controller/model/PackageDetails.model.dart';
import '../Utils/Controller/model/SubscriptionPackages.model.dart';
import '../Utils/CustomTheme.dart';
import '../Utils/Routes.dart';

class SubscriptionPackage_ViewModel with ChangeNotifier{
  
  final _myRepo = SubscriptionPackageRepository();
  final _instantChatRepo = InstantChatRepository();

  SubscriptionPackages? _SubscriptionPackages;
  SubscriptionPackages? get GetSubscriptionPackages => _SubscriptionPackages;

  PackageDetails? _PackageDetails;
  PackageDetails? get GetPackageDetails => _PackageDetails;

  Package? _selectedPackage;
  Package? get getSelectedPackage => _selectedPackage;

  PackageType currentPackageType = PackageType.NONE;

  Map<String, dynamic>? currentChatPackage;

  bool _loading = false;
  bool get loading => _loading;

  String screenCode = "package";

  SubscriptionPackage_ViewModel(){
  }

  resetData(){
      _PackageDetails = null;
      currentPackageType = PackageType.NONE;
      currentChatPackage = null;
      _loading = false;
      notifyListeners();
  }

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

    setSelectedPackage(Package choosenPackage){
      _selectedPackage = choosenPackage;
    }

    setScreenCode(String code){
      screenCode = code;
    }
    setCurrentChatPackage(Map<String, dynamic>? chatPackage){
      currentChatPackage = chatPackage;
    }

    Future<void> LoadSubscriptionPackages() async {
    setLoading(true);

    await _myRepo.LoadSubscriptionPackages().then((value){
      _SubscriptionPackages =  SubscriptionPackages.fromJson({"packages": value["packages"]});
      setLoading(false);
    }).onError((error, stackTrace){
      print(error);
      print(stackTrace);
    });
  }

    Future<void> buySubscription(Map<String,dynamic> body, String token) async {
    setLoading(true);
    _myRepo.ActivatePackage(body,token).then((value){
      currentPackageType = getPackageFromString(_selectedPackage!.name);
      setLoading(false);
      Get.toNamed(RoutesClass.congratsScreen);
      Get.snackbar(
      backgroundColor: CustomTheme().successColor,
      colorText: Colors.white,
      "Payment Successful",
      value != null ? value["message"] : "",
      duration: const Duration(seconds: 5),
    );
    
    }).onError((error, stackTrace){
      print(error);
      print(stackTrace);
    });
  }

    Future<void> CheckMemberShip(String uID, String token, InstantChats_ViewModel instantChats_ViewModel) async {
    setLoading(true);

    await _myRepo.CheckMemberShip(uID, token).then((value){
      if(value["success"] == true){
      _PackageDetails = PackageDetails.fromJson(value["response"]);

      if(_PackageDetails!.isSubscriptionActive()){
        currentPackageType = getPackageFromString(_PackageDetails!.package!);

        print(getPackageStringName());
        if(_PackageDetails!.newInstantChat == "true"){   
          _PackageDetails!.newInstantChat = "false";
          _instantChatRepo.InstantChatDate(uID, token);
          instantChats_ViewModel.AddInstantChat(_PackageDetails!.freeChats!, uID, token);
          //  var userPackage = await api.getWithToken("${connector.api.getprofile}/instantchatdate/$uID", token);
        }
      }else{
        _PackageDetails = PackageDetails();
        currentPackageType = PackageType.NONE;
      }
      }else{
         _PackageDetails = PackageDetails();
        currentPackageType = PackageType.NONE;
      }

      setLoading(false);
    }).onError((error, stackTrace){
      print(error);
      print(stackTrace);
    });
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

  String getPackageStringName() {
    switch (currentPackageType) {
      case PackageType.BASIC:
        return "BASIC";
      case PackageType.SILVER:
        return "SILVER";
      case PackageType.GOLD:
        return "GOLD";
      case PackageType.PLATINIUM:
        return "PLATINIUM";
      default:
        return "NONE";
    }
    
  }
}