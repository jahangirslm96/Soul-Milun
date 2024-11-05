import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Components/Rows/VerifiedTourRow.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';
import 'package:soul_milan/view_model/TourPartners_ViewModel.dart';

import '../../Components/DateTimePicker/CustomDatePickerVerifiedScreen.dart';
import '../../Components/DateTimePicker/CustomTimePickerVerifiedScreen.dart';
import '../../Components/Headers/CustomHeader.dart';
import '../../Components/Headers/CustomHeader2.dart';
import '../../Components/Headers/CustomHeader3.dart';
import '../../Components/Headers/CustomHeader4.dart';
import '../../Components/NavigationBar/CustomBottomNavigationBar.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';

import '../../Utils/Controller/model/customChatHead.model.dart';
import '../../Utils/Controller/model/customMessege.model.dart';
import '../../Utils/Controller/model/customMessenger.model.dart';
import '../../Utils/CustomTheme.dart';
import '../../Utils/Routes.dart';
import '../../view_model/MessengerChat_ViewModel.dart';
class VerifiedSoulsProfile extends StatefulWidget {
  const VerifiedSoulsProfile({Key? key}) : super(key: key);

  @override
  State<VerifiedSoulsProfile> createState() => _VerifiedSoulsProfileState();
}

class _VerifiedSoulsProfileState extends State<VerifiedSoulsProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 12),
                child:  const Column(
                  children: [
                    CustomHeader(
                      name: "Verified Tour Partner Profile",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: mainBodyPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerifiedTourRow(),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 15,
                              color: ThemeColors().onBoardingHeadingColor,
                            ),
                          ),
                          Text(
                            currentTourProfile.location ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: ThemeColors().onBoardingHeadingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Response Time",
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 15,
                              color: ThemeColors().onBoardingHeadingColor,
                            ),
                          ),
                          Text(
                           currentTourProfile.responseTime ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: ThemeColors().onBoardingHeadingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Minimum Service Time",
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 15,
                              color: ThemeColors().onBoardingHeadingColor,
                            ),
                          ),
                          Text(
                           currentTourProfile.service ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: ThemeColors().onBoardingHeadingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.03),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ThemeColors().containerColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Description"),
                            const SizedBox(height: 10,),
                            Text(
                              currentTourProfile.description ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Center(
                          child: Text.rich(
                            TextSpan(
                              text: currentTourProfile.rate ?? "",
                              style: TextStyle(
                                fontSize: 30,
                                color: ThemeColors().buttonColor,
                                fontWeight: FontWeight.bold,
                              ),
                              children:[
                                TextSpan(
                                  text: " PKR/Hr",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: ThemeColors().buttonColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Center(
                          child: Text(
                            "“I will show you more than places”",
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.02),
                      child: CustomButton(
                        name: "Let's Tour",
                        onClick: (){letsTourButtonFunction(context);},
                        color: ThemeColors().buttonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
  Future<void> letsTourButtonFunction(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: mainBodyPadding,
          child: Form(
            key: _formKey, // Assign the form key here
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Date & Time',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors().buttonColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.04),
                  child: CustomDatePickerVerifiedScreen(
                    controller: dateController,
                    label: "Date",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.04),
                  child: CustomTimePickerVerifiedScreen(
                    controller: timeController,
                    label: "Time",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a time';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.02),
                  child: Consumer<TourPartners_ViewModel>(builder: (context, value, child) => 
                     CustomButton(
                      name: "Proceed",
                      onClick: () => nextScreen(value),
                      color: ThemeColors().buttonColor,
                      isLoading: value.isCreatingTourReq,
                    )
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  nextScreen(TourPartners_ViewModel tourPartners_ViewModel) async {
    tourPartners_ViewModel.setTourLoading(true);
    
    if (_formKey.currentState!.validate()) {
            print("OLA");
            // return;


      SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
      // init tour request from here.

        //booking status
        // 0 = pending
        // 1 = accepted
        // 2 = completed
        // 3 = rejected
        // 4 = cancelled
      Map<String, dynamic> tourData = {
          "bookerUID" : soulProfile_ViewModel.profileOverview!.profileData!.uId,
          "bookerName": soulProfile_ViewModel.profileOverview!.profileData!.name,
          "earnerUID" : currentTourProfile.eRid,
          "bookingDate" : dateController.text,
          "bookingTime" : timeController.text,
          "bookingEnd" : timeController.text,
          "bookStatus" : "0",
          "receiverUID": currentTourProfile.uId
      };
      var response = await connector.post(connector.api.bookTour+"init", tourData);
      print(response);

      if(response != null && response["success"] == true){

        if(response["response"]["bookStatus"] == "pending"){
            Get.snackbar(
            backgroundColor: CustomTheme().successColor,
            colorText: Colors.white,
            "Tour Booked",
            response != null ? response["message"] : "",
            duration: const Duration(seconds: 2),
          );
          InitChat(response["response"]["TOID"], soulProfile_ViewModel);
        }else if(response["response"]["bookStatus"] == "accepted"){
            Get.snackbar(
                  "Error",
                  response["message"] ,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
        }
      }

    // Map<String, dynamic> body = {
    //   "chatID": currentChat.chatId,
    //   "receiverId": currentTourProfile.uId,
    //   "currentMessage": currentMessage
    // };
    //   print(dateController.text);
    //   print(timeController.text);
    }
  }


    void InitChat(String TOID, SoulProfile_ViewModel soulProfile_ViewModel) async {
    MessengerChat_ViewModel messengerChat_ViewModel = Provider.of<MessengerChat_ViewModel>(context, listen: false);
    var messengerData = {
      "sender": soulProfile_ViewModel.profileOverview!.profileData!.uId,
      "receiver": currentTourProfile.uId,
    };
    var response = await connector.post("chat/new", messengerData);
    print(response);
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
          .get("chat/${soulProfile_ViewModel.profileOverview!.profileData!.uId}/${chatID}/${currentTourProfile.uId}");
      
      if(messengerChat_ViewModel.isChatChatExist(currentTourProfile.uId!) == false){
        await messengerChat_ViewModel.loadChatBox(soulProfile_ViewModel.profileOverview!.profileData!.uId!,soulProfile_ViewModel.profileVerification!.getAccessToken());
      }
      //print(chatModelData["messenger"]["lastMessage"][0]["initChat"]);
      //currentChat = CustomChatHead.fromJson(chatModelData["messenger"]);
      if (messengerChat_ViewModel.customMessenger!.chatHeads!.isNotEmpty) {
        for (CustomChatHead ch in messengerChat_ViewModel.customMessenger!.chatHeads!) {
          if (ch.chatId == chatID) {
            // currentChat = ch;
            messengerChat_ViewModel.setCurrentChat(ch);
            if (chatModelData["messenger"]["lastMessage"][0]["initChat"] ==
                true) {
              CustomMessege cm = CustomMessege.fromJson(
                  chatModelData["messenger"]["lastMessage"][0]);
              messengerChat_ViewModel.currentChat!.messages = [];
              messengerChat_ViewModel.currentChat!.lastMessage = CustomMessege(
              CDID: "", //this will come from server response
              message: "You have a new booking from "+soulProfile_ViewModel.profileOverview!.profileData!.name!,
              messageCode: "tourer",
              senderId:soulProfile_ViewModel.profileOverview!.profileData!.uId!,
              time: DateTime.now(),
              receiveTime: null,
              status: 1,
              TOID: TOID //the id from response need to save here when tour request initiated.
              );

              sendMessage(TOID,currentTourProfile.uId,ch.chatId,soulProfile_ViewModel.profileOverview!.profileData!.name!,soulProfile_ViewModel.profileOverview!.profileData!.uId!, messengerChat_ViewModel);
              //currentChat.messages?.add(cm);
            } else {
              sendMessage(TOID,currentTourProfile.uId,ch.chatId, soulProfile_ViewModel.profileOverview!.profileData!.name!,soulProfile_ViewModel.profileOverview!.profileData!.uId!, messengerChat_ViewModel);
              print("already init chat");
            }
            break;
          }
        }
      }

      TourPartners_ViewModel tourPartners_ViewModel = Provider.of<TourPartners_ViewModel>(context, listen:  false);
      tourPartners_ViewModel.setTourLoading(false);
      Get.toNamed(RoutesClass.chattingScreen);
    } else {
      print("Not init");
    }
  }

  
  loadChat(String uID) async {
    var response =
        await connector.get(connector.api.chat + uID);
        print(response);
    if (response['success'] == true) {
      setState(() {
        customMessenger =
            CustomMessenger.fromJson({"messenger": response['messenger']});
      });
    } else {
      customMessenger = CustomMessenger(chatHeads: []);
    }
  }


   sendMessage(String TOID, receiverUID, chatID, String name, String uID, MessengerChat_ViewModel messengerChat_ViewModel) {
    CustomMessege currentMessage = CustomMessege(
      CDID: "", //this will come from server response
      message: "",
      messageCode: "tourer",
      senderId: uID,
      time: DateTime.now(),
      receiveTime: null,
      status: 1,
      TOID: TOID //the id from response need to save here when tour request initiated.
    );

    Map<String, dynamic> body = {
      "chatID": chatID,
      "receiverId": receiverUID,
      "currentMessage": currentMessage
    };
    //here we to modify tour send request

    //tourer accept or reject on its own

    if(messengerChat_ViewModel.isTourerRequestExist(messengerChat_ViewModel.currentChat!,TOID) == false){
      channel.emitWithAck("send-message", body, ack: (data) {
        body["status"] = data["status"];
        body["receiveTime"] = data["receiveTime"];
        
        currentMessage.CDID = data["currentMessage"]["CDID"];
        messengerChat_ViewModel.currentChat!.lastMessage = currentMessage;
        messengerChat_ViewModel.currentChat!.messages?.add(currentMessage);
        messengerChat_ViewModel.currentChat!.unread = true;
        messengerChat_ViewModel.currentChat!.sortMessages(messengerChat_ViewModel.currentChat!.messages);
        messengerChat_ViewModel.notify();
      });
    }
  }
}
