import 'AuthToken.model.dart';

class ProfileVerification {
    String? uID;
    int? isVerified;
    int? isProfileComplete;
    int? isSelfieVerified;
    int? isInterest;
    int? isLocation;
    String? email;
    String? phoneNumber;
    AuthToken? authToken;

    ProfileVerification({
        this.uID,
        this.isVerified,
        this.isProfileComplete,
        this.isSelfieVerified,
        this.isInterest,
        this.isLocation,
        this.email,
        this.phoneNumber,
        this.authToken,
        
    });

    factory ProfileVerification.fromJson(Map<String, dynamic> json) 
    {
      return
        ProfileVerification(
            uID: json["uID"],
            isVerified: json["isVerified"],
            isProfileComplete: json["isProfileComplete"],
            isSelfieVerified: json["isSelfieVerified"],
            isInterest: json["isInterest"],
            isLocation: json["isLocation"],
            email: json["email"],
            phoneNumber: json["phoneNumber"],
            authToken: AuthToken.fromJson(json["authToken"])
        );
    }

    Map<String, dynamic> toJson() => {
        "uID": uID,
        "isVerified": isVerified,
        "isProfileComplete": isProfileComplete,
        "isSelfieVerified": isSelfieVerified,
        "isInterest": isInterest,
        "isLocation": isLocation,
        "email": email,
        "phoneNumber": phoneNumber,
        "authToken": authToken
    };

    getAccessToken(){
      return authToken!.access!.token;
    }

}
