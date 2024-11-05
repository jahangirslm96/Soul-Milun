import 'dart:convert';
import 'dart:io';

import 'package:soul_milan/data/app_exceptions.dart';
import 'package:soul_milan/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices{

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException {
      throw FetchDataException('No Internet Connection');
    }


    return responseJson;

  }

  @override
  Future<dynamic> getGetApiResponseWithToken(String url, String bearerToken) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $bearerToken', // Add the bearer token to headers
          // Add other headers if needed
        },
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
  
  @override
  Future<dynamic> getPostApiResponseWithToken(String url, dynamic data, String bearerToken) async {
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $bearerToken', // Add the bearer token to headers
          // Add other headers if needed
        },
        body: data
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async{
    dynamic responseJson;
    try{
      final response = await http.post(
        Uri.parse(url),
        body: data
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    }on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    
    return responseJson;
  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;
      case 400:
      throw BadRequestException(response.body.toString());
      case 401:
      throw BadRequestException(response.body.toString());
      case 404:
      throw UnauthorizedException(response.body.toString());
      default:
        throw FetchDataException("Error occured while communicating with server with status code "+response.statusCode.toString());
    }

  }


}