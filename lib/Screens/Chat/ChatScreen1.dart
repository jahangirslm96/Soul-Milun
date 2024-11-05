import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soul_milan/Components/Headers/CustomHeader5.dart';
import 'package:soul_milan/Components/Rows/ProfileInfoRow2.dart';
import 'package:soul_milan/Screens/Chat/Components/SeachInput.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/chat.model.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/Routes.dart';

import '../../Components/NavigationBar/CustomBottomNavigationBar.dart';
import '../../Components/Rows/ChatRow.dart';
import '../../Utils/ThemeColors.dart';

class ChatScreen1 extends StatefulWidget {
  const ChatScreen1({Key? key}) : super(key: key);

  @override
  State<ChatScreen1> createState() => _ChatScreen1State();
}

class _ChatScreen1State extends State<ChatScreen1> {
  String searchText = "";
  bool isLoading = false;
  List<dynamic> displayChats = [];

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
    channel.on("new-message1", (data) {
      var index =
          chatList.indexWhere((element) => element.id == data["chatID"]);
      if (index != -1) {
        chatList[index].lastMessage = chatData.fromJson(data);
        chatList[index].chatDataList.insert(0, chatList[index].lastMessage);
      } else {
        chatList.insert(0, chatList[index]);
        chatList.removeAt(index + 1);
      }

      setState(() {});
    });

    chatList.isEmpty
        ? loadChat()
        : setState(() {
            print("chat is loaded already");
            isLoading = true;
            displayChats = chatList;
          });
  }

  loadChat() async {
    var response =
        await connector.get(connector.api.chat + userProfile.id.toString());

    print(response);
    if (response['success'] == true) {
      setState(() {
        chatList =
            response['messenger'].map((e) => ChatModel.fromJson(e)).toList();
        displayChats = chatList;
        isLoading = true;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: isLoading
              ? Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 145),
                      child: Padding(
                        padding: mainBodyPadding2,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: displayChats.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ChatRow(
                              chatHead: displayChats[index],
                            );
                          },
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
                              padding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.02),
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
                                          child: GestureDetector(
                                            onTap: () => Get.toNamed(RoutesClass
                                                .getProfileSettingsRoute()),
                                            child: ClipOval(
                                              child: Image.network(
                                                "$fileUrl${userProfile.profileImage}",
                                                scale: 3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.02),
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
                                          child: GestureDetector(
                                            onTap: () => Get.toNamed(RoutesClass
                                                .getProfileSettingsRoute()),
                                            child: ClipOval(
                                              child: Image.network(
                                                "$fileUrl${userProfile.profileImage}",
                                                scale: 3,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
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
      displayChats = chatList
          .where((element) => ((element['profile']['name']).toLowerCase())
              .contains((text).toLowerCase()))
          .toList();
      // chats.where((element) => element['profile']['name'].contains(text));
    });
  }
}
