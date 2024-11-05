import 'dart:io';
import 'dart:typed_data';

// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:soul_milan/Components/Card/CustomChatMessageCard.dart';
import 'package:soul_milan/Components/Card/TourerChatMessageCard.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/chat.model.dart';
import 'package:soul_milan/Utils/Controller/model/customMessege.model.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';

import '../../Components/Headers/CustomHeader.dart';
import '../../Components/VoiceMessageBar/VoiceMessageBarComponent.dart';
import '../../Utils/Constants.dart';
import '../../Utils/ThemeColors.dart';
import '../../view_model/MessengerChat_ViewModel.dart';

class CustomChattingScreen extends StatefulWidget {
  const CustomChattingScreen({Key? key}) : super(key: key);

  @override
  State<CustomChattingScreen> createState() => _CustomChattingScreenState();
}

class _CustomChattingScreenState extends State<CustomChattingScreen>
    with WidgetsBindingObserver {
  final FocusNode _textFieldFocusNode = FocusNode();
  late TextEditingController _textFieldController;
  bool isTapped = false;
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

   bool isLoading = false;
   String? recordFilePath; // Declare recordFilePath at the class level
   String? voiceMessageId;
   bool isSending = false;
   bool isPlayingMsg = false;
    int i = 0;
   Future<String> getFilePath() async {
      Directory storageDirectory = await getApplicationDocumentsDirectory();
      String sdPath = storageDirectory.path + "/record";
      var d = Directory(sdPath);
      if (!d.existsSync()) {
        d.createSync(recursive: true);
      }
      return sdPath + "/voiceMessage_${i++}.mp3";
    }
   void startRecord() async {
    final hasPermission = await Permission.microphone.request();

     if(hasPermission != PermissionStatus.granted){
      throw 'Microphone permission declined';
    }

     recordFilePath = await getFilePath();

      RecordMp3.instance.start(recordFilePath!, (type) {
        setState(() {});
      });
      
      print("Recording Start");
    setState(() {});
  }

  stopRecord(bool isCancelled) async {
    bool s = RecordMp3.instance.stop();
    print("Recording Stop");
    if(isCancelled == true){
      isVoiceCancelled = false;
      isSendingVoice = !isSendingVoice;

      setState(() {});
      return;
    }

    if (s) {
      setState(() {
        isSending = true;
      });

      await uploadAudio();

      setState(() {
        isPlayingMsg = false;
      });
    }
  }

  Future<void> uploadAudio() async {
    // Assuming recordFilePath is the path to the audio file
    File audioFile = File(recordFilePath!);
    Future.delayed(const Duration(milliseconds: 100));
    print(recordFilePath);
    var temp = [];
    Map<String, String> bodyData = {
    };
    temp.add(audioFile);
    // Verify that the file exists before attempting to upload
    if (await audioFile.exists()) {
      // Your upload logic here, assuming uploadImage_Data expects a File object
      print("uploading");

      try{
        var response = await connector.uploadImage_Data(
          "${uploadInfo}/audio/message",
          temp,
          bodyData,
          "audio",
          "POST",
        );

        print(response);
        String tempVoiceId = response["response"][0];
        tempVoiceId = tempVoiceId.replaceAll('.mp3', '');
        tempVoiceId = tempVoiceId.replaceAll('.', '');
        voiceMessageId = tempVoiceId;
        
        print(voiceMessageId);

      }catch(error){
        print("---> "+error.toString());
      }
    } else {
      print("File does not exist: $recordFilePath");
    }
  }

    Future _loadFile(String url) async {
      print("downloading");
      final bytes = await readBytes(Uri.parse('http://103.236.135.219:5000/download/b3622d02'));

      Directory storageDirectory = await getApplicationDocumentsDirectory();
      final file = File('${storageDirectory.path}/b3622d02.mp3');

      await file.writeAsBytes(bytes);

      if (await file.exists()) {

        print("file exist now");

        setState(() {
          recordFilePath = file.path;
          isPlayingMsg = true;
        });
        await _loadAndPlay();

        // play('https://filesamples.com/samples/audio/mp3/Symphony%20No.6%20(1st%20movement).mp3');
        // play('assets/testaudio.mp3');
        
        setState(() {
          isPlayingMsg = false;
        });
      }
    }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _textFieldController = TextEditingController();
     MessengerChat_ViewModel messengerChat_ViewModel = Provider.of<MessengerChat_ViewModel>(context, listen: false);
    setState(() {
      isLoading = messengerChat_ViewModel.currentChat!.messages == null ? false : true;
    });

    if (!isLoading) {
      loadChat(messengerChat_ViewModel);
    }

    channel.on("message-notifcation", (data) {
      // print(data);
      // setState(() {});
    });

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        print("paused");
        break;
      case AppLifecycleState.resumed:
        print("resumed");
        break;
      case AppLifecycleState.inactive:
        print("inactive");
        break;
      case AppLifecycleState.detached:
        print("detached");
        break;
      default:
        print("quit");
        break;
    }

    // This is called when the app goes into the background (minimized).
    // Implement your "onApplicationQuit" logic here.
  }

  loadChat(MessengerChat_ViewModel messengerChat_ViewModel) async {
    messengerChat_ViewModel.currentChat!.messages?.add(messengerChat_ViewModel.currentChat!.lastMessage!);
    var response = await connector.get("chat/messages/${messengerChat_ViewModel.currentChat!.chatId}");
    if (response["success"] != null && response["success"]) {
      messengerChat_ViewModel.currentChat!.updateMessageList({"messages": response["chatData"]});

      setState(() {
        isLoading = true;
      });
    } else {
      Map<String, dynamic> tempData = {"messages": null};
      messengerChat_ViewModel.currentChat!.updateMessageList({"messages": tempData["messages"]});
    }
  }

 @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context);
    MessengerChat_ViewModel messengerChat_ViewModel = Provider.of<MessengerChat_ViewModel>(context);
    return GestureDetector(
      // Clear focus when tapping outside the text field
      onTap: () => _textFieldFocusNode.unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.01,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                    right: Get.width * 0.05),
                                child: GestureDetector(
                                  onTapDown: (_) {
                                    setState(() {
                                      isTapped = true;
                                    });
                                  },
                                  onTapCancel: () {
                                    setState(() {
                                      isTapped = false;
                                    });
                                  },
                                  onTapUp: (_) {
                                    Future.delayed(const Duration(milliseconds: 35), () {
                                      setState(() {
                                        isTapped = false;
                                      });
                                    });
                                  },
                                  onTap: () {
                                    // Get.back();
                                    Get.toNamed(RoutesClass.chatHeadScreen);
                                  },
                                  child: ColorFiltered(
                                    colorFilter: isTapped
                                        ? ColorFilter.mode(
                                      Colors.black.withOpacity(0.5),
                                      BlendMode.srcATop)
                                        : const ColorFilter.mode(
                                      Colors.transparent,
                                      BlendMode.srcATop,
                                    ),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ThemeColors().buttonColor
                                          )
                                      ),
                                      child: ColorFiltered(
                                        colorFilter: isTapped
                                            ? ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.srcATop,
                                        )
                                            : const ColorFilter.mode(
                                          Colors.transparent,
                                          BlendMode.srcATop,
                                        ),
                                        child: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          size: 20,
                                          color: ThemeColors().buttonColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: Get.width * 0.1,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: CustomTheme().successColor,
                                      width: 0 //chatPreview.isOnline ? 3 : 0,
                                      ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      connector.api.fileUrl +
                                          messengerChat_ViewModel.currentChat!.profile.image,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            messengerChat_ViewModel.currentChat!.profile.name,
                            style: TextStyle(
                              fontSize: 18,
                              color: ThemeColors().buttonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            //chatPreview.isOnline ? "Online" : "Offline",
                            "Active - status here",
                            style: TextStyle(
                              fontSize: 12,
                              color: ThemeColors().buttonColor,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                splashRadius: 25,
                                icon: Icon(
                                  Icons.call,
                                  color: ThemeColors().buttonColor,
                                ),
                                onPressed: () {
                                  Get.toNamed(RoutesClass.voiceCallScreen);
                                },
                              ),
                              SizedBox(width: Get.width * 0.01),
                              IconButton(
                                splashRadius: 25,
                                icon: Icon(
                                  Icons.videocam_rounded,
                                  color: ThemeColors().buttonColor,
                                ),
                                onPressed: () {
                                  Get.toNamed(RoutesClass.videoCallScreen);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          ThemeColors().containerOutlineColor,
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        tileMode: TileMode.clamp,
                      ),
                    ),
                    child: Divider(
                      height: 0.5,
                      color: ThemeColors().containerOutlineColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: isLoading
                    ? Stack(children: <Widget>[
                        ListView.builder(
                          itemCount: messengerChat_ViewModel.currentChat!.messages?.length ?? 0,
                          shrinkWrap: true,
                          reverse: true,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          itemBuilder: (context, i) {
                            var message = messengerChat_ViewModel.currentChat!.messages?[i];
                            // List<String> voiceMessageData = message!.message.split('_');
                            if(message!.messageCode == "voice"){
                              return Padding(
                                  padding: EdgeInsets.only(
                                      right: chatStyle[message != null
                                          ? message.senderId == soulProfile_ViewModel.profileVerification!.uID
                                          ? 1
                                          : 2
                                          : 0][0],
                                      left: chatStyle[message != null
                                          ? message.senderId == soulProfile_ViewModel.profileVerification!.uID
                                          ? 1
                                          : 2
                                          : 0][1]
                                  ),
                                    child: VoiceMessageListTile(voiceId: message.message.split('_')[1].toString(), customMessege: message as CustomMessege,)
                                );
                            }
                            else if(message.messageCode == "tourer"){
                              return TourerChatMessageCard(customMessege: message as CustomMessege);
                            }
                            else if(message.messageCode == "text"){
                              return CustomChatMessageCard(customMessege: message as CustomMessege, onClick: message.TOID == null? null : RefreshScreen);
                            }
                          },
                        ),
                        isLoading
                            ? Container()
                            : Center(
                                child: CircularProgressIndicator(
                                  color: ThemeColors().buttonColor,
                                ),
                              ),
                      ])
                    : Container(),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: ThemeColors().dividerColor,
                      width: 1,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
                child: Row(
                  children: [
                    IconButton(
                      splashRadius: 25,
                      icon: Icon(
                        isSendingVoice == false ? Icons.image : Icons.close,
                        color: ThemeColors().buttonColor,
                      ),
                      onPressed: () {
                        if(isSendingVoice == true){
                          print("voice message cancelled");
                          stopRecord(true);
                        }
                      },
                    ),
                    Expanded(
                      child: TextFormField(
                        focusNode: _textFieldFocusNode,
                        controller: _textFieldController,
                        cursorColor: ThemeColors().labelTextColor,
                        onChanged: onChange,
                        style: TextStyle(
                          color: ThemeColors().onBoardingHeadingColor,
                          fontSize: 15,
                        ),
                        decoration: isSendingVoice == false ? InputDecoration(
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(
                              color: ThemeColors().enabledBorderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(
                              width: 2,
                              color: ThemeColors().labelTextColor,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.020,
                            horizontal: Get.width * 0.04,
                          ),
                          hintStyle: TextStyle(
                            color: ThemeColors().buttonColor,
                            fontSize: 15,
                          ),
                          hintText: "Message",
                          suffixIconConstraints:
                              const BoxConstraints(minWidth: 24, minHeight: 24),
                          suffixIcon: IconButton(
                            splashRadius: 20,
                            icon: Icon(
                              Icons.emoji_emotions_rounded,
                              color: ThemeColors().buttonColor,
                              size: 25,
                            ),
                            onPressed: () {
                            },
                          ),
                        )
                        :
                        InputDecoration(
                          enabled: false,
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(
                              color: ThemeColors().milanColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(
                              width: 2,
                              color: ThemeColors().labelTextColor,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.020,
                            horizontal: Get.width * 0.04,
                          ),
                          hintStyle: TextStyle(
                            color: ThemeColors().buttonColor,
                            fontSize: 15,
                          ),
                          hintText: "Recording...",
                          suffixIconConstraints:
                              const BoxConstraints(minWidth: 24, minHeight: 24),
                          suffixIcon: isSendingVoice == false ? IconButton(
                            splashRadius: 20,
                            icon: Icon(
                              Icons.emoji_emotions_rounded,
                              color: ThemeColors().buttonColor,
                              size: 25,
                            ),
                            onPressed: () {
                            },
                          ) : null,
                        )
                        ,
                      ),
                    ),
                    IconButton(
                      splashRadius: 25,
                      icon: Icon(
                        _textFieldController.text.isEmpty
                            ? Icons.mic
                            : Icons.send,
                        color: ThemeColors().buttonColor,
                        size: 30,
                      ),
                      onPressed: _textFieldController.text.isNotEmpty
                          ? () => sendMessage(soulProfile_ViewModel,messengerChat_ViewModel)
                          : () => SendVoice(soulProfile_ViewModel,messengerChat_ViewModel)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

    // final audioPlayer = AudioPlayer();

    //   Future<void> play(String url) async {
    //     await audioPlayer.play(AssetSource(url));
    //   }

    final _audioPlayer = AudioPlayer();
  Future<void> _loadAndPlay() async {
    // await _audioPlayer.setAsset('assets/testaudio.mp3');
    await _audioPlayer.setUrl(recordFilePath!);
    await _audioPlayer.play();
  }

  sendMessage(SoulProfile_ViewModel soulProfile_ViewModel, MessengerChat_ViewModel messengerChat_ViewModel) {
    // Map<String, dynamic> body = {
    //   "chatID": messengerChat_ViewModel.currentChat!.chatId,
    //   "message": _textFieldController.text,
    //   "senderId": userProfile.id,
    //   "receiverId": messengerChat_ViewModel.currentChat!.profile.uID,
    //   "time": DateTime.now().toIso8601String(),
    //   "receiveTime": null,
    //   "status": 1,
    // };

    CustomMessege currentMessage = CustomMessege(
        CDID: "", //this will come from server response
        message: _textFieldController.text,
        messageCode: "text",
        senderId: soulProfile_ViewModel.profileVerification!.uID!,
        time: DateTime.now(),
        receiveTime: null,
        status: 1,
        TOID: null);

    Map<String, dynamic> body = {
      "chatID": messengerChat_ViewModel.currentChat!.chatId,
      "receiverId": messengerChat_ViewModel.currentChat!.profile.uID,
      "currentMessage": currentMessage
    };
    _textFieldController.clear();

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
      // print(data);
      // setState(() {});
      messengerChat_ViewModel.notify();
      // messengerChat_ViewModel.addNewMessage(data["currentMessage"]["CDID"], currentMessage.toJson());
    });
  }

  RefreshScreen(){
    setState(() {
      
    });
  }
  onChange(value) {
    setState(() {});
  }


  bool isSendingVoice = false;
  bool isVoiceCancelled = false;

  SendVoice(SoulProfile_ViewModel soulProfile_ViewModel, MessengerChat_ViewModel messengerChat_ViewModel) async {

    isVoiceCancelled = false;
    isSendingVoice = !isSendingVoice;

    setState(() {});

    if(isSendingVoice){
      startRecord();
    }else{
      await stopRecord(false);
    }

    if(voiceMessageId == null && isSendingVoice == false){
       Get.snackbar(
        "Error",
        "too short voice message" ,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if(isSendingVoice == false && isVoiceCancelled == false){
          CustomMessege currentMessage = CustomMessege(
        CDID: "", //this will come from server response
        message: "voice_${voiceMessageId!}",
        messageCode: "voice",
        senderId: soulProfile_ViewModel.profileVerification!.uID!,
        time: DateTime.now(),
        receiveTime: null,
        status: 1,
        TOID: null);

        Map<String, dynamic> body = {
          "chatID": messengerChat_ViewModel.currentChat!.chatId,
          "receiverId": messengerChat_ViewModel.currentChat!.profile.uID,
          "currentMessage": currentMessage
        };
        _textFieldController.clear();

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
          voiceMessageId = null;
          messengerChat_ViewModel.notify();
        });
    }
  }
}
