import 'dart:convert';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Controller/model/ProfileModel/ProfileOverview.model.dart';

import '../../Components/Buttons/CustomButton.dart';
import '../../Components/Card/uploadedImage.dart';
import '../../Components/DateTimePicker/CustomDateTimePicker.dart';
import '../../Components/DropDowns/CustomDropDown1.dart';
import '../../Components/DropDowns/HeightDropdown.dart';
import '../../Components/Headers/CustomHeader.dart';
import '../../Components/Headers/HeaderWithBackIcon.dart';
import '../../Components/InterestSelection/CustomInterestSelection.dart';
import '../../Components/MultipleSelectionButtons/MultipleCheckBox.dart';
import '../../Components/RadioButtons/CustomRadioButtons.dart';
import '../../Components/Textfields/CustomTextfield3.dart';
import '../../Utils/Constants.dart';
import '../../Utils/Controller/constant.dart';
import '../../Utils/CustomTheme.dart';
import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';
import '../../view_model/SoulProfile_ViewModel.dart';
import '../../view_model/SoulProfilesTimeline_ViewModel.dart';
import '../../view_model/SubscriptionPackage_ViewModel.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  List<Map<String, dynamic>> image = [];
  bool isLoading1 = false;
  bool isLoading2 = false;
  bool isLoading3 = false;
  bool isLoading4 = false;
  bool isLoading5 = false;

  bool isLoader = false;
  int gender = 0;
  String profession = "";
  String religion = "";

  int multipleMarriageOR2ndWife = 0;

  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;

  final List<String> selectedInterestsArray = [];
  late List<dynamic> response;
  int selectedCount = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController dobController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController feetController = TextEditingController();
  TextEditingController inchesController = TextEditingController();
  List<TextEditingController> controller = [];

  Map<String, Map<String, dynamic>> dropDown = {};
  bool isDropDown = false;
  List<dynamic> profileImageList = [];
  @override
  void initState() {
    feetController.text = '5';
    inchesController.text = '2';
    response = [];
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
    _getData(soulProfile_ViewModel);
    _load(soulProfile_ViewModel);
    super.initState();
  }

  _load(SoulProfile_ViewModel soulProfile_ViewModel) async {

    ProfileOverview profileOverview = soulProfile_ViewModel.profileOverview!;
    var response = await connector.get(getdropDown);

    if (response["success"]) {
      response["dropDowns"].forEach((key, value) {
        dropDown[key] = {
          "list": [],
          "id": [],
        };

        for (var item in value) {
          dropDown[key]?["list"].add(item["Name"]);
          dropDown[key]?["id"].add(item.values.first);
        }
      });

      var profileImages =
          await connector.get("$getprofile/images/${soulProfile_ViewModel.profileVerification!.uID}");
          print(profileImages);
      profileImageList = List<String>.from(profileImages['response']['Images']);
      dateController.text = profileImages["response"]["dob"] == "undefined"
          ? "2005-05-01"
          : profileImages["response"]["dob"];
      profileImageList.forEach((element) {
        image.add({"image": element, "isVerified": 1, "isUploaded": true});
      });

      double doubleValue = double.parse(profileOverview.profileData!.height!);

      int foot = doubleValue.truncate(); // Get the whole number part
      int inch = ((doubleValue - foot) * 10)
          .round(); // Convert fractional part to inches

      Map<String, int> heightMap = {
        'foot': foot,
        'inch': inch,
      };

      setState(() {
        religion = profileOverview.profileData!.religion == null
            ? dropDown["religionList"]!["list"][0]
            : dropDown["religionList"]!["list"][_indexOf(
                dropDown["religionList"]!["list"], profileOverview.profileData!.religion!)];
        profession = profileOverview.profileData!.profession == null
            ? dropDown["professionList"]!["list"][0]
            : dropDown["professionList"]!["list"][_indexOf(
                dropDown["professionList"]!["list"], profileOverview.profileData!.profession!)];
        profileOverview.profileData!.education = (profileOverview.profileData!.education!.isNotEmpty
            ? [
                educationItems[
                    _indexOf(educationItems, profileOverview.profileData!.education![0])]
              ]
            : [educationItems[0]]);


        nameController.text = profileOverview.profileData!.name!;
        feetController.text = heightMap['foot'].toString() ?? '5';
        inchesController.text = heightMap['inch'].toString() ?? '2';
        emailController.text = soulProfile_ViewModel.profileVerification!.email!;
        phoneNumberController.text = soulProfile_ViewModel.profileVerification!.phoneNumber!;

        feetController.text = profileOverview.profileData!.height!.split(".")[0];
        inchesController.text = profileOverview.profileData!.height!.split(".")[1];

        isDropDown = true;
      });
    } else {
      //print(response);
    }

    //userProfile.religion = dropDown["religionList"]!["list"][_indexOf(dropDown["religionList"]!["list"], userProfile.religion)];
    // print(dropDown["religionList"]!["list"]);
    //  print(userProfile.religion);
  }

  int _indexOf(List<dynamic> arrayToSearch, String element) {
    return arrayToSearch.indexOf(element);
  }

  void _getData(SoulProfile_ViewModel soulProfile_ViewModel) async {
    var temp = await connector.get(interest);
    if (temp != null && temp["success"] != null && temp["success"]) {
      var temp2 = await connector.get("$interest/${soulProfile_ViewModel.profileVerification!.uID}");
      if (temp2 != null && temp2["success"] != null && temp2["success"]) {
        List<dynamic> data = temp2["data"];

        for (var element in data) {
          selectedInterestsArray.add(element["tagID"]);
        }
      }

      setState(() {
        response = temp["data"];
        isLoader = true;
        selectedCount = selectedInterestsArray.length;
      });
    }
  }

  void ProfileSettingScreenRefresh() async {
    Get.toNamed(RoutesClass.profileSettingsScreen);
  }

  @override
  Widget build(BuildContext context) {
    // SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: AbsorbPointer(
                absorbing: isLoading1 || isLoading2 || isLoading3 || isLoading4 || isLoading5,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 12),
                      child: const Column(
                        children: [
                          CustomHeader(
                            name: "Edit Profile",
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: ThemeColors().containerOutlineColor,
                      thickness: Get.height *0.0005,
                    ),
                    Padding(
                      padding: mainBodyPadding2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.02),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              title: Text(
                                "Personal Info",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.04),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomTextfield3(
                                        controller: nameController,
                                        label: "Name",
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.02),
                                        child: CustomDatePicker(
                                          controller: dateController,
                                          label: "DD-MM-YYYY",
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: Get.height * 0.04),
                                        child: Theme(
                                          data: ThemeData(
                                            unselectedWidgetColor:
                                                ThemeColors().buttonColor,
                                          ),
                                          child: CustomRadioButtons(
                                              onTap: (value) => setState(() {
                                                    gender = value;
                                                  }),
                                              option: const ["Male", "Female"],
                                              selection: gender),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: Get.height * 0.02),
                                        child: Theme(
                                          data: ThemeData(
                                            unselectedWidgetColor:
                                                ThemeColors().buttonColor,
                                          ),
                                          child: CustomButton(
                                            name: 'Update',
                                            onClick: updatePersonalInfo,
                                            isLoading: isLoading1,
                                            color: ThemeColors().buttonColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Consumer<SoulProfile_ViewModel>(builder: (context, soulProfile_ViewModel, child) =>  Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.02),
                            child: _buildExpansionTile(soulProfile_ViewModel),
                          )),
                          Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.02),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              title: Text(
                                "Public Info",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.04),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height * 0.02),
                                        child: Text(
                                          "Height",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height * 0.02),
                                        child: HeightInput(
                                          controller1: feetController,
                                          controller2: inchesController,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height * 0.04),
                                        child: Text(
                                          "Religion",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height * 0.02),
                                        child: CustomDropDown1(
                                            product: religion,
                                            productItems: isDropDown
                                                ? dropDown["religionList"]![
                                                    "list"]
                                                : religionItems,
                                            onChanged: _religion,
                                            label: "Religion"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height * 0.04),
                                        child: Text(
                                          "Profession",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height * 0.02),
                                        child: CustomDropDown1(
                                          product: profession,
                                          productItems: isDropDown
                                              ? dropDown["professionList"]![
                                                  "list"]
                                              : professionItems,
                                          onChanged: _profession,
                                          label: "Profession",
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height * 0.04),
                                        child: Text(
                                          "Education",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ),
                                      Consumer<SoulProfile_ViewModel>(builder: (context, soulProfile_ViewModel, child) => 
                                        Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height * 0.01),
                                        child: MultipleCheckBox(
                                          arrayNameOptions: educationItems,
                                          selectionArray: soulProfile_ViewModel.profileOverview!.profileData!.education!,
                                          allowMultipleSelection: false,
                                        ),
                                      )
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height * 0.04),
                                        child: Text(
                                          "Willing to do multiple marriages",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: Get.height * 0.04),
                                        child: Theme(
                                          data: ThemeData(
                                            unselectedWidgetColor:
                                                ThemeColors().buttonColor,
                                          ),
                                          child: CustomRadioButtons(
                                              onTap: (value) => setState(() {
                                                    multipleMarriageOR2ndWife =
                                                        value;
                                                  }),
                                              option: const ["Yes", "No"],
                                              selection:
                                                  multipleMarriageOR2ndWife),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: Get.height * 0.02),
                                  child: Theme(
                                    data: ThemeData(
                                      unselectedWidgetColor:
                                          ThemeColors().buttonColor,
                                    ),
                                    child: Consumer<SoulProfile_ViewModel>(builder: (context, soulProfile_ViewModel, child) =>  CustomButton(
                                      name: 'Update',
                                      onClick: () => updatePublicInfo(soulProfile_ViewModel),
                                      isLoading: isLoading3,
                                      color: ThemeColors().buttonColor,
                                    )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.02),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              title: Text(
                                "Verified Info",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.04),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomTextfield3(
                                        controller: emailController,
                                        label: "Email",
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height * 0.02,
                                            bottom: Get.height * 0.04),
                                        child: TextFormField(
                                          cursorColor:
                                              ThemeColors().labelTextColor,
                                          maxLength: 10,
                                          controller: phoneNumberController,
                                          keyboardType: TextInputType.number,
                                          autovalidateMode:
                                              AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter Phone Number';
                                            }
                                            if (value.startsWith("0")) {
                                              return "Please remove 0 from the start";
                                            }
                                            if (value.length < 10) {
                                              return 'Phone Number Incomplete';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                            color: ThemeColors()
                                                .onBoardingHeadingColor,
                                          ),
                                          decoration: InputDecoration(
                                            prefixIconConstraints:
                                                const BoxConstraints(
                                                    minWidth: 24,
                                                    minHeight: 15,
                                                    maxHeight: 19),
                                            prefixIcon: Container(
                                              height: 19,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                      color: ThemeColors()
                                                          .deleteFromThisDevice),
                                                ),
                                              ),
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.02),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  GestureDetector(
                                                    onTap: selectCountryCode,
                                                    child: Text(
                                                      countryCode?.dialCode ??
                                                          "+92",
                                                      style: TextStyle(
                                                        color: ThemeColors()
                                                            .onBoardingHeadingColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: ThemeColors()
                                                    .enabledBorderColor,
                                              ),
                                            ),
                                            errorStyle:
                                                const TextStyle(height: 0),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: CustomTheme().errorColor,
                                                width: CustomTheme()
                                                    .errorBorderWidth,
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 2,
                                                color:
                                                    ThemeColors().labelTextColor,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.all(
                                                CustomTheme().paddingInput),
                                            hintStyle: TextStyle(
                                              color: ThemeColors().buttonColor,
                                            ),
                                            /*labelText: "Phone Number",*/
                                            hintText: "Phone Number",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: Get.height * 0.02),
                                  child: Theme(
                                    data: ThemeData(
                                      unselectedWidgetColor:
                                          ThemeColors().buttonColor,
                                    ),
                                    child: Consumer<SoulProfile_ViewModel>(builder: (context, soulProfile_ViewModel, child) =>  CustomButton(
                                      name: 'Update',
                                      onClick: () => updateVerifiedInfo(soulProfile_ViewModel),
                                      isLoading: isLoading4,
                                      color: ThemeColors().buttonColor,
                                    )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.02),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              title: Text(
                                "Interests",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              children: [
                                ListView.builder(
                                  itemCount: response.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      CustomInterestSelection(
                                    image: response[index]['image'],
                                    name: response[index]['name'],
                                    padding: index == 0 ? 0 : 0.06,
                                    nameOfArray: response[index]['tagsDetails'],
                                    selectionInterestArray:
                                        selectedInterestsArray,
                                    onSelectionChanged:
                                        _updateSelectedCount, // Pass the callback
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Get.height * 0.02),
                                  child: Theme(
                                    data: ThemeData(
                                      unselectedWidgetColor:
                                          ThemeColors().buttonColor,
                                    ),
                                    child: Consumer<SoulProfile_ViewModel>(builder: (context, soulProfile_ViewModel, child) => CustomButton(
                                      name: 'Update',
                                      onClick: () => updateInterest(soulProfile_ViewModel),
                                      isLoading: isLoading5,
                                      color: ThemeColors().buttonColor,
                                    )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }


  _buildButtonUi(SoulProfile_ViewModel soulProfile_ViewModel){
     if(!soulProfile_ViewModel.loading){
    return  Padding(
                                padding:
                                    EdgeInsets.only(bottom: Get.height * 0.02),
                                child: Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor:
                                        ThemeColors().buttonColor,
                                  ),
                                  child: CustomButton(
                                    name: 'Update',
                                    onClick: () => updateProfilePicture(soulProfile_ViewModel),
                                    isLoading: isLoading2,
                                    color: ThemeColors().buttonColor,
                                  ),
                                ),
                              );
     }

     return Padding(
                                padding:
                                    EdgeInsets.only(bottom: Get.height * 0.02),
                                child: Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor:
                                        ThemeColors().buttonColor,
                                  ),
                                  child: CustomButton(
                                    name: 'Update',
                                    onClick: () => (),
                                    color: ThemeColors().buttonColor,
                                  ),
                                ),
                              );
  }

  _buildExpansionTile(SoulProfile_ViewModel soulProfile_ViewModel){
    return ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text(
              "Profile Picture",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04),
                child: _buildPictureGridUI(soulProfile_ViewModel),
              ),
              _buildButtonUi(soulProfile_ViewModel),
            ],
          );

  }

  _buildPictureGridUI(SoulProfile_ViewModel soulProfile_ViewModel){
    if(soulProfile_ViewModel.pictureDeletingIndex == -1){
    return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: Get.height * 0.04,
                    top: Get.height * 0.02),
                child:
                    GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.65,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    children: imagePicker(soulProfile_ViewModel),
                  )
              ),
            ]
    );
    }else if(soulProfile_ViewModel.pictureDeletingIndex != -1 && soulProfile_ViewModel.pictureDeletingIndex != -2){
                 return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: Get.height * 0.04,
                    top: Get.height * 0.02),
                child:
                    GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.65,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    children: imagePickerDummy(soulProfile_ViewModel.pictureDeletingIndex),
                  )
              ),
            ]
    );
    }else if(soulProfile_ViewModel.pictureDeletingIndex == -2){
        return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: Get.height * 0.04,
                    top: Get.height * 0.02),
                child:
                    GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.65,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    children: emptyContainers(),
                  )
              ),
            ]
    );
    }
  }

  deleteImage(int index, SoulProfile_ViewModel soulProfile_ViewModel) async {
    soulProfile_ViewModel.setPictureDelete(index);
    await Future.delayed(const Duration(milliseconds: 100));
    if (image[index]["isUploaded"] == true) {
      //removing already uploaded images
      profileImageList
          .removeAt(_indexOf(profileImageList, image[index]["image"]));
      image.removeWhere((element) => element["image"] == image[index]["image"]);
    } else {
      image.removeWhere((element) => element["image"] == image[index]["image"]);
    }
    soulProfile_ViewModel.setPictureDelete(-2);
    await Future.delayed(const Duration(milliseconds: 50));
    soulProfile_ViewModel.setPictureDelete(-1);

  }

  emptyContainers(){
  List<Widget> dummyImages = List.generate(image.length, (index) =>
       InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () => (),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ThemeColors().deleteFromThisDevice,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: Icon(
              Icons.add_a_photo_outlined,
              color: ThemeColors().iconColor,
              size: 30,
            ),
          ),
        )
      );

       dummyImages.add(
        InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () => (),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ThemeColors().deleteFromThisDevice,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: Icon(
              Icons.add_a_photo_outlined,
              color: ThemeColors().iconColor,
              size: 30,
            ),
          ),
        ),
      );

      return dummyImages;
  }

  imagePickerDummy(int deleteIndex) {
    List<Widget> dummyImages = List.generate(image.length, (index) =>
      imageUpload(
        picture: image[index],
        index: index,
        isDeleting: deleteIndex == index,
        removeImage: (i) => (),
        profileImage: (i) => () {},
        isSpecial: index == 0,
      )
    );


    if (image.length < 5) {
      dummyImages.add(
        InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () => (),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ThemeColors().deleteFromThisDevice,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: Icon(
              Icons.add_a_photo_outlined,
              color: ThemeColors().iconColor,
              size: 30,
            ),
          ),
        ),
      );
    }

    return dummyImages;
  }

  imagePicker(SoulProfile_ViewModel soulProfile_ViewModel) {
    List<Widget> images = List.generate(image.length, (index) =>
      imageUpload(
        picture: image[index],
        index: index,
        isDeleting: false,
        removeImage: (i) => deleteImage(i,soulProfile_ViewModel),
        profileImage: (i) => () {},
        // setState(() {
        //   // var temp = image[0]; // A = B
        //   // image[0] = image[i]; // B = C
        //   // image[i] = temp; // C = A
        // }),
        isSpecial: index == 0,
      )
    );

    // profileImageList.forEach((element) {
    //   images.add(
    //     InkWell(
    //       borderRadius: BorderRadius.circular(6),
    //       onTap: () {
    //         // Handle removal logic here
    //       },
    //       child: Container(
    //         decoration: BoxDecoration(
    //           border: Border.all(
    //             color: ThemeColors().deleteFromThisDevice,
    //           ),
    //           borderRadius: const BorderRadius.all(Radius.circular(6)),
    //         ),
    //         child: Stack(
    //           children: [
    //             Image.network(
    //               fileUrl + element,
    //               fit: BoxFit
    //                   .cover, // Ensure the image fully covers the container
    //               width:
    //                   double.infinity, // Take the full width of the container
    //               height:
    //                   double.infinity, // Take the full height of the container
    //             ),
    //             Positioned(
    //               top: 0, // Set top to a negative value
    //               right: 0, // Adjust the right position as needed
    //               child: Container(
    //                 width: 30, // Adjust the size as needed
    //                 height: 30, // Adjust the size as needed
    //                 decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   color: Colors.red,
    //                 ),
    //                 child: Center(
    //                   child: Icon(
    //                     Icons.close,
    //                     color: Colors.white,
    //                     size: 20, // Adjust the size as needed
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // });

    if (image.length < 5) {
      images.add(
        InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: _getFromGallery,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ThemeColors().deleteFromThisDevice,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: Icon(
              Icons.add_a_photo_outlined,
              color: ThemeColors().iconColor,
              size: 30,
            ),
          ),
        ),
      );
    }

    return images;
  }

  _getFromGallery() async {
    if (image.length < 5) {
      final ImagePicker picker = ImagePicker();
      var temp = await picker.pickMultiImage();

      if (temp.length + image.length > 5) {
        temp = temp.sublist(0, 5 - image.length);
        Get.snackbar(
            backgroundColor: CustomTheme().errorColor,
            colorText: Colors.white,
            "Error",
            "You can only upload 5 images");
      }

      for (var element in temp) {
        image.add({"image": element, "isVerified": 0, "isUploaded": false});
      }

      setState(() {});
      _verifyImage();
    } else {
      Get.snackbar(
          backgroundColor: CustomTheme().errorColor,
          colorText: Colors.white,
          "Error",
          "You can only upload 5 images");
    }
  }

  _verifyImage() async {
    List<Face> faces;

    for (var element in image) {
      if (element["isVerified"] == 0) {
        faces = await FaceDetector(options: FaceDetectorOptions())
            .processImage(InputImage.fromFilePath(element["image"]!.path));
        setState(() {
          element["isVerified"] = faces.length == 1 ? 1 : 2;
        });
      }
    }
  }

  void dropDownValueProfession(value) {
    setState(() {
      profession = (value) as String;
    });
  }

  void dropDownValueReligion(value) {
    setState(() {
      religion = (value) as String;
    });
  }

  void selectCountryCode() async {
    final code = await countryPicker.showPicker(context: context);
    setState(() {
      countryCode = code;
    });
  }

  void _updateSelectedCount() {
    setState(() {
      selectedCount = selectedInterestsArray.length;
    });
  }

  void _religion(value) {
    setState(() {
      religion = (value) as String;
    });
  }

  void _profession(value) {
    setState(() {
      profession = (value) as String;
    });
  }

  //Update button methods
  void updatePersonalInfo() async {
    //  var temp = [];
    // String height = "${feetController.text}.${inchesController.text}";
    // // String age = (DateTime.now().year -
    // //             int.parse(dateController.text.toString().substring(0, 4)))
    // //         .toString();
    // Map<String, dynamic> bodyData = {
    //     "uID": userProfile.id,
    //     "Name": nameController.text.toString(),
    //     "Gender": gender,
    //     "Age": '',
    //     "email": emailController.text.toString(),
    //     "phoneNumber": phoneNumberController.text.toString(),
    //     "height":  height.toString(),
    //     "rID": '',
    //     "pID": '',
    //     "education": userProfile.education[0].toString(),
    //     "Images": ''
    // };

    // var response = await connector.uploadImage_Data(
    //   "${uploadInfo + userProfile.id}/moreinfo",
    //         temp,
    //         bodyData,
    //         "image",
    //         "PUT");
    setState(() {
      isLoading1 = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));
     Get.snackbar(
        backgroundColor: CustomTheme().successColor,
        colorText: Colors.white,
        "Personal Info",
        "Your personal info updated",
        duration: const Duration(seconds: 1),
      );
      setState(() {
        isLoading1 = false;
      });
  }

  updateProfilePicture(SoulProfile_ViewModel soulProfile_ViewModel) async {
    if (image.length == 0 && profileImageList.length == 0) {
      Get.snackbar(
        backgroundColor: CustomTheme().errorColor,
        colorText: Colors.white,
        "Profile Picture",
        "Please upload atleast one image",
        duration: const Duration(seconds: 1),
      );
      return;
    }

    setState(() {
      isLoading2 = true;
    });
    var temp = [];
    for (var e in image) {
      if (e["isVerified"] == 1 && e["isUploaded"] == false)
        temp.add(e["image"]);
    }
    Map<String, String> bodyData = {
      "uID": soulProfile_ViewModel.profileVerification!.uID!,
      "existImages": jsonEncode(profileImageList),
    };
    var response = await connector.uploadImage_Data(
        "${uploadInfo}/images/update", temp, bodyData, "image", "POST");

    Get.snackbar(
      backgroundColor: CustomTheme().successColor,
      colorText: Colors.white,
      "Profile Picture",
      "${response["response"]["message"]}",
      duration: const Duration(seconds: 1),
    );
    setState(() {
      isLoading2 = false;
    });

    List<String> pictures = List<String>.from(response["response"]["response"].map((dynamic e) => e.toString()));
    soulProfile_ViewModel.updateProfilePictures(pictures);
  }

  updatePublicInfo(SoulProfile_ViewModel soulProfile_ViewModel) async {
    setState(() {
      isLoading3 = true;
    });

    Map<dynamic, dynamic> body = {
      "uID": soulProfile_ViewModel.profileVerification!.uID,
      "height": "${feetController.text}.${inchesController.text}",
      "rID": dropDown["religionList"]!["id"]
          [_indexOf(dropDown["religionList"]!["list"], religion)],
      "pID": dropDown["professionList"]!["id"]
          [_indexOf(dropDown["professionList"]!["list"], profession)],
      "education": soulProfile_ViewModel.profileOverview!.profileData!.education![0].toString(),
      "multipleMarriage":
          multipleMarriageOR2ndWife.toString(), //need to work here more
    };

    var profileInfo = await connector.put("$getprofile/updatepublic", body);
    soulProfile_ViewModel.profileOverview!.profileData!.religion = religion;
    soulProfile_ViewModel.profileOverview!.profileData!.profession = profession;
    soulProfile_ViewModel.profileOverview!.profileData!.height = "${feetController.text}.${inchesController.text}";
    if (profileInfo != null && profileInfo["success"] == true) {
      Get.snackbar(
        backgroundColor: CustomTheme().successColor,
        colorText: Colors.white,
        "Verified Info",
        "${profileInfo["message"]}",
        duration: const Duration(seconds: 1),
      );
      setState(() {
        isLoading3 = false;
      });

      soulProfile_ViewModel.LoadProfileOverView();
    }
  }

  updateVerifiedInfo(SoulProfile_ViewModel soulProfile_ViewModel) async {
    setState(() {
      isLoading4 = true;
    });

    Map<dynamic, dynamic> body = {
      "uID": soulProfile_ViewModel.profileVerification!.uID,
      "phoneNumber": phoneNumberController.text.toString(),
      "email": emailController.text.toString(),
    };
    soulProfile_ViewModel.profileVerification!.email = emailController.text.toString();
    soulProfile_ViewModel.profileVerification!.phoneNumber = phoneNumberController.text.toString();

    var profileInfo = await connector.post("$getprofile/updatepersonal", body);
    if (profileInfo != null && profileInfo["success"] == true) {
      Get.snackbar(
        backgroundColor: CustomTheme().successColor,
        colorText: Colors.white,
        "Verified Info",
        "${profileInfo["message"]}",
        duration: const Duration(seconds: 1),
      );
      soulProfile_ViewModel.notify();
    }
    setState(() {
        isLoading4 = false;
      });
  }

  updateInterest(SoulProfile_ViewModel soulProfile_ViewModel) async {

    if(selectedInterestsArray.isEmpty || selectedInterestsArray.length < 5){
       Get.snackbar(
        "Minimum Interests Not Reached",
        "Please select at least 5 interests.",
        backgroundColor: CustomTheme().errorColor,
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      isLoading5 = true;
    });

    Map<dynamic, dynamic> body = {
      "uID": soulProfile_ViewModel.profileVerification!.uID,
      "interestIdList": jsonEncode(selectedInterestsArray),
    };

    var interestData = await connector.put(interest, body);
    if (interestData != null && interestData["success"] == true) {

      soulProfile_ViewModel.LoadProfileOverView();

        List<String> ageList;
        ageList = age.split("-").map((age) => age.trim()).toList();
        List<String> heightList = heightInRange.split(" - ").map((height) {
          height = height.replaceAll("'", ".");
          return height;
        }).toList();

        Map<String, dynamic> filter = {
          "uID": soulProfile_ViewModel.profileOverview!.profileData!.uId!,
          "gender": soulProfile_ViewModel.getGender().toString(),
          "age": ageList.toString(),
          "height": heightList.toString(),
          "education": soulProfile_ViewModel.profileOverview!.profileData!.education![0].toString(),
          "city": mainFilter.cityDataFilter.cid.toString(),
        };

         await updateMainFilter(soulProfile_ViewModel,{
          "gender": soulProfile_ViewModel.getGender().toString(),
          "age": ageList.toString(),
          "preferenceFilter": jsonEncode(preferenceInfo),
          "education": mainFilter.educationFilter
          // "height": '0',
          // "education" : "0",
          // "city": "0"
        });

      Get.snackbar(
        backgroundColor: CustomTheme().successColor,
        colorText: Colors.white,
        "Interest",
        "${interestData["message"]}",
        duration: const Duration(seconds: 1),
      );
      setState(() {
        isLoading5 = false;
      });

      }
  }

    updateMainFilter(SoulProfile_ViewModel soulProfile_ViewModel,filter) async {
    //var response = await connector.post("$match/${userProfile.id}", filter);

    SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel = Provider.of<SoulProfilesTimeline_ViewModel>(context, listen:  false);
     SubscriptionPackage_ViewModel subscriptionPackage_ViewModel = Provider.of<SubscriptionPackage_ViewModel>(context, listen: false);

    await soulProfilesTimeline_ViewModel.showProfiles(
      soulProfile_ViewModel.profileOverview!.profileData!.uId!, 
      filter,
      soulProfile_ViewModel.profileVerification!.getAccessToken(),
      subscriptionPackage_ViewModel.currentPackageType
      );    

    // if (response["success"] != null && response["success"]) {
    //   for (var element in response["profiles"].keys.toList()) {
    //     user[element] = response["profiles"][element].map<Profiles>((e) {
    //       return Profiles.fromJson(e);
    //     }).toList();
    //   }
    // }
    // return response;
  }
}
