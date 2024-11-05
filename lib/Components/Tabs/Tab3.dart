import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Components/RadioButtons/CustomRadioButtons.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

import '../../Utils/Constants.dart';
import '../../view_model/SoulProfile_ViewModel.dart';
import '../DropDowns/CustomDropDown1.dart';
import '../Textfields/CustomTextField4.dart';

class Tab3 extends StatefulWidget {
  const Tab3({Key? key}) : super(key: key);

  @override
  State<Tab3> createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
  int _currentIndex = 0;
  Map<String, dynamic> careerData = {};

  @override
  void initState() {
    // TODO: implement
    // initState
    super.initState();
    
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
    var response = connector.get("$career/${soulProfile_ViewModel.profileVerification!.uID}");

    response.then((value) {
      if (value["isCareer"] != null &&
          value["isCareer"] &&
          value["response"] != {}) {
        setState(() {
          _currentIndex = 2;
          careerData = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _currentIndex == 0
        ? Padding(
            padding: mainBodyPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShowUpAnimation(
                  animationDuration: const Duration(milliseconds: 900),
                  curve: Curves.decelerate,
                  direction: Direction.horizontal,
                  offset: 0.5,
                  child: SizedBox(
                    height: Get.height * 0.30,
                    child: Image.asset(
                      "assets/images/career_image.png",
                    ),
                  ),
                ),
                ShowUpAnimation(
                  animationDuration: const Duration(milliseconds: 600),
                  delayStart: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                  direction: Direction.horizontal,
                  offset: 0.5,
                  child: Text(
                    "Careers",
                    style: TextStyle(
                      fontSize: 32,
                      color: ThemeColors().buttonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                  child: ShowUpAnimation(
                    animationDuration: const Duration(milliseconds: 800),
                    delayStart: const Duration(milliseconds: 800),
                    curve: Curves.decelerate,
                    direction: Direction.horizontal,
                    offset: 0.5,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Become a part of potential Job hunting with us.",
                      style: TextStyle(
                        fontSize: 22,
                        color: ThemeColors().careerDetailsColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                ShowUpAnimation(
                  animationDuration: const Duration(milliseconds: 900),
                  delayStart: const Duration(milliseconds: 1500),
                  curve: Curves.easeOutCubic,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: SizedBox(
                    width: Get.width * 0.6,
                    child: CustomButton(
                      name: "Apply Now",
                      onClick: _onButtonClick,
                      color: ThemeColors().buttonColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        : _currentIndex == 1
            ? CareerForm(
                onFormSubmit: _onFormSubmit,
                formData: careerData["response"] ?? {},
                isEdit: careerData["isEdit"] ?? false,
              )
            : SuccessScreen(
                isEdit: careerData["isEdit"] ?? false,
                onFormSubmit: _onButtonClick);
  }

  void _onButtonClick() {
    setState(() {
      _currentIndex = 1;
    });
  }

  void _onFormSubmit() {
    setState(() {
      _currentIndex = 2;
    });
  }
}

class CareerForm extends StatefulWidget {
  final VoidCallback onFormSubmit;
  late Map<String, dynamic> formData;
  final bool isEdit;
  CareerForm({
    super.key,
    required this.onFormSubmit,
    required this.formData,
    required this.isEdit,
  });

  @override
  State<CareerForm> createState() => _CareerFormState();
}

class _CareerFormState extends State<CareerForm> {
  TextEditingController jobTitleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int isRelocate = 0;
  bool isLoading = false;
  bool isCVUploaded = false;
  late File cvFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(widget.formData);
    if (widget.formData != {}) {
      jobStatus = widget.formData["Industry"] ??
          jobStatusItems[
              0]; // jab bhi banda ya code dikha tu swiping wala example yaad raka
      industry = widget.formData["JobStatus"] ??
          industryItems[
              0]; // jab bhi banda ya code dikha tu swiping wala example yaad raka
      jobTitleController.text = widget.formData["JobTitle"] ?? "";
      expectedSalary =
          widget.formData["ExpectedSalary"] ?? expectedSalaryItems[0];
      isRelocate = widget.formData["relocate"] ?? 0;
      isCVUploaded = widget.formData["CV"] != null;
      cvFile = File(widget.formData["CV"] ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: tab3Padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Job Status",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  CustomDropDown1(
                    product: jobStatus,
                    productItems: jobStatusItems,
                    onChanged: dropDownValueJobStatus,
                    label: "Job Status",
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.04),
                    child: Text(
                      "Industry",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  CustomDropDown1(
                    product: industry,
                    productItems: industryItems,
                    onChanged: dropDownValueIndustry,
                    label: "Industry",
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.04),
                    child: Text(
                      "Job Title",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  CustomTextfield4(
                    controller: jobTitleController,
                    label: "Job Title",
                    inputType: TextInputType.text,
                    hint: "Enter Job Title",
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.04),
                    child: Text(
                      "Expected Salary",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  CustomDropDown1(
                    product: expectedSalary,
                    productItems: expectedSalaryItems,
                    onChanged: dropDownValueExpectedSalary,
                    label: "Expected Salary",
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.04),
                    child: Text(
                      "Are you willing to relocate?",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: Get.height * 0.06),
                    child: CustomRadioButtons(
                      onTap: (value) => setState(() {
                        isRelocate = value;
                      }),
                      option: const ["Yes", "No"],
                      selection: isRelocate,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: uploadCV,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: ThemeColors().containerOutlineColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isCVUploaded
                                ? Icons.check_circle
                                : Icons.cloud_upload,
                            color: isCVUploaded
                                ? CustomTheme().successColor
                                : ThemeColors().buttonColor,
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          Text(
                            isCVUploaded
                                ? cvFile.path.split("/").last
                                : "Upload CV",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: isCVUploaded
                                  ? CustomTheme().successColor
                                  : ThemeColors().buttonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.02),
                    child: GestureDetector(
                      onTap: nextScreen,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade500,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isLoading) // show CircularProgressIndicator only when isLoading is true
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                                ),
                              SizedBox(
                                  width: isLoading
                                      ? 10.0
                                      : 0.0), // add some spacing between CircularProgressIndicator and text
                              Text(
                                isLoading
                                    ? 'Submitting...'
                                    : widget.isEdit
                                        ? "Update"
                                        : 'Submit',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  uploadCV() async {
    var file = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (file != null && file.paths.isNotEmpty) {
      setState(() {
        cvFile = File(file.paths[0]!);
        isCVUploaded = true;
      });

      Get.snackbar(
        "Success",
        "CV uploaded successfully",
        backgroundColor: CustomTheme().successColor,
        colorText: Colors.white,
      );
    } else {
      // User canceled the picker
    }
  }

  void nextScreen() async {
    if (_formKey.currentState!.validate() && isCVUploaded) {
      setState(() {
        isLoading = true;
      });
      Map<String, String> body = {
        "expectedSalary": expectedSalary.toString(),
        "jobTitle": jobTitleController.text,
        "industry": jobStatus.toString(),
        "jobStatus": industry.toString(),
        "relocate": isRelocate.toString(),
      };

      SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen:  false);

      var response =
          connector.uploadPdf("$career/${soulProfile_ViewModel.profileOverview!.profileData!.uId}", cvFile, body);
      response.then((value) {
        if (value["success"]) {
          widget.onFormSubmit();
          widget.formData = value["response"];
        }
      });
      // await Future.delayed(const Duration(seconds: 2));
      setState(() {
        isLoading = false;
      });
    }
  }

  void dropDownValueJobStatus(value) {
    setState(() {
      jobStatus = (value) as String;
    });
  }

  void dropDownValueIndustry(value) {
    setState(() {
      industry = (value) as String;
    });
  }

  void dropDownValueExpectedSalary(value) {
    setState(() {
      expectedSalary = (value) as String;
    });
  }
}

class SuccessScreen extends StatelessWidget {
  final bool isEdit;
  final VoidCallback onFormSubmit;

  const SuccessScreen({
    Key? key,
    required this.isEdit,
    required this.onFormSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: mainBodyPadding,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                  child: Image.asset(
                    "assets/images/career_image.png",
                    scale: 2,
                  ),
                ),
                Text(
                  "Careers",
                  style: TextStyle(
                    fontSize: 32,
                    color: ThemeColors().buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.04),
                  child: ShowUpAnimation(
                    animationDuration: const Duration(milliseconds: 500),
                    delayStart: const Duration(milliseconds: 50),
                    curve: Curves.decelerate,
                    direction: Direction.horizontal,
                    offset: 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          "Successfully Applied! ",
                          style: TextStyle(
                            fontSize: 22,
                            color: ThemeColors().buttonColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.verified_rounded,
                          color: Colors.blue[700],
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
                isEdit
                    ? ShowUpAnimation(
                        animationDuration: const Duration(milliseconds: 900),
                        delayStart: const Duration(milliseconds: 1500),
                        curve: Curves.easeOutCubic,
                        direction: Direction.vertical,
                        offset: 0.5,
                        child: SizedBox(
                          width: Get.width * 0.6,
                          child: CustomButton(
                            name: "Edit Details",
                            onClick: onFormSubmit,
                            color: ThemeColors().buttonColor,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
