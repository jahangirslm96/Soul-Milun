import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/TourerInfo.model.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/view_model/MessengerChat_ViewModel.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';

import '../../Utils/Controller/model/TourPartners.model.dart';
import '../../Utils/Controller/model/customMessege.model.dart';
import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';
import '../AlertBox/DialogBox1.dart';
import '../VoiceMessageBar/VoiceMessageBarComponent.dart';

class TourerChatMessageCard extends StatefulWidget {
  final CustomMessege customMessege;
  const TourerChatMessageCard({
      super.key,
     required this.customMessege, CustomMessege? customMessage,
  });

  @override
  State<TourerChatMessageCard> createState() => _TourerChatMessageCardState();
}

class _TourerChatMessageCardState extends State<TourerChatMessageCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       Future.delayed(Duration(seconds: 1), () {
      loadTourerInfo(); // Replace this with the function you want to call.
    });
    // if(widget.customMessege.TOID != null && widget.customMessege.tourerInfo?.bookStatus == null){
    //   loadTourerInfo();
    // }
  }
  List<dynamic> chatStyle = [
    [
      0.0,
      0.0,
      Alignment.center,
      ThemeColors().soulColor,
      Colors.grey.shade200,
    ],
    [
      0.0,
      Get.width * .1,
      Alignment.centerRight,
      ThemeColors().labelTextColor,
      Colors.white,
    ],
    [
      Get.width * .1,
      0.0,
      Alignment.centerLeft,
      Colors.grey.shade200,
      Colors.black,
    ],
  ];


  Future<void> loadTourerInfo() async {
    await LoadTourer(); // Assuming loadChat is an asynchronous function
    setState(() {
        print("Tourer Info is loaded.");
    });
  }

  LoadTourer() async {
    if(widget.customMessege.TOID == null || widget.customMessege.TOID == ""){
      // if(tourerInfo.bookStatus == null){
      //   print(widget.customMessege.TOID);
      //   LoadTourerFromNotification();
      // }
      return;
    }else{
      var response =
          await connector.get(connector.api.bookTour + widget.customMessege.TOID!);
          print(response);
      if (response['success'] == true) {
        print("going to refresh now");
        setState(() {
         widget.customMessege.tourerInfo = TourerInfo.fromJson(response["response"]);
        });
        //widget.onClick!();
      }
    }
  }

  //   LoadTourerFromNotification() async {
  //     var response =
  //         await connector.get(connector.api.bookTour + widget.customMessege.TOID!);
  //         print(response);
  //     if (response['success'] == true) {
  //       print("going to refresh now");
  //       setState(() {
  //        tourerInfo = TourerInfo.fromJson(response["response"]);
  //       });
  //       widget.onClick!();
  //   }
  // }
@override
  Widget build(BuildContext context) {
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context);
    return _buildMessageWidget(soulProfile_ViewModel);
  }

  _buildMessageWidget(SoulProfile_ViewModel soulProfile_ViewModel){
    MessengerChat_ViewModel messengerChat_ViewModel = Provider.of<MessengerChat_ViewModel>(context);
    return  Padding(
                              padding: EdgeInsets.only(
                                right: chatStyle[widget.customMessege != null
                                    ? widget.customMessege.senderId == soulProfile_ViewModel.profileVerification!.uID
                                        ? 1
                                        : 2
                                    : 0][0],
                                left: chatStyle[widget.customMessege != null
                                    ? widget.customMessege.senderId == soulProfile_ViewModel.profileVerification!.uID
                                        ? 1
                                        : 2
                                    : 0][1],
                              ),
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: Get.height * 0.01,
                                      horizontal: Get.width * 0.03),
                                  child: Align(
                                      alignment: (chatStyle[widget.customMessege != null
                                          ? widget.customMessege.senderId == soulProfile_ViewModel.profileVerification!.uID
                                              ? 1
                                              : 2
                                          : 0][2]),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.lightGreen,
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              widget.customMessege.TOID != null ?
                                               widget.customMessege.senderId !=
                                                                soulProfile_ViewModel.profileVerification!.uID ? "You have a new tourer booking from ${messengerChat_ViewModel.currentChat!.profile.name}" : "You have sent tourer request"
                                                                : widget.customMessege.senderId != soulProfile_ViewModel.profileVerification!.uID ? "${messengerChat_ViewModel.currentChat!.profile.name} ${widget.customMessege.message} your tourer booking " : "You have ${widget.customMessege.message} The Request",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: (chatStyle[
                                                     widget.customMessege.senderId ==
                                                                soulProfile_ViewModel.profileVerification!.uID
                                                            ? 1
                                                            : 2][4]),
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                    width: Get.height * 0.02),
                                                Container(
                                                  child: widget.customMessege.senderId != soulProfile_ViewModel.profileVerification!.uID ? 
                                                Expanded(child:Column(children: [
                                                widget.customMessege.tourerInfo?.bookStatus == "pending" ? 
                                                Container(
                                                  child: Column(children: [
                                                     CustomButton(
                                                  name: "Accept",
                                                  color: ThemeColors().buttonColor,
                                                  onClick: () {
                                                    // Your logic here
                                                     onTourerButtonClick(1, soulProfile_ViewModel,messengerChat_ViewModel); // 1 = accepted
                                                  },
                                                ),
                                                 CustomButton(
                                                  name: "Decline",
                                                  color: ThemeColors().buttonColor,
                                                  onClick: () {
                                                    // Your logic here
                                                    onTourerButtonClick(3, soulProfile_ViewModel,messengerChat_ViewModel); // 3 = rejected
                                                  },
                                                )
                                                  ],)
                                    
                                                ) : Container(),
                                                 widget.customMessege.tourerInfo?.toid != null ? Column(
                                                  children: [
                                                    widget.customMessege.tourerInfo?.bookStatus != null ?
                                                    Text(
                                                    "Booking Date: "+widget.customMessege.tourerInfo!.bookingDate! + " Time: "+widget.customMessege.tourerInfo!.bookingTime!+" Status: "+widget.customMessege.tourerInfo!.bookStatus!,
                                                      style: const TextStyle(
                                                        fontSize: 8,
                                                        color: Colors.black,
                                                      ),
                                                    ): Text(
                                                    "Loading...",
                                                  style: const TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.black,
                                                  ))
                                                ],
                                                ) : Container(),
                                                ],
                                                )
                                                ) : 
                                                
                                                widget.customMessege.tourerInfo?.toid != null ? Column(
                                                  children: [
                                                    widget.customMessege.tourerInfo?.bookStatus != null ?
                                                    Text(
                                                    "Booking Date: "+widget.customMessege.tourerInfo!.bookingDate! + " Time: "+widget.customMessege.tourerInfo!.bookingTime!+" Status: "+widget.customMessege.tourerInfo!.bookStatus!,
                                                      style: const TextStyle(
                                                        fontSize: 8,
                                                        color: Colors.grey,
                                                      ),
                                                    ): Text(
                                                    "Loading...",
                                                  style: const TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.grey,
                                                  ))
                                                ],
                                                ) : Container()
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.01),
                                                // message.type == 1
                                                //     ? Icon(
                                                //         message.status == 1
                                                //             ? Icons.check_sharp
                                                //             : Icons.done_all_sharp,
                                                //         color: Colors.grey,
                                                //         size: 12,
                                                //       )
                                                //     : Container()
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))),
                            ); 
  }

  onTapProfile() {
    print("Route currently disabled");

    //Get.toNamed(RoutesClass.membersProfileScreen, arguments: title);
  }


    onTourerButtonClick(int value, SoulProfile_ViewModel soulProfile_ViewModel, MessengerChat_ViewModel messengerChat_ViewModel) async{
      TourerInfo temp = TourerInfo.fromJson(widget.customMessege.tourerInfo!.toJson());
      temp.bookStatus = value.toString();
      var response = await connector.post(connector.api.bookTour+"update",temp.toJson());
      print(response);
      if(response != null && response["success"] == true){
        widget.customMessege.tourerInfo = TourerInfo.fromJson(response["response"]);
      }
      sendMessage(
        widget.customMessege.tourerInfo!.toid!, 
        messengerChat_ViewModel.currentChat!.profile.uID, 
        messengerChat_ViewModel.currentChat!.chatId, 
        soulProfile_ViewModel,messengerChat_ViewModel
      );
      setState(() {
        
      });

      // widget.onClick!();
  }

   sendMessage(String TOID, receiverUID, chatID, SoulProfile_ViewModel soulProfile_ViewModel, MessengerChat_ViewModel messengerChat_ViewModel) {
    CustomMessege currentMessage = CustomMessege(
      CDID: "", //this will come from server response
      //message: soulProfile_ViewModel.profileOverview!.profileData!.name! + " has "+widget.customMessege.tourerInfo!.bookStatus! +" your tourer request",
      message: widget.customMessege.tourerInfo!.bookStatus!,
      messageCode: "tourer",
      senderId: soulProfile_ViewModel.profileVerification!.uID!,
      time: DateTime.now(),
      receiveTime: null,
      status: 1,
      TOID: null //the id from response need to save here when tour request initiated.
    );

    Map<String, dynamic> body = {
      "chatID": chatID,
      "receiverId": receiverUID,
      "currentMessage": currentMessage
    };
    //here we to modify tour send request

    //tourer accept or reject on its own

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
