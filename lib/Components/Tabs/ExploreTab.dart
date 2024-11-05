import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/ProfileModel/ProfileOverview.model.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';

import '../../Utils/Constants.dart';
import '../../Utils/Controller/model/Interaction.Model.dart';
import '../../Utils/ThemeColors.dart';
import '../Card/ProfileCard.dart';

class ExploreTab extends StatefulWidget {
  final String details;
  final String image;
  final List<InteractWith> profiles;
  int tabIndex = -1;

  ExploreTab({
    super.key,
    required this.details,
    required this.profiles,
    required this.image,
    required this.tabIndex,
  });

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: tab1Padding,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.04,
                    child: Image.network(
                      assestUrl+widget.image,
                    ),
                  ),
                  SizedBox(width: Get.width * 0.02),
                  Text(
                    widget.details,
                    style: TextStyle(
                      fontSize: 20,
                      color: ThemeColors().buttonColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            widget.profiles.isEmpty ?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height:Get.height * 0.5,
                child: Image.asset(
                  "assets/images/no_data.png",
                ),
              ),
            ) : GridView.builder(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 20,
                childAspectRatio: 0.80,
              ),
              itemCount: widget.profiles.length,
              itemBuilder: (BuildContext context, int index) {
                return
                ProfileCard(
                    profile: ProfileOverview.fromJson(widget.profiles[index].toJson()),
                    tabIndex: widget.tabIndex);
              },
            ),
          ],
        ),
      ),
    );
  }
}
