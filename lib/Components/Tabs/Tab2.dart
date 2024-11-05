import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Components/Blocks/TourBlock.dart';
import 'package:soul_milan/Utils/Controller/model/TourPartners.model.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';

import '../../Utils/Constants.dart';
import '../../Utils/Controller/constant.dart';
import 'package:soul_milan/view_model/TourPartners_ViewModel.dart';

class Tab2 extends StatefulWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  bool IsTourerLoaded = false;
  @override
  void initState() {
    super.initState();

    // loadTourerTimeLine();
  }

  
  Future<void> loadTourerTimeLine() async {
    IsTourerLoaded =  await loadTourers(); // Assuming loadChat is an asynchronous function
    setState(() {
      print(IsTourerLoaded ? "Tourers loaded." : "Tourers fail to load");
    });
  }

  Future<bool> loadTourers() async {
        SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
   var response =
        await connector.get(connector.api.earner + soulProfile_ViewModel.profileVerification!.uID!);
        print(response);
        if(response != null && response["success"]==true){
          tourPartners = response["response"] != null ? TourPartners.fromJson({"TourTimeline":response["response"]}) : TourPartners();
          // if(tourPartners.tourTimeline == null){
          //   print("false");
          // }else{
          //   print("true");
          // }
          return true;
        }else{
          return false;
        }
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: tab2Padding,
        child: Consumer<TourPartners_ViewModel>(builder: (context, tourPartners_ViewModel, child) => 
            Consumer<SoulProfile_ViewModel>(builder: (context, soulProfile_ViewModel, child) => 
              _buildUI(tourPartners_ViewModel,soulProfile_ViewModel),
            ),
        )  
      ),
    );
  }

  _buildUI(TourPartners_ViewModel tourPartners_ViewModel, SoulProfile_ViewModel soulProfile_ViewModel){
      return ConditionalBuilder(
            condition: tourPartners_ViewModel.isTimelineLoaded,
            builder: (BuildContext context) {
              return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Pick your tour around Soul",
                              style: TextStyle(
                                fontSize: 18,
                                color: ThemeColors().buttonColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Get.width * 0.04),
                              child: Image.asset(
                                "assets/icons/tour_icon.png",
                                scale: 25,
                              ),
                            ),
                          ],
                        ),
                        TourBlock(
                            title: "Male",
                            image: Image.asset(
                              "assets/icons/male_user_icon.png",
                              scale: 2.8,
                            ),
                            tourProfiles: tourPartners_ViewModel.getTourerTimeline("male"),
                            IsLoaded: tourPartners_ViewModel.isTimelineLoaded,
                            tourCode_: "male",
                        ),
                        TourBlock(
                          title: "Female",
                          image: Image.asset(
                            "assets/icons/female_user_icon.png",
                            scale: 2.5,
                          ),
                          tourProfiles: tourPartners_ViewModel.getTourerTimeline("female"),
                          IsLoaded: tourPartners_ViewModel.isTimelineLoaded,
                          tourCode_: "female",
                        ),
                      ],
                    );
            },
            fallback: (BuildContext context) {
              tourPartners_ViewModel.LoadTourerTimeline(soulProfile_ViewModel.profileVerification!.uID!,soulProfile_ViewModel.profileVerification!.getAccessToken());
              return  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Pick your tour around Soul",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: ThemeColors().buttonColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: Get.width * 0.04),
                                child: Image.asset(
                                  "assets/icons/tour_icon.png",
                                  scale: 25,
                                ),
                              ),
                            ],
                          ),
                          _buildTourWidget("Male"),
                          _buildTourWidget("Female")
                        ],
                      );
            },
          );
  }

      _buildTourWidget(String gender){
      return TourBlock(
                title: gender,
                image: gender.toLowerCase() == "male" ? Image.asset(
                  "assets/icons/male_user_icon.png",
                  scale: 2.8,
                ) : Image.asset(
                "assets/icons/female_user_icon.png",
                scale: 2.5,
              ),
                tourProfiles: null,
                IsLoaded: false,
                tourCode_: gender.toLowerCase(),
            );
    }
}
