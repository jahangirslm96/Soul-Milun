
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/InstantChats.model.dart';
import 'package:soul_milan/repo/InstantChatRepository.dart';

class InstantChats_ViewModel with ChangeNotifier{
  
  final _myRepo = InstantChatRepository();

  InstantChats? _instantChats;
  InstantChats? get GetInstantChats => _instantChats;

  bool _loading = false;
  bool get loading => _loading;

  List<Map<String, dynamic>> instantChatsData = [
  {
    'type': 'Silver',
    'details': '10 Instant Chats',
    'price': '500 PKR',
    'gradientColors': [const Color(0xFF000000), const Color(0xFFB0BEC5), const Color(0xFFEEEEEE)],
    'duration': 700,
    'chats': 10,
  },
  {
    'type': 'Gold',
    'details': '20 Instant Chats',
    'price': '1000 PKR',
    'gradientColors': [const Color(0xFF0052D4), const Color(0xFF20BDFF), const Color(0xFF5433FF),],
    'duration': 900,
    'chats': 20,
  },
  {
    'type': 'Platinum',
    'details': '30 Instant Chats',
    'price': '1500 PKR',
    'gradientColors': [const Color(0xFF000000), const Color(0xFF1A237E), const Color(0xFF9C27B0),],
    'duration': 1100,
    'chats': 30,
  },
];

  resetData(){
    _loading = false;
    _instantChats = null;
    notifyListeners();
  }

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }
  DeductInstantChat(String uID, String token) async {
    setLoading(true);

    if(_instantChats!.chats! > 0){
      _instantChats!.chats =  _instantChats!.chats! - 1;
      await _myRepo.DeductInstantChat(-1, uID, token).then((value){
        _instantChats =  InstantChats.fromJson(value["response"]);
        setLoading(false);
      }).onError((error, stackTrace){
        print(error);
      });
    }else{
         Get.snackbar(
                  "No Instant Chats left.",
                  "Buy Instant Chats",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                setLoading(false);
    }

  }

  AddInstantChat(int val, String uID, String token) async {
    setLoading(true);
     await _myRepo.DeductInstantChat(val, uID, token).then((value){
        _instantChats =  InstantChats.fromJson(value["response"]);
         Get.snackbar(
                  "Congrats! "+ val.toString() +" New Instant Chat",
                  "You have now ${_instantChats?.chats} Instant Chahts",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
        setLoading(false);
      }).onError((error, stackTrace){
        print(error);
      });

  }

  Future<void> LoadInstantChats(String uID, String token) async {
    setLoading(true);

    _myRepo.GetInstantChatApi(uID, token).then((value){
      _instantChats =  InstantChats.fromJson(value["response"]);
      if(isNewInstantChat){
        isNewInstantChat = false;
        _instantChats!.chats =  _instantChats!.chats! + 1;
        AddInstantChat(1,uID,token);
      }
      setLoading(false);
    }).onError((error, stackTrace){
      print(error);
    });
  }
}
