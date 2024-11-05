abstract class BaseApiServices{

  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic body);
  Future<dynamic> getGetApiResponseWithToken(String url, String bearerToken);
  Future<dynamic> getPostApiResponseWithToken(String url, dynamic body, String bearerToken);
  

}