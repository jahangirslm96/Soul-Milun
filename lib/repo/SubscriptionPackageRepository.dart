import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/data/network/BaseApiServices.dart';
import 'package:soul_milan/data/network/NetworkApiServices.dart';

class SubscriptionPackageRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> LoadSubscriptionPackages() async{
    try{
      dynamic response = await _apiServices.getGetApiResponse(apiLink + connector.api.getPackageList);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> ActivatePackage(Map<String, dynamic> body, String token) async{
    try{
      dynamic response = await _apiServices.getPostApiResponseWithToken("$apiLink${connector.api.package}activate",body,token);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> CheckMemberShip(String uID, String token) async{
    try{
      dynamic response = await _apiServices.getGetApiResponseWithToken("$apiLink$package/info/$uID",token);
      return response;
    }catch(e){
      throw e;
    }
  }

}