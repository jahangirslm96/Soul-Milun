import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Screens/Personalization/labelWrap.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Components/Card/uploadedImage.dart';
import 'package:soul_milan/Components/DropDowns/CustomDropDown1.dart';
import 'package:soul_milan/Components/DropDowns/HeightDropdown.dart';
import 'package:soul_milan/Components/Textfields/TextBoxField.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';

import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/Routes.dart';
import '../../Components/DateTimePicker/CustomDateTimePicker.dart';
import '../../Components/Headers/HeaderWithBackIcon.dart';
import '../../Components/MultipleSelectionButtons/MultipleCheckBox.dart';
import '../../Components/RadioButtons/CustomRadioButtons.dart';
import '../../Utils/ThemeColors.dart';
import '../../view_model/SoulProfile_ViewModel.dart';

class PublicInfoScreen extends StatefulWidget {
  const PublicInfoScreen({Key? key}) : super(key: key);

  @override
  State<PublicInfoScreen> createState() => _PublicInfoScreenState();
}

class _PublicInfoScreenState extends State<PublicInfoScreen> {
  List<Map<String, dynamic>> image = [];
  bool isDropDown = false;
  bool isLoading = false;
  Map<String, Map<String, dynamic>> dropDown = {};

  int gender = 0;
  int multipleMarriage = 0;

  Map<String, dynamic> profileImage = {"image": "", "isVerified": 0};

  TextEditingController dobController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController taglineController = TextEditingController();

  TextEditingController feetController = TextEditingController();
  TextEditingController inchesController = TextEditingController();

  String maritalStatus = "";
  String city = "";
  String religion = "";
  String profession = "";

  bool isMarriages = false;
  List<dynamic> selectedmStatus = [];

  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    feetController.text = '5';
    inchesController.text = '2';
    _load();
  }

  _load() async {
    try{
    var response = await connector.get(getdropDown);
    print(response);
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

      setState(() {
        selectedmStatus = maritalStatusItems;
        maritalStatus = dropDown["martialList"]!["list"][0];
        city = dropDown["cityList"]!["list"][0];
        religion = dropDown["religionList"]!["list"][0];
        profession = dropDown["professionList"]!["list"][0];
        isDropDown = true;
      });
    } else {
      print(response);
    }
    }catch(error){
      print(error);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dobController.dispose();
    dateController.dispose();
    bioController.dispose();
    taglineController.dispose();
    feetController.dispose();
    inchesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: headerPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Expanded(
                        child: HeaderWithBackIcon(
                          title: "Public Information",
                          subtitle:
                              "This’ll help us to customize your feed according to your needs.",
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: ThemeColors().containerOutlineColor,
                  thickness: Get.height * 0.0005,
                ),
                Padding(
                  padding: mainBodyPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Picture Section

                      Text(
                        "Upload Profile Picture",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.01),
                        child: Text.rich(
                          TextSpan(
                            text: "Note:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: CustomTheme().errorColor,
                            ),
                            children: [
                              TextSpan(
                                text: " Ensure your face is clearly visible.",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: ThemeColors().buttonColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.01),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.002,
                                  horizontal: Get.width * 0.004),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: CustomTheme().successColor,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.star,
                                color: ThemeColors().buttonColor,
                                size: 12,
                              ),
                            ),
                            Text(
                              " Indicates your Profile Picture.",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: ThemeColors().buttonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<SoulProfile_ViewModel>(builder: (context, soulProfile_ViewModel, child) =>  Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.02),
                          child: _buildExpansionTile(soulProfile_ViewModel),
                      )),

                      // Profile Picture Section End

                      labelWrap(
                        label: "Date of Birth",
                        child: CustomDatePicker(
                          controller: dateController,
                          label: "DD-MM-YYYY",
                        ),
                      ),
                      labelWrap(
                        label: "Height",
                        child: HeightInput(
                          controller1: feetController,
                          controller2: inchesController,
                        ),
                      ),
                      labelWrap(
                        label: "Gender",
                        child: CustomRadioButtons(
                            onTap: _gender,
                            option: const ["Male", "Female"],
                            selection: gender),
                      ),
                      labelWrap(
                        label: "Religion",
                        child: CustomDropDown1(
                            product: religion,
                            productItems: isDropDown
                                ? dropDown["religionList"]!["list"]
                                : religionItems,
                            onChanged: _religion,
                            label: "Religion"),
                      ),
                      labelWrap(
                        label: "Marital Status",
                        child: CustomDropDown1(
                            product: maritalStatus,
                            productItems: isDropDown
                                ? selectedmStatus
                                : maritalStatusItems,
                            onChanged: _maritalStatus,
                            label: "Marital Status"),
                      ),
                      _validation()
                          ? labelWrap(
                              label: isMarriages
                                  ? "Open to be another Wife?"
                                  : "Willing to do multiple marriages?",
                              child: CustomRadioButtons(
                                  onTap: _multipleMarriage,
                                  option: const ["Yes", "No"],
                                  selection: multipleMarriage),
                            )
                          : Container(),
                      labelWrap(
                        label: "Marriage Plans",
                        child: MultipleCheckBox(
                          arrayNameOptions: marriagePlansItems,
                          selectionArray: selectedMarriagePlans,
                          allowMultipleSelection: false,
                        ),
                      ),
                      labelWrap(
                        label: "Religious Practice",
                        child: MultipleCheckBox(
                          arrayNameOptions: religiousPracticeItems,
                          selectionArray: selectedReligiousPractice,
                          allowMultipleSelection: false,
                        ),
                      ),
                      labelWrap(
                        label: "Education",
                        child: MultipleCheckBox(
                          arrayNameOptions: educationItems,
                          selectionArray: selectedEducation,
                          allowMultipleSelection: false,
                        ),
                      ),
                      labelWrap(
                        label: "City",
                        child: CustomDropDown1(
                            product: city,
                            productItems: isDropDown
                                ? dropDown["cityList"]!["list"]
                                : cityItems,
                            onChanged: _city,
                            label: "City"),
                      ),
                      labelWrap(
                        label: "Relocation Plans",
                        child: MultipleCheckBox(
                          arrayNameOptions: relocationItems,
                          selectionArray: selectedRelocation,
                          allowMultipleSelection: false,
                        ),
                      ),
                      labelWrap(
                        label: "Profession",
                        child: CustomDropDown1(
                          product: profession,
                          productItems: isDropDown
                              ? dropDown["professionList"]!["list"]
                              : professionItems,
                          onChanged: _profession,
                          label: "Profession",
                        ),
                      ),
                      labelWrap(
                          isRequired: true,
                          label: "Tagline",
                          child: TextFeildInputBorder(
                              controller: taglineController, hint: "Tagline")),
                      labelWrap(
                          label: "Bio",
                          child: TextBoxField(
                              label: "Bio",
                              controller: bioController,
                              hint: "Add Bio here ...")),

                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.06),
                        child: CustomButton(
                          // isDisabled: false,
                          name: "Save",
                          isLoading: isLoading,
                          onClick: nextScreen,
                          color: ThemeColors().buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  deleteImage(int index, SoulProfile_ViewModel soulProfile_ViewModel) async {
  soulProfile_ViewModel.setPictureDelete(index);
  await Future.delayed(const Duration(milliseconds: 100));
   image.removeWhere((element) => element["image"] == image[index]["image"]);
  soulProfile_ViewModel.setPictureDelete(-2);
  await Future.delayed(const Duration(milliseconds: 50));
  soulProfile_ViewModel.setPictureDelete(-1);

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

  _buildExpansionTile(SoulProfile_ViewModel soulProfile_ViewModel){
    if(soulProfile_ViewModel.pictureDeletingIndex == -1){
    return  Padding(
            padding: EdgeInsets.only(top: Get.height * 0.03),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.65,
              physics: const NeverScrollableScrollPhysics(),
              children: imagePicker(soulProfile_ViewModel),
            ),
          );
    }else if(soulProfile_ViewModel.pictureDeletingIndex != -1 && soulProfile_ViewModel.pictureDeletingIndex != -2){
                 return
                   Padding(
            padding: EdgeInsets.only(top: Get.height * 0.03),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.65,
              physics: const NeverScrollableScrollPhysics(),
              children: imagePickerDummy(soulProfile_ViewModel.pictureDeletingIndex),
            ),
          );
          
    }else if(soulProfile_ViewModel.pictureDeletingIndex == -2){
        return 
        Padding(
            padding: EdgeInsets.only(top: Get.height * 0.03),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.65,
              physics: const NeverScrollableScrollPhysics(),
              children:emptyContainers(),
            ),
          );
    }

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

  _getKey(item, search) {
    print(item + " "+ search);
    if(search == ""){
      print("true");
    }else{
      print(search);
    }
    int index = search != "" ? (dropDown[item]?["list"].indexOf(search)) : -1;
    return index == -1 ? "" : dropDown[item]?["id"][index];
  }

  int _indexOf(arrayToSearch, element) {
    print(arrayToSearch);
    print(element);
    return element != "" ? arrayToSearch.indexOf(element) : 0;
  }

  void nextScreen() async {
    try {
      if (_formKey.currentState!.validate()) {
       
        print("hello1");
        if (image.isEmpty) {
          Get.snackbar(
            "Error",
            "Upload images.",
            backgroundColor: CustomTheme().errorColor,
            colorText: Colors.white,
          );
          setState(() {
            isLoading = false;
          });
          return;
        }

        print("hello2");
        var temp = [];
        for (var e in image) {
          if (e["isVerified"] == 1) temp.add(e["image"]);
        }

        if (temp.isEmpty || temp == []) {
          Get.snackbar(
            "Error",
            "Upload valid images.",
            backgroundColor: CustomTheme().errorColor,
            colorText: Colors.white,
          );
          setState(() {
            isLoading = false;
          });
          return;
        }

        print("hello3");
        String height = "${feetController.text}.${inchesController.text}";
        print("height: "+height.toString());
        String age = (DateTime.now().year -
                int.parse(dateController.text.toString().substring(0, 4)))
            .toString();
        print("age: "+age.toString());
        print("hello4");
        
        if(selectedMarriagePlans.isEmpty){
            Get.snackbar(
            "Error",
            "Select your marriage plan",
            backgroundColor: CustomTheme().errorColor,
            colorText: Colors.white,
          );
        return;
        }
        else  if(selectedReligiousPractice.isEmpty){
            Get.snackbar(
            "Error",
            "Select your religious practice",
            backgroundColor: CustomTheme().errorColor,
            colorText: Colors.white,
          );
        return;
        }
        else  if(selectedEducation.isEmpty){
            Get.snackbar(
            "Error",
            "Select your education",
            backgroundColor: CustomTheme().errorColor,
            colorText: Colors.white,
          );
        return;
        }
        else if(selectedRelocation.isEmpty){
            Get.snackbar(
            "Error",
            "Select your relocation plan",
            backgroundColor: CustomTheme().errorColor,
            colorText: Colors.white,
          );
        return;
        }
         setState(() {
          isLoading = true;
        });

        Map<String, String> bodyData = {
          "uID": storge.read("uid") ?? "",
          "rID": dropDown["religionList"]!["id"][_indexOf(dropDown["religionList"]!["list"], religion)],
          "mID": _getKey("martialList", maritalStatus) ?? "",
          "pID": _getKey("professionList", profession) ?? "",
          "bio": bioController.text.toString(),
          "height": height,
          "dob": dateController.text.toString(),
          "city": _getKey("cityList", city) ?? "",
          "tagLine": taglineController.text.toString(),
          "gender": gender.toString(),
          "age": age,
          "multipleMarriage": multipleMarriage.toString(),
          "rPractice":
              _indexOf(religiousPracticeItems, selectedReligiousPractice[0]).toString(),
          "education": selectedEducation[
              0], //_indexOf(educationItems, selectedEducation[0]),
          "isRelocation": _indexOf(relocationItems, selectedRelocation[0]).toString(),
          "mPlan": _indexOf(marriagePlansItems, selectedMarriagePlans[0]).toString(),
        };
        print(bodyData);

        var response = await connector.uploadImage_Data(
            "${uploadInfo + storge.read("uid")}/moreinfo",
            temp,
            bodyData,
            "image",
            "POST");
        print(response);
        if (response["success"] != null && response["success"] == true) {
          storge.write("screen", RoutesClass.interestScreen);
          var pic = response["response"]["Images"][0];
          // userProfile.update(bodyData, pic);
          Get.offAndToNamed(RoutesClass.interestScreen);
          return;
        } else {
          Get.snackbar(
            "Error",
            response["message"] ?? "Someting went wrong.",
            backgroundColor: CustomTheme().errorColor,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Fields are missing.",
          backgroundColor: CustomTheme().errorColor,
          colorText: Colors.white,
        );
      }
        setState(() {
            isLoading = false;
          });
    } 
    catch (error) {
       setState(() {
            isLoading = false;
          });
      //print(error);
      Get.snackbar(
        "Error",
        "$error",
        backgroundColor: CustomTheme().errorColor,
        colorText: Colors.white,
      );
       
    }
  }

  void _gender(value) {
    setState(() {
      selectedmStatus = maritalStatusItems;
      if (value == 0 && !selectedmStatus.contains("Married")) {
        if (maritalStatus == "Married") {
          setState(() {
            maritalStatus = selectedmStatus[0];
          });
        }
        selectedmStatus.insert(1, "Married");
      } else {
        selectedmStatus.remove("Married");
      }
      gender = value;
      isMarriages = value != 0;
    });
  }

  bool _validation() {
    return maritalStatus != "Never Married" && religion == "Muslim";
  }

  void _multipleMarriage(value) {
    setState(() {
      multipleMarriage = (value);
    });
  }

  void _maritalStatus(value) {
    setState(() {
      maritalStatus = (value) as String;
    });
  }

  void _city(value) {
    setState(() {
      city = (value) as String;
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
}

class TextFeildInputBorder extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;
  final String hint;
  const TextFeildInputBorder(
      {super.key,
      required this.controller,
      this.maxLength = 40,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ThemeColors().labelTextColor,
      controller: controller,
      maxLength: maxLength,
      /*onChanged: onChanged,*/
      style: TextStyle(
        color: ThemeColors().onBoardingHeadingColor,
      ),
      maxLines: 2,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColors().containerOutlineColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: ThemeColors().labelTextColor,
          ),
        ),
        errorStyle: TextStyle(
          height: 0,
          color: CustomTheme().errorColor,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: CustomTheme().errorColor,
            width: CustomTheme().errorBorderWidth,
          ),
        ),
        contentPadding: EdgeInsets.all(CustomTheme().paddingInput),
        hintStyle: TextStyle(
          color: ThemeColors().buttonColor,
          fontSize: 18,
        ),
        hintText: "Add $hint ...",
      ),
    );
  }
}
