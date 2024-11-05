import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Components/DateTimePicker/CustomTimePickerVerifiedScreen.dart';
import 'package:soul_milan/Components/Headers/CustomHeader4.dart';
import 'package:soul_milan/Utils/Controller/model/TourPartners.model.dart';

import '../../Components/Buttons/CustomButton.dart';
import '../../Components/Card/VerfiedSoulsCard.dart';
import '../../Components/DateTimePicker/CustomDatePickerVerifiedScreen.dart';
import '../../Components/Headers/CustomHeader.dart';
import '../../Utils/Constants.dart';
import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';
import '../../Utils/Controller/constant.dart';
import 'package:soul_milan/view_model/TourPartners_ViewModel.dart';

class VerifiedSoulsScreen extends StatefulWidget {
  const VerifiedSoulsScreen({Key? key}) : super(key: key);

  @override
  State<VerifiedSoulsScreen> createState() => _VerifiedSoulsScreenState();
}

class _VerifiedSoulsScreenState extends State<VerifiedSoulsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 12),
                    child:  const CustomHeader(
                      name: "Verified Tour Partners",
                    ),
                  ),
                  Divider(
                    color: ThemeColors().containerOutlineColor,
                    thickness: Get.height *0.0005,
                  ),

                ],
              ),
              Padding(
                padding: mainBodyPadding,
                child: Column(
                  children: [
                    Text(
                      "Enjoy a safe and appealing experience with our trusted souls.",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Consumer<TourPartners_ViewModel>(builder: (context, value, child) =>
                        _buildUI(value)
                    ),

                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildUI(TourPartners_ViewModel tourPartners_ViewModel){
    return Column(
                  children: [
                   ScrollConfiguration(
                     behavior: const ScrollBehavior().copyWith(overscroll: false),
                     child: ListView.builder(
                        itemCount: tourPartners_ViewModel.tourCode == "male" ? tourPartners_ViewModel.getTourerTimeline("male").length : tourPartners_ViewModel.getTourerTimeline("female").length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder:  (context, index){
                          Map<String, dynamic>? temp_tourProfile;
                          if( tourPartners_ViewModel.tourCode == "male"){
                            temp_tourProfile = tourPartners_ViewModel.getTourerTimeline("male")[index].toJson();
                          }else{
                             temp_tourProfile = tourPartners_ViewModel.getTourerTimeline("female")[index].toJson();
                          }
                          TourProfile tourProfile = TourProfile.fromJson(temp_tourProfile!);
                          return VerifiedSoulsCard(
                            selectedTourProfile: tourProfile,
                            name: tourProfile.name ?? "",
                            fullName: tourProfile.name ?? "",
                            tagline: tourProfile.description ?? "",
                            age: tourProfile.age.toString() ?? "",
                            city: tourProfile.location ?? "",
                            country: 'Pakistan',
                            rate: tourProfile.rate ?? "",
                            imageUrl: "$fileUrl${tourProfile.profilePicture}",
                            onClick: () {
                              letsTourButtonFunction(context);
                            },
                          );
                        },
                      ),
                   ),
                  ],
                );
  }

  Future<void> letsTourButtonFunction(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: mainBodyPadding,
          child: Form(
            key: _formKey, // Assign the form key here
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Date & Time',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors().buttonColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.04),
                  child: CustomDatePickerVerifiedScreen(
                    controller: dateController,
                    label: "Date",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.04),
                  child: CustomTimePickerVerifiedScreen(
                    controller: timeController,
                    label: "Time",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a time';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.02),
                  child: CustomButton(
                    name: "Proceed",
                    onClick: nextScreen,
                    color: ThemeColors().buttonColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void nextScreen() async {
    if (_formKey.currentState!.validate()) {
      print("OLA");
    }
  }
}
