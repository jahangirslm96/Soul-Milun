import 'package:get_storage/get_storage.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/data/network/BaseApiServices.dart';
import 'package:soul_milan/data/network/NetworkApiServices.dart';

class MessengerChatRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> LoadMessengerChats(String uID, String token) async{
    try{
      dynamic response = await _apiServices.getGetApiResponseWithToken("${apiLink}chat/$uID",token);
      return response;
    }catch(e){
      throw e;
    }
  }

}