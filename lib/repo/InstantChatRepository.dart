import 'package:get_storage/get_storage.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/data/network/BaseApiServices.dart';
import 'package:soul_milan/data/network/NetworkApiServices.dart';

class InstantChatRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> GetInstantChatApi(String uID, String token) async{
    try{
      dynamic response = await _apiServices.getGetApiResponseWithToken("${apiLink}chats/$uID",token);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> DeductInstantChat(int value, String uID, String token) async{
    try{
      dynamic response = await _apiServices.getGetApiResponseWithToken("${apiLink}chats/$uID/${value.toString()}",token);
      return response;
    }catch(e){
      throw e;
    }
  }

    Future<dynamic> InstantChatDate(String uID, String token) async{
    try{
      dynamic response = await _apiServices.getGetApiResponseWithToken("${apiLink + getprofile}/instantchatdate/$uID",token);
      return response;
    }catch(e){
      throw e;
    }
  }

}