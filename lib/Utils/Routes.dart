import 'package:get/get.dart';
import 'package:soul_milan/Screens/AddCard/AddCardScreen.dart';
import 'package:soul_milan/Screens/Authentication/ForgetPassword/ForgetPasswordScreen.dart';
import 'package:soul_milan/Screens/Authentication/ForgetPassword/ForgetPasswordScreenOTP.dart';
import 'package:soul_milan/Screens/Authentication/NewPassword/NewPasswordScreen.dart';
import 'package:soul_milan/Screens/Authentication/SaveAccount/SaveAccountScreen.dart';
import 'package:soul_milan/Screens/Authentication/SelfieCheck/SelfieCameraScreen.dart';
import 'package:soul_milan/Screens/Authentication/SelfieCheck/SelfieCheckScreen1.dart';
import 'package:soul_milan/Screens/Authentication/SignUp/SignUpScreen.dart';
import 'package:soul_milan/Screens/Authentication/Verification/VerificationScreen1.dart';
import 'package:soul_milan/Screens/Authentication/Verification/VerificationScreen2OTP.dart';
import 'package:soul_milan/Screens/Authentication/Welcome/WelcomeScreen.dart';
import 'package:soul_milan/Screens/Call/VideoCall/VideoCallScreen.dart';
import 'package:soul_milan/Screens/Call/VoiceCall/VoiceCallScreen.dart';
import 'package:soul_milan/Screens/Chat/ChatScreen1.dart';
import 'package:soul_milan/Screens/Chat/ChatDetailsScreen.dart';
import 'package:soul_milan/Screens/Congratulations/CongratulationsScreen.dart';
import 'package:soul_milan/Screens/Discount/DiscountScreen.dart';
import 'package:soul_milan/Screens/Discount/Restaurants/RestaurantsScreen.dart';
import 'package:soul_milan/Screens/EditProfile/EditProfileScreen.dart';
import 'package:soul_milan/Screens/EnableLocation/EnableLocation.dart';
import 'package:soul_milan/Screens/HelpCenter/HelpCenterScreen.dart';
import 'package:soul_milan/Screens/Home/HomeScreen.dart';
import 'package:soul_milan/Screens/IncomeGenerator/IncomeGenerator.dart';
import 'package:soul_milan/Screens/Interests/InterestsScreen.dart';
import 'package:soul_milan/Screens/Maintenance/MaintenanceScreen.dart';
import 'package:soul_milan/Screens/MatchPerfectSoul/MatchPerfectSoulScreen.dart';
import 'package:soul_milan/Screens/MembersProfile/MembersProfileScreen.dart';
import 'package:soul_milan/Screens/MyProfile/MyProfileScreen.dart';
import 'package:soul_milan/Screens/OnBoarding/OnBoardingScreen.dart';
import 'package:soul_milan/Screens/Personalization/PublicInfoScreen.dart';
import 'package:soul_milan/Screens/Policy/PolicyScreen.dart';
import 'package:soul_milan/Screens/PreferredForm/PreferredFormScreen.dart';
import 'package:soul_milan/Screens/Profile/ProfileCompleteScreen.dart';
import 'package:soul_milan/Screens/Profile/ProfileSettingsScreen.dart';
import 'package:soul_milan/Screens/Report/ReportScreen.dart';
import 'package:soul_milan/Screens/Splash/SplashScreen.dart';
import 'package:soul_milan/Screens/Subscriptions/SubscriptionScreen1.dart';
import 'package:soul_milan/Screens/Subscriptions/SubscriptionScreen2Payment.dart';
import 'package:soul_milan/Screens/VerifiedSouls/VerifiedSoulsProfile.dart';
import 'package:soul_milan/Screens/VerifiedSouls/VerifiedSoulsScreen.dart';
import '../Screens/Authentication/AccountLogin/AccountLoginScreen2.dart';
import '../Screens/Authentication/Login/LoginScreen.dart';
import '../Screens/Chat/ChatHeadScreen.dart';
import '../Screens/Chat/ChatRequestScreen.dart';
import '../Screens/Chat/CustomChattingScreen.dart';
import '../Screens/Explore/ExploreScreen.dart';
import '../Screens/InternetConnection/InternetConnectionScreen.dart';
import '../Screens/SoulProfile/SoulProfileScreen.dart';

class RoutesClass {
  static String splash = "/";
  static String welcomePage = "/welcome";
  static String logInPage = "/logIn";
  static String signupPage = "/signup";
  static String newPasswordScreen = "/newPassword";
  static String forgetPasswordScreen = "/forgetPassword";
  static String forgetPassScreenOTP = "/forgetPasswordOTP";
  static String verificationScreen = "/verification";
  static String verificationScreenOTP = "/verificationOTP";
  static String accountLoginScreen2 = "/accountLogin";
  static String saveAccountScreen = "/saveAccount";
  static String publicInfoScreen = "/publicInfo";
  static String policyScreen = "/policy";
  static String subscriptionScreen = "/subscription";
  static String subscriptionScreen2Payment = "/subscriptionPayment";
  static String addCardScreen = "/addCard";
  static String congratsScreen = "/congratulations";
  static String selfieCheckScreen = "/selfieCheck";
  static String homeScreen = "/homeScreen";
  static String completeProfile = "/completeProfile";
  static String profileSettingsScreen = "/profileSettings";
  static String discountsScreen = "/discounts";
  static String membersProfileScreen = "/membersProfile";
  static String helpCenterScreen = "/helpCenter";
  static String restaurantsScreen = "/restaurants";
  static String soulProfileScreen = "/soulProfile";
  static String verifiedSoulsScreen = "/verifiedSouls";
  static String reportProfileScreen = "/reportProfile";
  static String exploreScreen = "/explore";
  static String chatScreen = "/chat";
  static String chatScreen2 = "/chat2";
  static String enableLocationScreen = "/enableLocation";
  static String chatRequestScreen = "/chatRequest";
  static String noInternetScreen = "/noInternet";
  static String incomeGeneratorScreen = "/incomeGenerator";
  static String matchMyPerfectSoulScreen = "/matchMyPerfectSoul";
  static String selfieCamera = "/selfieCamera";
  static String interestScreen = "/interest";
  static String onBoardingScreen = "/onBoarding";
  static String voiceCallScreen = "/voiceCall";
  static String videoCallScreen = "/videoCall";
  static String maintenanceScreen = "/maintenance";
  static String preferredFormScreen = "/preferredForm";
  static String editProfileScreen = "/editProfile";
  static String verifiedSoulsProfileScreen = "/verifiedSoulsProfile";
  static String myProfileScreen = "/myProfile";

  //re-working on chat screen - start
  static String chatHeadScreen = "/chatHead";
  static String getChatHead() => chatHeadScreen;

  static String chattingScreen = "/chattingScreen";
  static String getChatingScreen() => chattingScreen;
  //re-working on chat screen - end

  static String getSplash() => splash;
  static String getWelcomeRoute() => welcomePage;
  static String getLoginInRoute() => logInPage;
  static String getSignUpRoute() => signupPage;
  static String getNewPasswordRoute() => newPasswordScreen;
  static String getForgetPasswordRoute() => forgetPasswordScreen;
  static String getForgetPasswordOTPRoute() => forgetPassScreenOTP;
  static String getVerificationRoute() => verificationScreen;
  static String getVerificationOTPRoute() => verificationScreenOTP;
  static String getAccountLogin2Route() => accountLoginScreen2;
  static String getSaveAccountRoute() => saveAccountScreen;
  static String getPublicInfoRoute() => publicInfoScreen;
  static String getPolicyRoute() => policyScreen;
  static String getSubscriptionRoute() => subscriptionScreen;
  static String getSubscriptionPaymentRoute() => subscriptionScreen2Payment;
  static String getAddCardRoute() => addCardScreen;
  static String getCongratulationsRoute() => congratsScreen;
  static String getSelfieCheckRoute() => selfieCheckScreen;
  static String getHomeScreenRoute() => homeScreen;
  static String getCompleteProfileRoute() => completeProfile;
  static String getProfileSettingsRoute() => profileSettingsScreen;
  static String getDiscountsRoute() => discountsScreen;
  static String getMembersProfileRoute() => membersProfileScreen;
  static String getHelpCenterRoute() => helpCenterScreen;
  static String getRestaurantsRoute() => restaurantsScreen;
  static String getSoulProfileRoute() => soulProfileScreen;
  static String getVerifiedSoulsRoute() => verifiedSoulsScreen;
  static String getReportProfileRoute() => reportProfileScreen;
  static String getExploreRoute() => exploreScreen;
  static String getChatRoute() => chatScreen;
  static String getChat2Route() => chatScreen2;
  static String getEnableLocationRoute() => enableLocationScreen;
  static String getChatRequestRoute() => chatRequestScreen;
  static String getNoInternetRoute() => noInternetScreen;
  static String getIncomeGeneratorRoute() => incomeGeneratorScreen;
  static String getMatchMyPerfectSoulRoute() => matchMyPerfectSoulScreen;
  static String getSelfieCameraRoute() => selfieCamera;
  static String getInterestRoute() => interestScreen;
  static String getOnBoardingRoute() => onBoardingScreen;
  static String getVoiceCallRoute() => voiceCallScreen;
  static String getVideoCallRoute() => videoCallScreen;
  static String getMaintenanceRoute() => maintenanceScreen;
  static String getPreferredFormRoute() => preferredFormScreen;
  static String getEditProfileRoute() => editProfileScreen;
  static String getVerifiedSoulsProfileRoute() => verifiedSoulsProfileScreen;
  static String getMyProfileRoute() => myProfileScreen;

  static List<GetPage> routes = [
    GetPage(page: () => const SplashScreen(), name: splash),
    GetPage(
        page: () => const WelcomeScreen(),
        name: welcomePage,
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 400)),
    GetPage(
      page: () => const SignUpScreen(),
      name: signupPage, /*transition: Transition.rightToLeft*/
    ),
    GetPage(
      page: () => const LoginScreen(),
      name: logInPage, /*transition: Transition.rightToLeft*/
    ),
    GetPage(
      page: () => const ForgetPasswordScreen(),
      name: forgetPasswordScreen, /*transition: Transition.rightToLeft*/
    ),
    GetPage(
        page: () => const ForgetPasswordScreenOTP(),
        name: forgetPassScreenOTP,
        transition: Transition.rightToLeft),
    GetPage(
        page: () => const VerificationScreen(),
        name: verificationScreen,
        transition: Transition.rightToLeft),
    GetPage(
        page: () => const VerificationScreenOTP(),
        name: verificationScreenOTP,
        transition: Transition.rightToLeft),
    GetPage(
        page: () => const NewPasswordScreen(),
        name: newPasswordScreen,
        transition: Transition.rightToLeft),
    GetPage(
        page: () => const AccountLoginScreen2(),
        name: accountLoginScreen2,
        transition: Transition.rightToLeft),
    GetPage(
      page: () => const SaveAccountScreen(),
      name: saveAccountScreen, /*transition: Transition.rightToLeft*/
    ),
    GetPage(
      page: () => const PublicInfoScreen(),
      name: publicInfoScreen, /*transition: Transition.rightToLeft*/
    ),
    GetPage(
      page: () => const PolicyScreen(),
      name: policyScreen, /*transition: Transition.rightToLeft*/
    ),
    GetPage(
      page: () => const SubscriptionScreen(),
      name: subscriptionScreen,
      transition: Transition.noTransition/*transition: Transition.rightToLeft*/
    ),
    GetPage(
      page: () => const SubscriptionScreen2Payment(),
      name: subscriptionScreen2Payment, /*transition: Transition.rightToLeft*/
    ),
    GetPage(
      page: () => const AddCardScreen(),
      name: addCardScreen, /*transition: Transition.rightToLeft*/
    ),
    GetPage(
      page: () => const CongratulationsScreen(),
      name: congratsScreen, /*transition: Transition.rightToLeft*/
    ),
    GetPage(
        page: () => const SelfieCheckScreen1(),
        name: selfieCheckScreen,
        transition: Transition.rightToLeft),
    GetPage(
        page: () => const HomeScreen(),
        name: homeScreen,
        transition: Transition.noTransition),
    GetPage(
        page: () => const ProfileCompleteScreen(),
        name: completeProfile,
        transition: Transition.noTransition),
    GetPage(
        page: () => const ProfileSettingsScreen(),
        name: profileSettingsScreen,
        transition: Transition.noTransition),
    GetPage(
        page: () => const DiscountScreen(),
        name: discountsScreen,
        transition: Transition.noTransition),
    GetPage(
        page: () => const MembersProfileScreen(),
        name: membersProfileScreen,
        transition: Transition.noTransition),
    GetPage(
      page: () => const HelpCenterScreen(),
      name: helpCenterScreen, /*transition: Transition.rightToLeft*/
    ),
    GetPage(
      page: () => const RestaurantsScreen(),
      name: restaurantsScreen, /*transition: Transition.rightToLeft*/
    ),
    GetPage(
        page: () => const SoulProfileScreen(),
        name: soulProfileScreen,
        transition: Transition.noTransition),
    GetPage(
        page: () => const VerifiedSoulsScreen(),
        name: verifiedSoulsScreen,
        transition: Transition.downToUp),
    GetPage(
        page: () => const ReportScreen(),
        name: reportProfileScreen,
        transition: Transition.downToUp),
    GetPage(
        page: () => const ExploreScreen(),
        name: exploreScreen,
        transition: Transition.noTransition),
    GetPage(
        page: () => const ChatScreen1(),
        name: chatScreen,
        transition: Transition.noTransition),
    GetPage(
        page: () => const EnableLocation(),
        name: enableLocationScreen,
        transition: Transition.noTransition),
    GetPage(
        page: () => const ChatRequestScreen(),
        name: chatRequestScreen,
        transition: Transition.noTransition),
    GetPage(
        page: () => const ChatScreen2(),
        name: chatScreen2,
        transition: Transition.noTransition),
    GetPage(
        page: () => const InternetConnectionScreen(),
        name: noInternetScreen,
        transition: Transition.noTransition),
    GetPage(
      page: () => const IncomeGenerator(),
      name: incomeGeneratorScreen,
      //*transition: Transition.noTransition*//*
    ),
    GetPage(
      page: () => const MatchPerfectSoulScreen(),
      name: matchMyPerfectSoulScreen,
        transition: Transition.noTransition
    ),
    GetPage(
      page: () => const SelfieCameraScreen(),
      name: selfieCamera,
      /*transition: Transition.noTransition*/
    ),
    GetPage(
      page: () => const InterestsScreen(),
      name: interestScreen,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      page: () => const OnBoardingScreen(),
      name: onBoardingScreen,
      /*transition: Transition.rightToLeft,*/
    ),
    GetPage(
      page: () => const VoiceCallScreen(),
      name: voiceCallScreen,
      /*transition: Transition.rightToLeft,*/
    ),
    GetPage(
      page: () => const VideoCallScreen(),
      name: videoCallScreen,
      /*transition: Transition.rightToLeft,*/
    ),
    GetPage(
      page: () => const MaintenanceScreen(),
      name: maintenanceScreen,
      /*transition: Transition.rightToLeft,*/
    ),
    GetPage(
      page: () => const PreferredFormScreen(),
      name: preferredFormScreen,
      /*transition: Transition.rightToLeft,*/
    ),
    GetPage(
      page: () => const EditProfileScreen(),
      name: editProfileScreen,
        transition: Transition.noTransition
    ),
    GetPage(
      page: () => const ChatHeadScreen(),
      name: chatHeadScreen,
        transition: Transition.noTransition
    ),
    GetPage(
      page: () => const CustomChattingScreen(),
      name: chattingScreen,
      /*transition: Transition.rightToLeft,*/
    ),
    GetPage(
      page: () => const VerifiedSoulsProfile(),
      name: verifiedSoulsProfileScreen,
        transition: Transition.noTransition
    ),
    GetPage(
      page: () => const MyProfileScreen(),
      name: myProfileScreen,
      transition: Transition.noTransition,
    ),
  ];
}
