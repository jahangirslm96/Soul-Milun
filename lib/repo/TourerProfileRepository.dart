import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/data/network/BaseApiServices.dart';
import 'package:soul_milan/data/network/NetworkApiServices.dart';

class TourerProfileRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> LoadTourers(String uID, String token) async{  
    try{
      dynamic response = await _apiServices.getGetApiResponseWithToken(apiLink + connector.api.earner + uID,token);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> LoadTourerRequestData(String TOID, String token) async{  
    try{
      dynamic response = await _apiServices.getGetApiResponseWithToken(apiLink + connector.api.bookTour + TOID, token);
      return response;
    }catch(e){
      throw e;
    }
  }

}