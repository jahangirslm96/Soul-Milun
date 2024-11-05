import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soul_milan/Components/Headers/CustomHeader5.dart';
import 'package:soul_milan/Components/Rows/ProfileInfoRow2.dart';
import 'package:soul_milan/Screens/Chat/Components/SeachInput.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/TourerInfo.model.dart';
import 'package:soul_milan/Utils/Controller/model/chat.model.dart';
import 'package:soul_milan/Utils/Controller/model/CustomMessenger.model.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/view_model/MessengerChat_ViewModel.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';

import '../../Components/NavigationBar/CustomBottomNavigationBar.dart';
import '../../Components/Rows/ChatRow.dart';
import '../../Components/Rows/CustomChatRow.dart';
import '../../Utils/Controller/model/customChatHead.model.dart';
import '../../Utils/ThemeColors.dart';

class ChatHeadScreen extends StatefulWidget {
  const ChatHeadScreen({Key? key}) : super(key: key);

  @override
  State<ChatHeadScreen> createState() => _ChatHeadScreenState();
}

class _ChatHeadScreenState extends State<ChatHeadScreen> {
  String searchText = "";
  bool isLoading = true;

  Map<String, List<dynamic>> menu = {
    "report": [
      Icons.report,
      ThemeColors().milanColor,
      "Report",
      ThemeColors().buttonColor,
    ],
    "block": [
      Icons.block,
      CustomTheme().errorColor,
      "Block",
      ThemeColors().buttonColor,
    ],
    "select": [
      Icons.block,
      CustomTheme().errorColor,
      "Select",
      ThemeColors().buttonColor,
    ],
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // channel.on("message-notifcation", (data) {
    //   customMessenger.sortChatHeads();
    //   setState(() {});
    // });

    // channel.on("message-seen", (data) {
    //   print("Your Message Seen: ${data}");
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    MessengerChat_ViewModel messengerChat_ViewModel = Provider.of<MessengerChat_ViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: messengerChat_ViewModel.loading == false
              ? Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 145),
                      child: messengerChat_ViewModel.customMessenger!.chatHeads!.isNotEmpty
                          ? Padding(
                              padding: mainBodyPadding2,
                              child: ScrollConfiguration(
                                behavior: const ScrollBehavior().copyWith(overscroll: false),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      messengerChat_ViewModel.customMessenger!.chatHeads?.length ?? 0,
                                  itemBuilder: (BuildContext context, int index) {
                                    // print(messengerChat_ViewModel.customMessenger!.chatHeads![index].chatId);
                                    return CustomChatRow(
                                      customChatHead:
                                          messengerChat_ViewModel.customMessenger!.chatHeads![index],
                                    );
                                    // return SizedBox();
                                  },
                                ),
                              ),
                            )
                          : Center(
                            child: Text(
                              "No Chats",
                              style: TextStyle(
                                color: ThemeColors().onBoardingHeadingColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: SearchInput(onChange: onSearchTextChanged),
                      ),
                    ),
                    Padding(
                      padding: mainBodyPadding2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 620),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.02,),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Get.width * 0.13,
                                          height: Get.width * 0.13,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: ThemeColors().soulColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: Consumer<SoulProfile_ViewModel>(builder: (context, value, child) =>
                                            ClipOval(
                                            child: Image.network(
                                              "$fileUrl${value.profileOverview!.profileData!.profilePicture}",
                                              scale: 3,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.020,
                                        ),
                                        Text(
                                          "Chats",
                                          style: TextStyle(
                                            color: ThemeColors()
                                                .onBoardingHeadingColor,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        splashRadius: 0.01,
                                        icon: Icon(
                                          Icons.edit,
                                          color: ThemeColors().buttonColor,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        child: PopupMenuButton(
                                          position: PopupMenuPosition.under,
                                          splashRadius: 0.01,
                                          itemBuilder: (BuildContext context) =>
                                              menu.keys
                                                  .map(
                                                    (e) => PopupMenuItem(
                                                      value: e,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            menu[e]![0],
                                                            color: menu[e]![1],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: Get
                                                                            .width *
                                                                        0.02),
                                                            child: Text(
                                                              menu[e]![2],
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    menu[e]![3],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    Padding(
                      padding: mainBodyPadding2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 620),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Get.width * 0.13,
                                          height: Get.width * 0.13,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: ThemeColors().soulColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: GestureDetector(
                                            onTap: () => Get.toNamed(RoutesClass
                                                .getProfileSettingsRoute()),
                                            // child: ClipOval(
                                            //   child: Image.network(
                                            //     // "$fileUrl${userProfile.profileImage}",
                                            //     "",
                                            //     scale: 3,
                                            //     fit: BoxFit.cover,
                                            //   ),
                                            // ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.020,
                                        ),
                                        Text(
                                          "Chats",
                                          style: TextStyle(
                                            color: ThemeColors()
                                                .onBoardingHeadingColor,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        splashRadius: 0.01,
                                        icon: Icon(
                                          Icons.edit,
                                          color: ThemeColors().buttonColor,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        child: PopupMenuButton(
                                          position: PopupMenuPosition.under,
                                          splashRadius: 0.01,
                                          itemBuilder: (BuildContext context) =>
                                              menu.keys
                                                  .map(
                                                    (e) => PopupMenuItem(
                                                      value: e,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            menu[e]![0],
                                                            color: menu[e]![1],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: Get
                                                                            .width *
                                                                        0.02),
                                                            child: Text(
                                                              menu[e]![2],
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    menu[e]![3],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: SearchInput(onChange: onSearchTextChanged),
                      ),
                    ),
                    Shimmer.fromColors(
                      period: const Duration(seconds: 2),
                      direction: ShimmerDirection.ltr,
                      baseColor: ThemeColors().dividerColor,
                      highlightColor: ThemeColors().deleteFromThisDevice,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 145),
                        child: Padding(
                          padding: mainBodyPadding2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Get.height * 0.005),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Container(
                                    width: Get.width * 0.15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ThemeColors().deleteFromThisDevice,
                                    ),
                                  ),
                                  title: Container(
                                    height: Get.height * 0.02,
                                    decoration: BoxDecoration(
                                      color: ThemeColors().deleteFromThisDevice,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  subtitle: Container(
                                    height: Get.height * 0.015,
                                    decoration: BoxDecoration(
                                      color: ThemeColors().deleteFromThisDevice,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    setState(() {
      // displayChats = chatList
      //     .where((element) => ((element['profile']['name']).toLowerCase())
      //         .contains((text).toLowerCase()))
      //     .toList();
      // chats.where((element) => element['profile']['name'].contains(text));
    });
  }
}
