import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Components/AlertBox/EarnDialogBox.dart';
import 'package:soul_milan/Components/Rows/ProfileInfoRow2.dart';
import 'package:soul_milan/Components/Tabs/Tab1.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/PackageDetails.model.dart';
import 'package:soul_milan/view_model/MessengerChat_ViewModel.dart';
import 'package:soul_milan/view_model/SubscriptionPackage_ViewModel.dart';
import '../../Components/AlertBox/DialogBox1.dart';
import '../../Components/NavigationBar/CustomBottomNavigationBar.dart';
import '../../Components/Tabs/Tab2.dart';
import '../../Components/Tabs/Tab3.dart';
import '../../Utils/Controller/model/customChatHead.model.dart';
import '../../Utils/Controller/model/customMessege.model.dart';
import '../../Utils/Controller/model/customMessenger.model.dart';
import '../../Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../view_model/InstantChat_ViewModel.dart';
import '../../view_model/SoulProfile_ViewModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int selectedTab = 0;
  Color fontColor = Colors.white;
  List<Color> tabsColors = [
    ThemeColors().soulColor,
    Colors.green.shade600,
    Colors.blue.shade600,
  ];
  List<String> tabsText = ["Soul Members", "Earn USD/PKR", "Career"];
  late TabController _tabController;

  onSocket(SoulProfile_ViewModel soulProfile_ViewModel) {
    MessengerChat_ViewModel messengerChat_ViewModel = Provider.of<MessengerChat_ViewModel>(context, listen: false);
    channel = IO.io(
      connector.api.apiLink,
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );

    channel.on("message-notifcation", (data) {
      if (messengerChat_ViewModel.customMessenger!.chatHeads!.isNotEmpty) {
        // print("Notification: ${data}");
        FlutterRingtonePlayer.play(
          android: AndroidSounds.notification,
          ios: IosSounds.glass,
          volume: 1, // Android only - API >= 28
        );
        messengerChat_ViewModel.addNewMessage(data["chatID"], data["currentMessage"]);
        // updateUserAddress(
        //     data["chatID"], customMessenger.chatHeads!, data["currentMessage"],soulProfile_ViewModel);
      } else {
        messengerChat_ViewModel.loadChatBox(soulProfile_ViewModel.profileVerification!.uID!,soulProfile_ViewModel.profileVerification!.getAccessToken());
      }
    });
    channel.on("connect", (data) {
      channel.emitWithAck("active", {
        "userSocketId": channel.id.toString(),
        "userUID": soulProfile_ViewModel.profileVerification!.uID!
      }, ack: (data) {
       messengerChat_ViewModel.loadChatBox(soulProfile_ViewModel.profileVerification!.uID!,soulProfile_ViewModel.profileVerification!.getAccessToken());
        // print(data);
      });

      // channel.on("activeUsers", (data) {
      //   print(data);
      // });

      setState(() {
        channelID = channel.id.toString();
      });
    });

    channel.on("message-seen", (data) {
      messengerChat_ViewModel.seenMessage(data["chatId"]);
      // CustomChatHead? chatHead = null;

      // for (CustomChatHead ch in customMessenger.chatHeads!) {
      //   if (ch.chatId == data["chatId"]) {
      //     ch.unread = false;
      //     break;
      //   }
      // }
    });
  }

  void updateUserAddress(String chatID, List<CustomChatHead> chatHeads,
      Map<String, dynamic> json, SoulProfile_ViewModel soulProfile_ViewModel) {
    // Find the user in the list based on their id
    CustomChatHead? chatHead = null;

    for (CustomChatHead ch in chatHeads) {
      if (ch.chatId == chatID) {
        chatHead = ch;
        break;
      }
    }

    // chatHead = chatHeads.firstWhere((user) => user.chatId == chatID,
    //     orElse: () => chatHead!);

    if (chatHead != null) {
      // Update the address property of the user
      CustomMessege currentMessage = CustomMessege.fromJson(json);
      setState(() {
        // print('chat head before: ${chatHead?.lastMessage?.message}');
        chatHead?.lastMessage = currentMessage;
        chatHead?.messages?.add(currentMessage);
        chatHead?.unread = true;
        chatHead?.sortMessages(chatHead.messages);
        // print('chat head after: ${chatHead?.lastMessage?.message}');
      });
    } else {
      print('User with id $chatID not found.');
      loadChatData(soulProfile_ViewModel);
    }
  }

  @override
  void initState() {
    super.initState();
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
    channelID.isEmpty ? onSocket(soulProfile_ViewModel) : null;

    _tabController = TabController(length: 3, vsync: this);
    // if(isNewInstantChat){
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     InstantChats_ViewModel instantChats_ViewModel = Provider.of<InstantChats_ViewModel>(context);
    //     if(isNewInstantChat){
    //       isNewInstantChat = false;
    //       instantChats_ViewModel.AddInstantChat();
    //     }

    //     await showDialog<String>(
    //       context: context,
    //       builder: (BuildContext context) => DialogBox1(
    //         buttonText: "View Chats", 
    //         heading: "NEW INSTANT CHATS", 
    //         subHeading: "You have now ${instantChats_ViewModel.GetInstantChats?.chats} Instant chats.", 
    //         onTap: GotoProfileSettingScreen,
    //       )
    //     );
    //   });
    // }

    // loadChatData(soulProfile_ViewModel);

    if(!IsFCMLoaded){
      loadFCM(soulProfile_ViewModel);
    }
  }

  Future<void> loadChatData(SoulProfile_ViewModel soulProfile_ViewModel) async {
    await loadChat(soulProfile_ViewModel); // Assuming loadChat is an asynchronous function
    setState(() {
      print("Chat is loaded.");
    });
  }

  loadChat(SoulProfile_ViewModel soulProfile_ViewModel) async {
    var response =
        await connector.get(connector.api.chat + soulProfile_ViewModel.profileVerification!.uID!);
    if (response['success'] == true) {
      // print(response['messenger']);
      setState(() {
        customMessenger =
            CustomMessenger.fromJson({"messenger": response['messenger']});
      });
    } else {
      customMessenger = CustomMessenger(chatHeads: []);
    }
  }

  
  Future<void> loadFCM(SoulProfile_ViewModel soulProfile_ViewModel) async {
    await FCMToken(soulProfile_ViewModel); // Assuming loadChat is an asynchronous function
    setState(() {
      print("fcm is loaded/updated");
    });
  }

  FCMToken(SoulProfile_ViewModel soulProfile_ViewModel) async {
    Map<String,dynamic> FCMBody = {
      "uID": soulProfile_ViewModel.profileVerification!.uID!,
      "token": userFCMToken,
      "createdAt":DateTime.now().toIso8601String(),
      "updatedAt":DateTime.now().toIso8601String()
    };
    var FCMTokenData = await connector.post("notify/token",FCMBody);
    if (FCMTokenData["success"] != null &&
        FCMTokenData["success"] == true) {
      IsFCMLoaded = true;
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    InstantChats_ViewModel instantChats_ViewModel = Provider.of<InstantChats_ViewModel>(context);
    SubscriptionPackage_ViewModel subscriptionPackage_ViewModel = Provider.of<SubscriptionPackage_ViewModel>(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark, // status bar color
    ));
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: mainBodyPadding,
                child: const ProfileInfoRow2(),
              ),
              Expanded(
                child: Column(
                  children: 
                  [
                    TabBar(
                      onTap: (index) {
                        setState(() {
                          selectedTab = index;
                        });
                        if (index == 1) {
                          if(subscriptionPackage_ViewModel.currentPackageType == PackageType.NONE){
                            showDialog(
                                context: context,
                                builder: (context) => const EarnDialogBox(),
                              );
                          }
                          // else if(isNewInstantChat){
                          //   showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) => DialogBox1(
                          //     buttonText: "View Chats", 
                          //     heading: "NEW INSTANT CHATS", 
                          //     subHeading: "You have now ${instantChats_ViewModel.GetInstantChats?.chats} Instant chats.", 
                          //     onTap: GotoProfileSettingScreen,
                          //   )
                          // );
                          // }
                        }
                      },
                      controller: _tabController,
                      labelPadding: EdgeInsets.zero,
                      splashFactory: InkRipple.splashFactory,
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 12,
                        fontFamily: "Urbanist",
                      ),
                      unselectedLabelColor: Colors.white,
                      indicatorColor: tabsColors[selectedTab],
                      indicatorWeight: 3,
                      labelColor: Colors.white,
                      tabs: tabMenu(),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: const [
                          Tab1(),
                          Tab2(),
                          Tab3(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar:
              const CustomBottomNavigationBar(), // Add the bottomNavigationBarKey parameter here
        ),
      ),
    );
  }

  tabMenu() {
    List<Widget> temp = [];
    for (int i = 0; i < tabsColors.length; i++) {
      temp.add(
        Container(
          width: double.infinity,
          color: selectedTab == i ? Colors.white : tabsColors[i],
          child: Tab(
            child: Text(
              tabsText[i],
              style: TextStyle(
                color:
                    selectedTab != i ? Colors.white : tabsColors[selectedTab],
              ),
            ),
          ),
        ),
      );
    }
    return temp;
  }

  Future<void> _instantChatPopUp() async {
  print("Showing Instant Chat Popup"); // Add this line for debugging
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DialogBox1(
        heading: "Location Access Denied",
        subHeading: "It is mandatory to allow Location Permission.",
        buttonText: "OK",
        onTap: () {
          // Get.back();
        },
      );
    },
  );
}

  void GotoProfileSettingScreen() async {
    Get.toNamed(RoutesClass.profileSettingsScreen);
  }
  _showDialog(SubscriptionPackage_ViewModel subscriptionPackage_ViewModel, int index, InstantChats_ViewModel instantChats_ViewModel){
    if(subscriptionPackage_ViewModel.currentPackageType == PackageType.NONE){
      print("it null");
      return showDialog(
        context: context,
        builder: (context) => const EarnDialogBox(),
      );
    }
    
    if(isNewInstantChat && index == 0 ){
      print("its not null");
      return showDialog(
      context: context,
      builder: (BuildContext context) => DialogBox1(
        buttonText: "View Chats", 
        heading: "NEW INSTANT CHATS", 
        subHeading: "You have now ${instantChats_ViewModel.GetInstantChats?.chats} Instant chats.", 
        onTap: GotoProfileSettingScreen,
      )
    );
    }
  }
}
