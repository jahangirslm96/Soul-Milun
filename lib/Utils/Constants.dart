import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Routes.dart';

import 'Controller/model/PackageDetails.model.dart';
import 'ThemeColors.dart';

//Paddings
var mainBodyPadding = EdgeInsets.symmetric(
    horizontal: Get.width * 0.06, vertical: Get.height * 0.02);
var onBoardingPadding = EdgeInsets.symmetric(
    horizontal: Get.width * 0.06, vertical: Get.height * 0.04);
var mainBodyPadding4 = EdgeInsets.symmetric(horizontal: Get.width * 0.06);
var mainBodyPadding3 = EdgeInsets.symmetric(
    horizontal: Get.width * 0.02, vertical: Get.height * 0.02);
var mainBodyPadding2 = EdgeInsets.symmetric(
  horizontal: Get.width * 0.04,
);
var headerPadding = EdgeInsets.only(
  top: Get.height * 0.02,
);
var tab1Padding = EdgeInsets.only(
    right: Get.width * 0.06, left: Get.width * 0.06, bottom: Get.height * 0.05);
var tab2Padding = EdgeInsets.only(
    right: Get.width * 0.06,
    left: Get.width * 0.06,
    bottom: Get.height * 0.05,
    top: Get.height * 0.03);
var tab3Padding = EdgeInsets.only(
    right: Get.width * 0.06,
    left: Get.width * 0.06,
    bottom: Get.height * 0.05,
    top: Get.height * 0.040);

var subscriptionBodyPadding = EdgeInsets.symmetric(
    horizontal: Get.width * 0.04, vertical: Get.height * 0.017);
var homeScreenHeaderPadding = EdgeInsets.only(
    left: Get.height * 0.05, right: Get.width * 0.04, top: Get.height * 0.04);
var exploreScreenHeaderPadding = EdgeInsets.only(
    left: Get.height * 0.04, right: Get.width * 0.04, top: Get.height * 0.04);
var chatScreenHeaderPadding = EdgeInsets.only(
    left: Get.height * 0.04, right: Get.width * 0.04, top: Get.height * 0.02);

//Bottom nav selected item
int selectedIndex = 0;

//Shadow for Containers
var shadowConstant = const [
  BoxShadow(
    color: Colors.grey,
    offset: Offset(
      0.10,
      0.10,
    ),
    blurRadius: 0.10,
    spreadRadius: 0.10,
  ), //BoxShadow
  BoxShadow(
    color: Colors.white,
    offset: Offset(0.0, 0.0),
    blurRadius: 0.0,
    spreadRadius: 0.0,
  ), //BoxShadow
];

//DropDowns
final List<String> maritalStatusItems = [
  'Never Married',
  'Married',
  'Divorced',
  'Widow',
];
String nationality2 = "";
String city2 = "";
String religion2 = "";

String location = "";
String responseTime = "";
String minServiceTime = "";

String heightInRange = "";
String age = "";

String jobStatus = "";

String marriagePlans = "";

List<String> jobStatusItems = [
  'Currently Employed',
  'Not Employed',
  'Self-Employed',
  'Freelancing',
];

String industry = "";

List<String> industryItems = [
  'Information Technology (IT)',
  'Healthcare',
  'Education',
  'Finance and Banking',
  'Automotive',
  'Telecommunications',
  'Real Estate',
  'Pharmaceuticals',
  'Insurance',
];

String expectedSalary = "";

List<String> expectedSalaryItems = [
  '25,000 PKR - 50,000 PKR',
  '50,000 PKR - 75,000 PKR',
  '75,000 PKR - 100,000 PKR',
  '100,000 PKR - 125,000 PKR',
];

List<String> nationalityItems = [
  'Pakistani',
  'American',
  'Turkish',
  'British',
];
List<String> nationality2Items = [
  'Pakistani',
  'American',
  'Turkish',
  'British',
];

List<String> cityItems = [
  'Karachi',
  'Lahore',
  'Islamabad',
  'Peshawar',
];
List<String> city2Items = [
  'Karachi',
  'Lahore',
  'Islamabad',
  'Peshawar',
];

List<String> religionItems = [
  'Muslim',
  'Christian',
  'Hindu',
  'Atheist',
  'Jew',
  'Others',
];
List<String> religion2Items = [
  'Muslim',
  'Christian',
  'Hindu',
  'Atheist',
  'Jew',
  'Others',
];

List<String> professionItems = [
  'Engineer',
  'Architect',
  'Dentist',
  'Accountant',
  'Student',
];

List<String> locationItems = [
  'Karachi',
  'Lahore',
  'Islamabad',
  'Peshawar',
];

List<String> responseTimeItems = [
  '1 - 2 Hours',
  '2 - 4 Hours',
  '4 - 6 Hours',
  '6 - 8 Hours',
  '8 - 10 Hours',
  '10 - 12 Hours',
];
List<String> minServiceTimeItems = [
  '1 Hour',
  '2 Hours',
  '3 Hours',
  '4 Hours',
  '5 Hours',
  '6 Hours',
];
List<String> heightInRangeItems = [
  "5'0 - 5'3",
  "5'3 - 5'6",
  "5'6 - 5'9",
];

List<Map<String, double>> heightInRangeElement = [
  {"min": 5.0, "max": 5.3},
  {"min": 5.3, "max": 5.6},
  {"min": 5.6, "max": 5.9},
  {"min": 5.9, "max": 6.2},
  {"min": 6.2, "max": 6.5},
];

Map<String, dynamic> selectedHeightInRange = {"min": 0.0, "max": 0.0};

List<String> ageItems = [
  "18 - 20",
  "20 - 22",
  "22 - 24",
  "24 - 26",
  "26 - 28",
  "28 - 30",
  "30 +"
];

List<String> marriagePlansItems = [
  "Within 1 year",
  "Within 2 years",
  "Within 4 years",
  "Any timeframe",
];

List<Map<String, dynamic>> marriagePlansElements = [
  {"duration": "Within 1 year", "value": 1},
  {"duration": "Within 2 years", "value": 2},
  {"duration": "Within 4 years", "value": 4},
  {"duration": "Any timeframe", "value": 0},
];

String profileFilters = "";
List<String> profileFiltersItems = [
  'Preferred',
  'Similar',
  'NearBy',
];

//Policy Content placed in Array.
// final List<String> policy = [

// ];

//Data For Discount Screen ListView
final List<String> discountTypes = [
  'Restaurants',
  'Fashion & Clothing',
  'Fitness',
  'Furniture',
  'Cosmetics',
];
final List<String> imageArray = [
  'assets/images/DiscountImage/restaurant_image2x.png',
  'assets/images/DiscountImage/fashion_image2x.png',
  'assets/images/DiscountImage/fitness_image2x.png',
  'assets/images/DiscountImage/furniture_image2x.png',
  'assets/images/DiscountImage/cosmetics_image2x.png',
];
//Routes for each Discount Box in the ListView
final List<String> screens = [
  '/welcome',
  '/homeScreen',
  '/subscription',
  '/subscriptionPayment',
  '/congratulations',
];

//Data For Restaurant Screen GridView
final List<String> restaurantTypes = [
  'Pizza Hut',
  'KFC',
  'KBC',
  'Kaybees',
  'Chaupal',
  'Lal Qila',
];
final List<String> restaurantImageArray = [
  'assets/images/RestaurantImage/food_pic1.png',
  'assets/images/RestaurantImage/food_pic2.png',
  'assets/images/RestaurantImage/food_pic3.png',
  'assets/images/RestaurantImage/food_pic4.png',
  'assets/images/RestaurantImage/food_pic5.png',
  'assets/images/RestaurantImage/food_pic6.png',
];

final List<String> aboutMe = [
  'Single',
  'Adventurer',
  'Traveler',
  'Foodie',
];
final List<String> interests = [
  'Single',
  'Reading',
  'Graduation Completed',
  'At least 5"2',
];
final List<String> religionDetails = ['Islam', 'Moderate', 'Sunni'];
final List<String> education = [
  'O Levels',
  'BSCS',
  '3.5 CGPA',
  'Gold Medalist',
];
final List<String> goals = [
  'Travel to a New Country',
  'Healthy Diet',
  'Develop a Meditation Practice',
];

final List<String> matchMyProfileInterests = [
  'Netflix',
  'Travel',
  'Cricket',
  'Soccer',
  'Reading books',
  'Hiking or camping',
  'Coffee',
  'Gardening',
  'Dancing',
  'Photography',
  'Writing',
  'Painting',
  'Fashion and styling',
  'Listening to music'
];

//Data For Chat Screen

final List<String> chatArray = [
  'assets/images/chat_pic1.png',
  'assets/images/chat_pic2.png',
  'assets/images/chat_pic3.png',
  'assets/images/chat_pic4.png',
  'assets/images/chat_pic1.png',
  'assets/images/chat_pic2.png',
  'assets/images/chat_pic3.png',
  'assets/images/chat_pic4.png',
  'assets/images/chat_pic1.png',
  'assets/images/chat_pic2.png',
  'assets/images/chat_pic3.png',
  'assets/images/chat_pic4.png',
];

final List<String> chatNameArray = [
  'Fahad Khan',
  'Rida Zehra',
  'Ayesha Khan',
  'Hoor Fatima',
  'Fahad Khan',
  'Rida Zehra',
  'Ayesha Khan',
  'Hoor Fatima',
  'Fahad Khan',
  'Rida Zehra',
  'Ayesha Khan',
  'Hoor Fatima',
];

// for invite friends option
const String text = "Come, Join Soul Milun!";
const String url = "https://example.com";

//Arrays for interest Screen
final List<String> interestArtsCulture = [
  'Acting',
  'Art galleries',
  'Board games',
  'Creative writing',
  'Design',
  'BIY',
  'Fashion',
  'Knitting',
  'Learning languages',
  'Live music ',
  'Museums',
  'Painting',
  'Photography',
  'Playing Music',
  'Pottery',
  'Sewing',
  'Reading',
  'Stand up comedy',
  'Theater',
  'Travel',
  'Tv Shows'
];
final List<String> interestCommunity = [
  "Politics",
  "Activism",
  "Family time",
  "Volunteering",
  "Spend time with friends"
];
final List<String> interestFoodDrinks = [
  "Baking",
  "Bubble tea",
  "Cake decorating",
  "Cooking",
  "Chocolate",
  "Coffee",
  "Eating out",
  "Fish and chips",
  "Healthy eating",
  "Junk food",
  "Meat lover",
  "Pescatarian",
  "Pizza",
  "Sushi",
  "Vegan",
  "Vegetarian"
];
final List<String> interestIslamic = [
  "Arabian",
  "Ashura",
  "Fasting",
  "Health",
  "Charity",
  "Completed Hajj",
  "Khatam",
  "Completed Umrah",
  "Dua for others",
  "Mawlid",
  "Muharram",
  "Islamic events",
  "Islamic Lectures",
  "Islamic Studies",
  "Learning Arabic",
  "Masjid Regularly",
  "Reading Quran",
  "Voluntary prayers"
];
final List<String> interestOutdoors = [
  "Bird Watching",
  "Hiking",
  "Gardening",
  "Nature Walk"
];
final List<String> interestSports = [
  "Football",
  "Badminton",
  "Base ball",
  "Basketball",
  "Boxing",
  "Cricket",
  "Cycling",
  "Dancing",
  "Golf",
  "Gym",
  "Hockey",
  "Running",
  "Rugby",
  "Swimming",
  "Tennis",
  "Yoga",
];
final List<String> interestTechnology = [
  "Animation",
  "Blogging",
  "Coding",
  "Content creation",
  "Digital art",
  "Influencer",
  "Video Games"
];
final List<String> interestPersonality = [
  "Active listener",
  "Adventurous",
  "Affectionate",
  "Ambitious",
  "Assertive",
  "Brunch lover",
  "Charismatic",
  "Cheerful",
  "Competitive",
  "Confident",
  "Creative",
  "Empathetic",
  "ENFJ",
  "ENFP",
  "ENTJ",
  "ENTP" "INFJ",
  "INTJ",
  "INFP",
  "INTP",
  "ISTJ",
  "ISTP" "Entrepreneurial",
  "Extroverted",
  "Family oriented",
  "Fashionable",
  "Funny",
  "Generous",
  "Good with kids",
  "Intelligent",
  "Liberal ",
  "Nerdy",
  "Open – minded",
  "Positive",
  "Respectful",
  "Romantic",
  "Self- aware",
  "Shopaholic",
  "Spontaneous",
  "Thoughtful"
];

List<Map<String, dynamic>> profileSettingsRows = [
  {
    "title": 'Edit Profile',
    "icon": Icons.edit,
    "route": RoutesClass.editProfileScreen
  },
  {"title": 'Preffered Form', "icon": Icons.lock, "method": 4},
  {
    "title": 'Help Center',
    "icon": Icons.help_outline_outlined,
    "route": RoutesClass.helpCenterScreen,
  },
  {"title": 'Become Income Generator', "icon": Icons.lock, "method": 3},
  {"title": 'Invite Friends', "icon": Icons.share, "method": 1},
  {"title": 'Log Out', "icon": Icons.logout_outlined, "method": 2},
];

List<String> familyPlansItems = [
  'Wants children',
  'Open to having children',
  "Doesn't want children"
];
List<String> selectedFamilyPlans = [];

List<String> relocationItems = [
  'Open to relocation',
  'Not open to relocation',
];
List<String> selectedRelocation = [];

List<String> selectedMarriagePlans = [];

List<String> religiousPracticeItems = [
  'Very practising',
  'Practising',
  'Moderately practising',
  'Not practising'
];
List<String> selectedReligiousPractice = [];

List<String> prayingItems = [
  'Always pray',
  'Usually prays',
  'Sometimes prays',
  'Never prays'
];
List<String> selectedPraying = [];

List<String> islamicDressItems = [
  'Modest',
  'Hijab',
  'Jilbab',
  'Niqab',
  'No religious dress'
];
List<String> selectedIslamicDress = [];

List<String> educationItems = [
  'High School',
  'Non-degree qualification',
  'Undergraduate degree',
  'Postgraduate degree',
  'Doctorate',
  'Other education level'
];
List<String> selectedEducation = [];

Map<String, dynamic> preferenceInfo = {};

final List<String> subscriptionDetails = [
  'Pick your preferences',
  'Unlimited Profiles',
  'Free Daily Instant Chat',
  'Weekly 10 Chats',
  'Oops, I Changed my mind',
  'No Blurred Photos',
  'VIP Badge',
  'Travel & Earn',
  'Boost your Career',
  'Exclusive Discounts and Coupons',
];

final List<int> durationSubscriptionCard = [
  700,
  900,
  1100,
];

List<Color> tappedColors = List.filled(3, ThemeColors().buttonColorOnTap);


