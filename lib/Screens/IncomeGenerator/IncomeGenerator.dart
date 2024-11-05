import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/EarnerProfile.model.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';

import '../../Components/Buttons/CustomButton.dart';
import '../../Components/DropDowns/CustomDropDown1.dart';
import '../../Components/Headers/HeaderWithBackIcon.dart';
import '../../Components/Textfields/CustomTextField4.dart';
import '../../Components/Textfields/TextBoxField.dart';
import '../../Utils/Constants.dart';
import '../../Utils/Controller/model/Cities.model.dart';
import '../../Utils/ThemeColors.dart';

class IncomeGenerator extends StatefulWidget {
  const IncomeGenerator({Key? key}) : super(key: key);

  @override
  State<IncomeGenerator> createState() => _IncomeGeneratorState();
}

class _IncomeGeneratorState extends State<IncomeGenerator> {
  final _formKey = GlobalKey<FormState>();

  Map<String, CityData> dropDownCities = {};

  CityData? selectedCity;

  TextEditingController rateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isUpdating = false;

@override
  void initState() {
    // TODO: implement initState

    for (var city in cities.cityList) {
      dropDownCities[city.name] = CityData(
          cid: city.cid, nid: city.nid, name: city.name, status: city.status);
    }
    earnerProfile = EarnerProfile();
    loadEarnerDataProfile();
    super.initState();
  }

  Future<void> loadEarnerDataProfile() async {
    await loadEarner(); // Assuming loadChat is an asynchronous function
    setState(() {
      print("Earner Data is loaded.");
    });
  }

  loadEarner() async {
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
    var response =
        await connector.get(connector.api.earner + "data/" + soulProfile_ViewModel.profileOverview!.profileData!.uId!);
    if (response['success'] == true) {
      // print(response['messenger']);
     earnerProfile = EarnerProfile.fromJson({"EarnerData":response["response"]});
    }

    selectedCity = findCity(earnerProfile.earnerData?.city ?? "Karachi");

      descriptionController.text = earnerProfile.earnerData?.description ?? "";
      rateController.text = earnerProfile.earnerData?.ratePerHour ?? "";

      minServiceTime = minServiceTimeItems[_indexOf(minServiceTimeItems, earnerProfile.earnerData?.minimumServiceTime ?? "1 Hour")];
      responseTime = responseTimeItems[_indexOf(responseTimeItems, earnerProfile.earnerData?.responseTime ?? "1 - 2 Hours")];

      setState(() {
        
      });
  }

  CityData? findCity(String defaultName) {
    try {
      return dropDownCities.values
          .firstWhere((city) => city.name == defaultName || city.cid == defaultName);
    } catch (e) {
      return null;
    }
  }

   int _indexOf(List<String> arrayToSearch, String element) {
    return arrayToSearch.indexOf(element);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: headerPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Expanded(
                        child: HeaderWithBackIcon(
                          title: "Income Generator",
                          subtitle: "Register yourself as a Tour Guide.",
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
                      Text(
                        "This’ll help us to verify you according to our policy.",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.04),
                        child: Text(
                          "Rate Per Hour",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      CustomTextfield4(
                        controller: rateController,
                        label: "Rate",
                        inputType: TextInputType.number,
                        hint: "Enter Rate",
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.04),
                        child: Text(
                          "Location",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      CustomDropDown1(
                        product: location,
                        productItems: locationItems,
                        onChanged: dropDownValueLocation,
                        label: "Location",
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.04),
                        child: Text(
                          "City",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      DropdownButtonFormField<CityData>(
                        value: selectedCity,
                        items: dropDownCities.values.map((city) {
                          return DropdownMenuItem<CityData>(
                              value: city, child: Text(city.name));
                        }).toList(),
                        onChanged: (CityData? newValue) {
                          setState(() {
                            selectedCity = newValue;
                            mainFilter.cityDataFilter = newValue!;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.04),
                        child: Text(
                          "Response Time",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      CustomDropDown1(
                        product: responseTime,
                        productItems: responseTimeItems,
                        onChanged: dropDownValueResponseTime,
                        label: "Response Time",
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.04),
                        child: Text(
                          "Minimum Service Time",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      CustomDropDown1(
                        product: minServiceTime,
                        productItems: minServiceTimeItems,
                        onChanged: dropDownValueMinServiceTime,
                        label: "Minimum Service Time",
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.02),
                        child: Text(
                          "Description",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.02),
                        child: TextBoxField(
                            label: "Description",
                            controller: descriptionController,
                            hint: "Add Description here ..."),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.06),
                        child: CustomButton(
                          // isDisabled: false,
                          name: earnerProfile.earnerData?.erid == null || earnerProfile.earnerData?.erid == "" ? "Register" : "Update",
                          onClick: nextScreen,
                          color: ThemeColors().buttonColor,
                          isLoading: isUpdating,
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

  nextScreen() async {
    if (_formKey.currentState!.validate()) {
      SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
      Map<String, dynamic> earnerBody = {
        "uID": soulProfile_ViewModel.profileOverview!.profileData!.uId!,
        "ratePerHour": rateController.text,
        "location": selectedCity?.cid,
        "city": selectedCity?.cid,
        "responseTime": responseTime,
        "minimumServiceTime": minServiceTime,
        "description": descriptionController.text,
    };
    setState(() {
      isUpdating = true;
    });
      var response = await connector.post("${connector.api.earner}add", earnerBody);


      if(response != null && response["success"] == true){
        earnerProfile = EarnerProfile.fromJson({"EarnerData":response["response"]});
        Get.snackbar(
                  "Success",
                  response['message'],
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
                setState(() {
                  
                });
               
      }else{
        Get.snackbar(
                  "Error",
                  "Something went wrong...",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
      }

      setState(() {
        isUpdating = false;
      });
    }
  }

  void dropDownValueCity(value) {
    setState(() {
      city2 = (value) as String;
    });
  }

  void dropDownValueLocation(value) {
    setState(() {
      location = (value) as String;
    });
  }

  void dropDownValueResponseTime(value) {
    setState(() {
      responseTime = (value) as String;
    });
  }

  void dropDownValueMinServiceTime(value) {
    setState(() {
      minServiceTime = (value) as String;
    });
  }
}
