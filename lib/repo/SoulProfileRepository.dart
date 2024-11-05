import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/data/network/BaseApiServices.dart';
import 'package:soul_milan/data/network/NetworkApiServices.dart';

class SoulProfileRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> Login(String email, String password,String token) async{
    var loginData = {
        "email": email,
        "password": password,
        "token": token
    };
    try{
      dynamic response = await _apiServices.getPostApiResponse(apiLink + login,loginData);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> ProfileOverView(String uID, String token) async{
    try{
      dynamic response = await _apiServices.getGetApiResponseWithToken("$apiLink${getprofile}overview/$uID",token);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> GetProfileExploreDetails(String uID,String token) async{
    try{
      dynamic response = await _apiServices.getGetApiResponseWithToken("$apiLink$intereaction$uID",token);
      return response;
    }catch(e){
      throw e;
    }
  }

}