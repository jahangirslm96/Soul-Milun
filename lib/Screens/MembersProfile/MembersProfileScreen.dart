import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Components/Card/ProfileLayoutCard.dart';
import 'package:soul_milan/Components/Headers/CustomHeader2.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';
import 'package:soul_milan/view_model/SoulProfilesTimeline_ViewModel.dart';

import '../../Components/AlertBox/SubscriptionReminderAlertBox.dart';
import '../../Utils/Routes.dart';

class MembersProfileScreen extends StatefulWidget {
  const MembersProfileScreen({Key? key}) : super(key: key);

  @override
  State<MembersProfileScreen> createState() => _MembersProfileScreenState();
}

class _MembersProfileScreenState extends State<MembersProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ThemeColors().soulColor,
      statusBarIconBrightness: Brightness.dark, // status bar color
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors().soulColor,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: mainBodyPadding2,
                child: const Column(
                  children: [
                    CustomHeader2(),
                  ],
                ),
              ),
              Consumer<SoulProfilesTimeline_ViewModel>(builder: (context, value, child) => 
                ProfileLayoutCard(previewProfile: value.profileOverview),
              )
            ],
          ),
        ),
        // bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
