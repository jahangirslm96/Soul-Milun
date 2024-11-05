import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/Interaction.Model.dart';
import 'package:soul_milan/Utils/Controller/model/ProfileModel/ProfileOverview.model.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';
import 'package:soul_milan/view_model/SoulProfilesTimeline_ViewModel.dart';

import '../../Utils/Common/CommonFunction.dart';
import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';

class ProfileLayoutCard extends StatefulWidget {
  ProfileOverview? previewProfile;
  ProfileLayoutCard({
    super.key,
    this.previewProfile,
  });

  @override
  State<ProfileLayoutCard> createState() => _ProfileLayoutCardState();
}

class _ProfileLayoutCardState extends State<ProfileLayoutCard> {
  int interactionText = 0;
  bool showAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.9,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              fileUrl + widget.previewProfile!.profileData!.profilePicture!),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), // Adjust to match your design
                image: DecorationImage(
                  image: NetworkImage(fileUrl + widget.previewProfile!.profileData!.profilePicture!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.01,
              horizontal: Get.width * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedOpacity(
                  opacity: showAnimation ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: Get.height * 0.3),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: interactionText != 1 ? Colors.white : Colors.red,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(30),
                        child: Icon(
                          interactionText != 1
                              ? Icons.close
                              : Icons.favorite,
                          color: interactionText != 1
                              ? ThemeColors().milanColor
                              : Colors.white,
                          size: 70,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.04, vertical: Get.height * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: widget.previewProfile!.profileData!.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: CustomTheme().subDetails,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: ", ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                    CustomTheme().onBoardingHeadingFontSize,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.previewProfile!.profileData!.age.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                    CustomTheme().onBoardingHeadingFontSize,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${widget.previewProfile!.profileData!.city}, Pakistan",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.01,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.02,
                                vertical: Get.height * 0.008,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ThemeColors().roundedContainerColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.previewProfile!.profileData!.profession!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ThemeColors().buttonColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.02),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.02,
                                  vertical: Get.height * 0.008,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ThemeColors().roundedContainerColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.previewProfile!.profileData!.distance != null ?
                                      "${widget.previewProfile!.profileData!.distance} km"
                                          :  "${widget.previewProfile!.profileData!.match!}% Match",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ThemeColors().buttonColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Consumer<SoulProfilesTimeline_ViewModel>(builder: (context, value, child) =>
                            ElevatedButton(
                              onPressed: () {
                                interact(2,value);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Colors.grey;
                                    }
                                    return ThemeColors().milanColor;
                                  },
                                ),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(15)),
                                elevation: MaterialStateProperty.all<double>(5),
                                shadowColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                                shape: MaterialStateProperty.all<OutlinedBorder>(
                                  const CircleBorder(),
                                ),
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 27,
                              ),
                            )
                        ),
                        title: Consumer<SoulProfilesTimeline_ViewModel>(builder: (context, value, child) =>
                            CustomButton(
                              name: "See Full Profile",
                              onClick: () => nextScreen(value),
                              color: ThemeColors().soulColor,
                            ),
                        ),
                        trailing: Consumer<SoulProfilesTimeline_ViewModel>(builder: (context, value, child) =>
                            ElevatedButton(
                              onPressed: () {
                                interact(1, value);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return ThemeColors().soulColor;
                                    }
                                    return Colors.white;
                                  },
                                ),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(15)),
                                elevation: MaterialStateProperty.all<double>(5),
                                shadowColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                                shape: MaterialStateProperty.all<OutlinedBorder>(
                                  const CircleBorder(),
                                ),
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              ),
                            )
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
    );
  }

  void interact(int type, SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel) async {
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);

    setState(() {
      showAnimation = true;
      interactionText = type;
    });

    var body = {
      "senderUID": soulProfile_ViewModel.profileVerification!.uID,
      "receiverUID": widget.previewProfile!.profileData!.uId,
      "type": type.toString(),
      "username": soulProfile_ViewModel.profileOverview!.profileData!.name,
    };

    var response = await connector.post(intereaction, body);
    if (response["success"] != null && response["success"] == true) {

      CommonFunction commonFunction = CommonFunction();

      ProfileOverview pov = widget.previewProfile!;
      InteractWith interactWith = InteractWith(
        uId: pov.profileData!.uId,
        category: commonFunction.getInteractionType(type),
        name: pov.profileData!.name,
        profilePicture: pov.profileData!.profilePicture,
        profession: pov.profileData!.profession,
        city: pov.profileData!.city,
        age: pov.profileData!.age,
      );

      soulProfile_ViewModel.addInteraction(interactWith);
      removeProfile(soulProfilesTimeline_ViewModel);
    }

    // Hide the animation after the delay
    setState(() {
      showAnimation = false;
    });
  }

  void removeProfile(SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel) {
    bool isRemoved = false;
    isRemoved = soulProfilesTimeline_ViewModel.viewNextProfile(widget.previewProfile!);
    if(!isRemoved){
      Get.toNamed(RoutesClass.homeScreen);
    }
  }

  nextScreen(SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel) async {
    soulProfilesTimeline_ViewModel.setCurrentProfilePreview(widget.previewProfile!);
    Get.toNamed(RoutesClass.soulProfileScreen);
  }
}
