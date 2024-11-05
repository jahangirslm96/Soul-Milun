import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

import '../../Utils/Controller/constant.dart';
import '../../view_model/MessengerChat_ViewModel.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  bool hasNewMessage = false; // Track if there is a new message

  @override
  void initState() {
    super.initState();

    channel.on("message-notifcation", (data) {
      // setState(() {
      //   hasNewMessage = true; // Set to true when a new message arrives
      // });
    });
  }

  void _onItemTapped(int index) {
    MessengerChat_ViewModel messengerChat_ViewModel = Provider.of<MessengerChat_ViewModel>(context, listen:  false);
    if (index == 1) {
      // Check if the Chat item is tapped
      messengerChat_ViewModel.hasNewMessage = false;
      messengerChat_ViewModel.notify();
      // setState(() {
      //   hasNewMessage = false; // Mark the message as seen when Chat is opened
      // });
    }

    switch (index) {
      case 0:
        Get.toNamed(RoutesClass.homeScreen);
        break;
      case 1:
        // Get.toNamed(RoutesClass.chatScreen);
        Get.toNamed(RoutesClass.chatHeadScreen);
        break;
      case 2:
        Get.toNamed(RoutesClass.exploreScreen);
        break;
      case 3:
        Get.toNamed(RoutesClass.profileSettingsScreen);
        break;
      default:
        break;
    }
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    MessengerChat_ViewModel messengerChat_ViewModel = Provider.of<MessengerChat_ViewModel>(context);
    return BottomNavigationBar(
      backgroundColor: ThemeColors().soulColor,
      elevation: 10,
      iconSize: 30,
      useLegacyColorScheme: false,
      showSelectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Colors.white,
        shadows: [Shadow(color: Colors.white60, blurRadius: 7.0)],
      ),
      selectedIconTheme: const IconThemeData(
        color: Colors.white,
        shadows: [Shadow(color: Colors.white60, blurRadius: 7.0)],
      ),
      showUnselectedLabels: true,
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Colors.white24,
      ),
      unselectedIconTheme: const IconThemeData(
        size: 23.5,
        color: Colors.white24,
      ),
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.home_rounded,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Stack(
            // Use Stack to overlay the circular icon
            children: [
              const Icon(
                Icons.chat,
              ),
              if (messengerChat_ViewModel.hasNewMessage) // Display the circular icon if there is a new message
                const Positioned(
                    top: 0,
                    right: 0,
                    child: SizedBox(
                      height: 8,
                      width: 8,
                      child: Material(
                        elevation: 3.0, // Adjust the elevation value as needed
                        shape: CircleBorder(),
                        color: Colors.white,
                      ),
                    )),
            ],
          ),
          label: "Chat",
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.recommend_rounded,
          ),
          label: "Explore",
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: "Settings",
        ),
      ],
    );
  }
}
