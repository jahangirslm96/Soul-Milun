import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:soul_milan/Components/Buttons/CircularIconButton.dart';
import 'package:soul_milan/Components/Tabs/CustomTabForProfile.dart';
import 'package:soul_milan/Utils/Common/CommonFunction.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/ProfileModel/ProfileOverview.model.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';
import 'package:soul_milan/view_model/MessengerChat_ViewModel.dart';
import 'package:soul_milan/view_model/SoulProfilesTimeline_ViewModel.dart';
import '../../Components/Headers/CustomHeader5.dart';
import '../../Utils/Controller/model/Interaction.Model.dart';
import '../../Utils/Controller/model/customChatHead.model.dart';
import '../../Utils/Controller/model/customMessege.model.dart';
import '../../Utils/Controller/model/customMessenger.model.dart';
import '../../Utils/CustomTheme.dart';
import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';
import 'package:soul_milan/Utils/Controller/model/chat.model.dart';
import 'package:soul_milan/view_model/InstantChat_ViewModel.dart';

import '../../view_model/SoulProfile_ViewModel.dart';

class SoulProfileScreen extends StatefulWidget {
  const SoulProfileScreen({Key? key}) : super(key: key);

  @override
  State<SoulProfileScreen> createState() => _SoulProfileScreenState();
}

class _SoulProfileScreenState extends State<SoulProfileScreen>
    with TickerProviderStateMixin {
  int selectedTab = 0;
  bool isReady = true;
  bool isFavourited = false;
  bool isTapped = true;
  late TabController _tabController;
  bool isCreatingChat = false;

  @override
  void initState() {
    super.initState();
    isCreatingChat = false;
  }

  // getDetails() async {
  //   var response = await connector.get(
  //       "${connector.api.uploadInfo}more/${previewProfile.id}/${userProfile.id}");
  //   if (response != null && response["success"]) {
  //     previewProfile = Profiles.fromJson(response["profileDetails"]);
  //     setState(() {
  //       isReady = true;
  //       _tabController = TabController(
  //           length: previewProfile.interest.keys.length + 1, vsync: this);
  //       userProfile.match = previewProfile.match;
  //     });
  //   }
  // }
  dummyFunction(value) {
  if (value != null) {
    // Your logic here
    print('Dummy function called with value: $value');
  } else {
    print('Dummy function called with null value');
  }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SoulProfilesTimeline_ViewModel>(builder: (context, soulProfilesTimeline_ViewModel, child) =>
        Scaffold(
           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
           body: SingleChildScrollView(
            child: _buildUI(soulProfilesTimeline_ViewModel),
           ),
           floatingActionButton:  Consumer<InstantChats_ViewModel>(builder: (context, instantChats_ViewModel, child) => 
               _buildFloatingButtons(instantChats_ViewModel, soulProfilesTimeline_ViewModel)
           ),
        )
      ),
    );
  }

  _buildUI(SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel){
          SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
          _tabController = TabController(length: soulProfilesTimeline_ViewModel.profileOverview.interest!.keys.length + 1, vsync: this);
    return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 3),
                      child: CustomHeader5(
                        name: "Soul Profile",
                        onTap: () {
                          interaction(3, soulProfilesTimeline_ViewModel);
                        },
                      ),
                    ),
                    Divider(
                      color: ThemeColors().containerOutlineColor,
                      thickness: Get.height *0.0005,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Get.height * 0.01,
                                horizontal: Get.width * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: soulProfilesTimeline_ViewModel.profileOverview.profileData!.name,
                                        style: TextStyle(
                                          color: ThemeColors().buttonColor,
                                          fontSize: CustomTheme().subDetails,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ", ",
                                            style: TextStyle(
                                              color: ThemeColors().buttonColor,
                                              fontSize: CustomTheme().onBoardingHeadingFontSize,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "${soulProfilesTimeline_ViewModel.profileOverview.profileData!.age}",
                                            style: TextStyle(
                                              color: ThemeColors().buttonColor,
                                              fontSize: CustomTheme().onBoardingHeadingFontSize,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      splashRadius: 20,
                                      onPressed: () {
                                        // Toggle the favorited state when the button is pressed
                                        if(soulProfilesTimeline_ViewModel.tabIndex != 5){
                                        setState(() {
                                          isFavourited = !isFavourited;
                                        });
                                        showFavouritedMessage(context, soulProfilesTimeline_ViewModel);
                                        }
                                      },
                                      icon: AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 300),
                                        transitionBuilder: (Widget child, Animation<double> animation) {
                                          return ScaleTransition(scale: animation, child: child);
                                        },
                                        child: soulProfilesTimeline_ViewModel.tabIndex == 5 || isFavourited
                                            ? Icon(
                                          Icons.star,
                                          key: Key("favorited"),
                                          size: 30,
                                          color: ThemeColors().goldColor,
                                        )
                                            : Icon(
                                          Icons.star_outline,
                                          key: Key("not_favorited"),
                                          size: 30,
                                          color: ThemeColors().buttonColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: Get.height * 0.001),
                                  child: Text(
                                    "${soulProfilesTimeline_ViewModel.profileOverview.profileData!.city}, Pakistan",
                                    style: TextStyle(
                                      color: ThemeColors().buttonColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          soulProfilesTimeline_ViewModel.profileOverview.profileData!.tagline != null
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(top: Get.height * 0.02),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: ThemeColors()
                                            .gridPartnerProfileColor,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.04,
                                            vertical: Get.height * 0.01,
                                          ),
                                          child: Text(
                                            soulProfilesTimeline_ViewModel.profileOverview.profileData!.tagline!,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: ThemeColors().buttonColor,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.normal,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.02),
                            child: SizedBox(
                              height: Get.height * .35,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: soulProfilesTimeline_ViewModel.profileOverview.profileData!.pictures!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        right: Get.width * 0.01),
                                    width: Get.width * .65,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: ThemeColors().dividerColor,
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            connector.api.fileUrl +
                                                soulProfilesTimeline_ViewModel.profileOverview.profileData!.pictures![index],
                                          ),
                                          fit: BoxFit.contain,
                                        )),
                                    padding: EdgeInsets.only(
                                        right: Get.width * 0.01),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                      child: Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            splashFactory: InkRipple.splashFactory,
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Urbanist",
                            ),
                            unselectedLabelColor: ThemeColors().buttonColor,
                            indicatorColor: ThemeColors().buttonColor,
                            labelColor: ThemeColors().buttonColor,
                            indicatorPadding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.08),
                            indicatorWeight: 2,
                            isScrollable: true,
                            tabs: [
                              const Tab(child: Text('About me')),
                              for (var i in soulProfilesTimeline_ViewModel.profileOverview.interest!.keys)
                                Tab(child: Text(i)),
                            ],
                          ),
                          _buildInterestTab(soulProfilesTimeline_ViewModel,soulProfile_ViewModel),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.05,
                          vertical: Get.height * 0.001),
                      child: Divider(
                        color: ThemeColors().gridPartnerProfileColor,
                        thickness: Get.height * 0.0005,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.05,
                        vertical: Get.height * .01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Bio",
                            style: TextStyle(
                              fontSize: CustomTheme().onBoardingHeadingFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.04,
                                right: Get.width * 0.04,
                                top: Get.height * 0.015),
                            child: Text(
                              soulProfilesTimeline_ViewModel.profileOverview.profileData!.bio!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.05,
                          vertical: Get.height * 0.001),
                      child: Divider(
                        color: ThemeColors().gridPartnerProfileColor,
                        thickness: Get.height * 0.0005,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.2,
                    ),

                    //Badges
                  ],
                );
  }

  _buildInterestTab(SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel, SoulProfile_ViewModel soulProfile_ViewModel){
    return SizedBox(
                            height: 200,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                CustomTabForProfile(
                                  array: soulProfilesTimeline_ViewModel.profileOverview.profileData!.about(),
                                  similar: soulProfile_ViewModel.profileOverview!.profileData!.about(),
                                ),
                                for (var i in soulProfilesTimeline_ViewModel.profileOverview.interest!.keys)
                                  CustomTabForProfile(
                                    array: soulProfilesTimeline_ViewModel.profileOverview.interest![i],
                                    similar: soulProfilesTimeline_ViewModel.profileOverview.similarInterest![i] ?? [],
                                  )
                              ],
                            ),
                          );
  }

  _buildFloatingButtons(InstantChats_ViewModel instantChats_ViewModel, SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel){
    return  AbsorbPointer(
          absorbing:  isCreatingChat,
          child: Stack(
          children: [
            Positioned(
              key: UniqueKey(),
              bottom: 16.0,
              right: Get.width * 0,
              child: CircularIconButton(
                onTap: () => interaction(2, soulProfilesTimeline_ViewModel),
                icon: Icons.close,
                color: ThemeColors().milanColor,
              ),
            ),
            Positioned(
               key: UniqueKey(),
              bottom: 16.0,
              left: Get.width * 0.68,
              child: CircularIconButton(
                onTap: () => interaction(1, soulProfilesTimeline_ViewModel),
                icon: Icons.favorite,
                color: ThemeColors().soulColor,
              ),
            ),
            Positioned(
               key: UniqueKey(),
              bottom: 16.0,
              right: Get.width * 0.75,
              child: CircularIconButton(
                onTap: () {
                  InitChat(instantChats_ViewModel, soulProfilesTimeline_ViewModel);
                },
                icon: Icons.chat,
                color: ThemeColors().labelTextColor,
                iconColor: Colors.white,
              ),
            ),
          ],
        )
    );
  }

   InitChat(InstantChats_ViewModel instantChats_ViewModel, SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel) async {
    setState(() {
      isCreatingChat = true;
    });

    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
    MessengerChat_ViewModel messengerChat_ViewModel = Provider.of<MessengerChat_ViewModel>(context, listen: false);
    if(instantChats_ViewModel.GetInstantChats!.chats! <= 0){
       Get.snackbar(
                  "No Instant Chats left.",
                  "Buy Instant Chats",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );

      setState(() {
        isCreatingChat = false;
      });
      return;
    }else{

      if(messengerChat_ViewModel.isChatChatExist(soulProfilesTimeline_ViewModel.profileOverview.profileData!.uId!) == false){
        await instantChats_ViewModel.DeductInstantChat(soulProfile_ViewModel.profileVerification!.uID!,soulProfile_ViewModel.profileVerification!.getAccessToken());
        Get.snackbar(
          "Instant Chat used",
          instantChats_ViewModel.GetInstantChats!.chats! > 0 ? "${instantChats_ViewModel.GetInstantChats!.chats} chats remaining." : "No Instant Chat Left.\nBuy Instant Chats.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    }


    var messengerData = {
      "sender": soulProfile_ViewModel.profileOverview!.profileData!.uId!,
      "receiver": soulProfilesTimeline_ViewModel.profileOverview.profileData!.uId,
    };
    var response = await connector.post("chat/new", messengerData);
    var messenger = response["messenger"];
    var chatID;

    if (messenger is Map) {
      // Handle the case where "messenger" is an object
      chatID = messenger["chatId"];
    } else if (messenger is List && messenger.isNotEmpty) {
      // Handle the case where "messenger" is an array
      chatID = messenger[0]["ChatID"] ?? messenger[0]["chatId"];
    }
    
    if (response != null && response["success"] == true) {
      var chatModelData = await connector
          .get("chat/${soulProfile_ViewModel.profileOverview!.profileData!.uId!}/$chatID/${soulProfilesTimeline_ViewModel.profileOverview.profileData!.uId}");
          print(chatModelData);
      
      if(messengerChat_ViewModel.isChatChatExist(soulProfilesTimeline_ViewModel.profileOverview.profileData!.uId!) == false){
        await messengerChat_ViewModel.loadChatBox(soulProfile_ViewModel.profileOverview!.profileData!.uId!, soulProfile_ViewModel.profileVerification!.getAccessToken());
      }
      
      // await loadChat(soulProfile_ViewModel.profileOverview!.profileData!.uId!);
      //print(chatModelData["messenger"]["lastMessage"][0]["initChat"]);
      //currentChat = CustomChatHead.fromJson(chatModelData["messenger"]);
      if (messengerChat_ViewModel.customMessenger!.chatHeads!.isNotEmpty) {
        for (CustomChatHead ch in messengerChat_ViewModel.customMessenger!.chatHeads!) {
          if (ch.chatId == chatID) {
            // currentChat = ch;
            messengerChat_ViewModel.setCurrentChat(ch);

            if (chatModelData["messenger"]["lastMessage"][0]["initChat"] ==
                true) {
              CustomMessege cm = CustomMessege.fromJson(chatModelData["messenger"]["lastMessage"][0]);
              messengerChat_ViewModel.currentChat!.messages = [];
              messengerChat_ViewModel.currentChat!.lastMessage = cm;
              messengerChat_ViewModel.currentChat!.lastMessage!.messageCode = "text";
              messengerChat_ViewModel.notify();
              //currentChat.messages?.add(cm);
            } else {
              print("already init chat");
            }
            break;
          }
        }
      }
      setState(() {
      isCreatingChat = false;
    });
      Get.toNamed(RoutesClass.chattingScreen);
    } else {
      print("Not init");
    }
  }

  CustomChatHead? findChatByChatID(String chatID) {
    return customMessenger.chatHeads
        ?.firstWhere((chat) => chat.chatId == chatID);
  }

  loadChat(String uID) async {
    var response =
        await connector.get(connector.api.chat + uID);
    if (response['success'] == true) {
      setState(() {
        customMessenger =
            CustomMessenger.fromJson({"messenger": response['messenger']});
      });
    } else {
      customMessenger = CustomMessenger(chatHeads: []);
    }
  }

  interaction(type, SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel) async {
     SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
     var body = {
      "senderUID": soulProfile_ViewModel.profileVerification!.uID,
      "receiverUID": soulProfilesTimeline_ViewModel.profileOverview.profileData!.uId,
      "type": type.toString(),
      "username": soulProfile_ViewModel.profileOverview!.profileData!.name
    };
    
     var response = await connector.post(intereaction, body);
    if (response["success"] != null && response["success"] == true) {

      CommonFunction commonFunction = CommonFunction();

      ProfileOverview pov = soulProfilesTimeline_ViewModel.profileOverview;
      InteractWith interactWith = InteractWith(uId: pov.profileData!.uId, category: commonFunction.getInteractionType(type), name: pov.profileData!.name, 
      profilePicture: pov.profileData!.profilePicture,
      profession: pov.profileData!.profession,
      city: pov.profileData!.city,
      age: pov.profileData!.age
      );
      soulProfile_ViewModel.addInteraction(interactWith);
      removeProfile(soulProfilesTimeline_ViewModel,soulProfilesTimeline_ViewModel.profileOverview);
    }

    // var response = await connector.post(connector.api.intereaction, body);
    // if (response["success"] != null && response["success"] == true) {
    //   int index = user[Get.arguments]!
    //       .indexWhere((element) => element.id == previewProfile.id);

    //   if (type != 5) {
    //     user[Get.arguments]?.removeAt(index);
    //     setState(() {
    //       previewProfile = user[Get.arguments]![index];
    //     });

    //     Get.back();
    //   } else {
    //     setState(() {
    //       isFavourited = !isFavourited;
    //     });
    //     isFavourited
    //         ? Get.snackbar(
    //             "Favourited",
    //             "Success",
    //             padding: EdgeInsets.symmetric(
    //                 vertical: Get.height * 0.015, horizontal: Get.width * 0),
    //             icon: Icon(
    //               Icons.star,
    //               color: ThemeColors().goldColor,
    //             ),
    //             titleText: const Text(
    //               "Favourited",
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 16.0,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             messageText: const Text(
    //               "Profile added to favorites!",
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 14.0,
    //               ),
    //             ),
    //             borderRadius: 10.0,
    //             backgroundColor: ThemeColors().buttonColor,
    //             duration: const Duration(seconds: 2),
    //             animationDuration: const Duration(milliseconds: 300),
    //           )
    //         : null;
    //   }

    //   if (type != 5) {
    //     int index = user[Get.arguments]!
    //         .indexWhere((element) => element.id == previewProfile.id);
    //     user[Get.arguments]?.removeAt(index);

    //     setState(() {
    //       previewProfile = user[Get.arguments]![index];
    //     });

    //     Get.back();
    //   }
    // }
  }
  void removeProfile(SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel, ProfileOverview profileOverview) {
    bool isRemoved = false;
    isRemoved = soulProfilesTimeline_ViewModel.viewNextProfile(profileOverview);

    if(profileOverview.profileData!.profileType != "explore"){
      if(!isRemoved){
          Get.toNamed(RoutesClass.homeScreen);
      }
      else{
        Get.toNamed(RoutesClass.membersProfileScreen);
      }
    }else{
      Get.back();
    }
  }
  void showFavouritedMessage(BuildContext context, SoulProfilesTimeline_ViewModel soulProfilesTimeline_ViewModel) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFavourited ? 'Favorited!' : 'Removed from favorites.'),
        duration: const Duration(seconds: 1),
      ),
    );

    await Future.delayed(Duration(milliseconds: 300));
    interaction(5, soulProfilesTimeline_ViewModel);
  }
}
