import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/data/network/BaseApiServices.dart';
import 'package:soul_milan/data/network/NetworkApiServices.dart';

class SoulTimelineRepository{

  BaseApiServices _apiServices = NetworkApiServices();


  Future<dynamic> loadProfileTimeline(String uID, dynamic body, String token) async{
    try{
      dynamic response = await _apiServices.getPostApiResponseWithToken("$apiLink$match/$uID",body,token);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> loadSpecificProfile(String uID, String otherProfileUID, String token) async{
    try{
      dynamic response = await _apiServices.getGetApiResponseWithToken("$apiLink$getprofile/more/$otherProfileUID/$uID",token);
      return response;
    }catch(e){
      throw e;
    }
  }

}