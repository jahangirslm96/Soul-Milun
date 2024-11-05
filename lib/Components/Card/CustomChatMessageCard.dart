import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/TourerInfo.model.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';

import '../../Utils/Controller/model/TourPartners.model.dart';
import '../../Utils/Controller/model/customMessege.model.dart';
import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';
import '../AlertBox/DialogBox1.dart';
import '../VoiceMessageBar/VoiceMessageBarComponent.dart';

class CustomChatMessageCard extends StatefulWidget {
  final CustomMessege customMessege;
  final VoidCallback? onClick;
  const CustomChatMessageCard({
      super.key,
     required this.customMessege, CustomMessege? customMessage,
     this.onClick,
  });

  @override
  State<CustomChatMessageCard> createState() => _CustomChatMessageCardState();
}

class _CustomChatMessageCardState extends State<CustomChatMessageCard> {
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
    // setState(() {
    //     print("Tourer Info is loaded.");
    // });
  }

  LoadTourer() async {
    if(widget.customMessege.TOID == null){
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
                                          color: (chatStyle[widget.customMessege.senderId ==
                                                      soulProfile_ViewModel.profileVerification!.uID
                                                  ? 1
                                                  : 2][3]),
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                               widget.customMessege!.message.toString(),
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
                                                  child: Text(
                                                  widget.customMessege.timeDifference_(),
                                                  style: const TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.grey,
                                                  )),
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


    onTourerButtonClick(int value, SoulProfile_ViewModel soulProfile_ViewModel) async{
      TourerInfo temp = TourerInfo.fromJson(widget.customMessege.tourerInfo!.toJson());
      temp.bookStatus = value.toString();
      var response = await connector.post(connector.api.bookTour+"update",temp.toJson());
      print(response);
      if(response != null && response["success"] == true){
        widget.customMessege.tourerInfo = TourerInfo.fromJson(response["response"]);
      }
      sendMessage(widget.customMessege.tourerInfo!.toid!, currentChat.profile.uID, currentChat.chatId, soulProfile_ViewModel);
      setState(() {
        
      });
 
      widget.onClick!();
  }

   sendMessage(String TOID, receiverUID, chatID, SoulProfile_ViewModel soulProfile_ViewModel) {
    CustomMessege currentMessage = CustomMessege(
      CDID: "", //this will come from server response
      message: userProfile.name + " has "+widget.customMessege.tourerInfo!.bookStatus! +" your tourer request",
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
      currentChat.lastMessage = currentMessage;
      currentChat.messages?.add(currentMessage);
      currentChat.unread = true;
      currentChat.sortMessages(currentChat.messages);
    });
  }
}
