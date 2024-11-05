import 'package:get/get.dart';
import 'package:soul_milan/Screens/IncomeGenerator/IncomeGenerator.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import 'package:soul_milan/Utils/Controller/model/Cities.model.dart';
import 'package:soul_milan/Utils/Controller/model/chat.model.dart';
import 'package:soul_milan/Utils/Controller/model/customMessege.model.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';
import 'package:soul_milan/Utils/Controller/model/mainFilter.model.dart';
import 'package:soul_milan/Utils/Controller/model/preferred.model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'model/EarnerProfile.model.dart';
import 'model/PackageDetails.model.dart';
import 'model/ProfileModel/ProfileOverview.model.dart';
import 'model/SubscriptionPackages.model.dart';
import 'model/TourPartners.model.dart';
import 'model/TourerInfo.model.dart';
import 'model/customChatHead.model.dart';
import 'model/customMessenger.model.dart';

const apiLink = "http://132.147.160.2:5000/";
// const apiLink = "http://132.147.140.112:5000/";
const fileUrl = "${apiLink}upload/images/";
const assestUrl = "${apiLink}upload/assets/";

const defaultImage = "assets/images/partner_profile_pic1.png";

const getprofile = "profile/";
const login = "auth/login/";
const register = "auth/register/";
const getOtp = "verify/otp/";
const verifyOtp = "verify";

const updatePassword = "verify/updatePassword/";

const getPolicyDetails = "basic/policy/";

const getdropDown = "basic/infoDropDown";

const uploadInfo = "profile/";

const updateLocation = "update/location";

const selfieVerify = "/Selfie";

const interest = "basic/interest";

const postInterest = "profile/interest/";
const career = "career";

const match = "match/";

const prefer = "prefer/";

const package = "package";

const intereaction = "profile/interact/";

class apiRoute {
  final apiLink = "http://132.147.160.2:5000/";
  // final apiLink = "http://132.147.140.112:5000/";

  late final fileUrl = "${apiLink}upload/images/";
  late final assestUrl = "${apiLink}upload/assets/";

  final getprofile = "profile/";
  final login = "auth/login/";
  final register = "auth/register/";
  final getOtp = "verify/otp/";
  final verifyOtp = "verify";
  final updatePassword = "verify/updatePassword/";
  final getPolicyDetails = "basic/policy/";
  final getdropDown = "basic/infoDropDown/";
  final uploadInfo = "profile/";
  final updateLocation = "update/location";
  final selfieVerify = "/Selfie";
  final interest = "basic/interest";
  final postInterest = "profile/interest/";
  final career = "career";
  final match = "match/";
  final intereaction = "profile/interact/";
  final bookTour = "tour/";
  // Chat Screen
  final chat = "chat/";

  //show packages
  final getPackageList = "basic/packages";
  final package = "package/";

  // income Generate
  final income = "income/";
  late final incomeGenerator = "${income}generator/";

  // soul earner
  final earner = "earner/";

  apiRoute() {}
}

late IO.Socket channel;

late Connector connector;

late Profiles userProfile;
late Profiles previewProfile;

//main filter
late MainFilter mainFilter;
//

late Cities cities;

late PreferredFilter preferredFilter;

//discard
late ChatModel chatPreview;
List<dynamic> chatList = [];
//discard

bool isLogout = false;

//chat implementation - start
late CustomMessenger customMessenger;
late CustomChatHead currentChat;
//chat implementation - end

//Package Details - start
late PackageDetails packageDetails;
late SubscriptionPackages subscriptionPackages;
late Package selectedPackage;
PackageType currentPackageType = PackageType.NONE;
//Package Details - end

//New Instant Chat Popup
bool isNewInstantChat = false;
//end

//Profile overview - start
late ProfileOverview profileOverView;
//Profile overview - end

//Earner profile - start
late EarnerProfile earnerProfile;
//Earner profile - end

//Firebase push notification FCM
late String userFCMToken = "";
late bool IsFCMLoaded = false;
//Firebase end

//Tourer Timeline
late TourPartners tourPartners;
late TourProfile currentTourProfile; //for showing specific tour profile in detail
late String tourCode = "";
//Tourer Timeline - end

late String channelID;

late Map<String, List<Profiles>> user;
late List<dynamic> interact;

class initStaticVariable {
  initialization() {
    channelID = "";
    user = {
      "Preferred": [],
      "Similar": [],
      "NearBy": [],
    };
  }
}
