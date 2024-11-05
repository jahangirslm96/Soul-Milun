import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soul_milan/repo/MessengerChatRepository.dart';
import 'package:soul_milan/repo/TourerProfileRepository.dart';

import '../Utils/Controller/model/CustomMessenger.model.dart';
import '../Utils/Controller/model/TourerInfo.model.dart';
import '../Utils/Controller/model/customChatHead.model.dart';
import '../Utils/Controller/model/customMessege.model.dart';
import 'package:just_audio/just_audio.dart';

class MessengerChat_ViewModel with ChangeNotifier{
  
  final repo_MessengerChat = MessengerChatRepository();
  final repo_TourerProfile = TourerProfileRepository();

  CustomMessenger? customMessenger;
  CustomChatHead? currentChat;

  bool _loading = false;
  bool get loading => _loading;

  bool hasNewMessage = false;

  AudioPlayer _audioPlayer = AudioPlayer();
  String audioVoiceMessageId = "";
  bool isAudioPlaying = false;
  bool isVoiceLoaded = false;
  Duration audioDuration = Duration(seconds: 0);
  double progressValue = 0.0;

  String _holdUid = "";
  String _holdToken = "";

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  notify(){
    notifyListeners();
  }

  //audio voice setup
  Future<void> loadFile(String voiceId, String messageId) async {
      print("downloading voice message "+voiceId);
      audioVoiceMessageId = messageId;
      final bytes = await readBytes(Uri.parse('http://103.236.135.219:5000/download/'+voiceId));

      Directory storageDirectory = await getApplicationDocumentsDirectory();
      final file = File('${storageDirectory.path}/voice_audio.mp3');

      await file.writeAsBytes(bytes);

      if (await file.exists()) {

        print("file exist now");
        await _loadAudio(file.path);
      }else{
        print('file not exist: '+voiceId);
      }
    }

      Future<void> _loadAudio(String url) async {
        // await _audioPlayer.setAsset('assets/testaudio.mp3');
        await _audioPlayer.setUrl(url);
        await _audioPlayer.load(); // Load the audio file

        isVoiceLoaded = true;
        audioDuration = _audioPlayer.duration!;
        isAudioPlaying = true;
        progressValue = 0.0;
        notify();
        await _playAudio();
      }

      Future<void> _playAudio() async {
        await _audioPlayer.play();
      }

      Future<void> pause() async {
        await _audioPlayer.pause();
         isAudioPlaying = false;
         notify();
      }

      
      Future<void> stop() async {
        isAudioPlaying = false;
        await _audioPlayer.stop();
        notify();
      }

      updateProgressBarValue(double value){
        progressValue = value;
        notify();
      }
  //=================

  Future<void> loadChatBox(String uID, String token) async {
    setLoading(true);

    _holdUid = uID;
    _holdToken = token;

    await repo_MessengerChat.LoadMessengerChats(uID, token).then((value){
      if (value['success'] == true) {
        // print(value['messenger'].length);
        // for(int i = 0; i < value['messenger'].length; i++){
        //   print(value['messenger'][i]);
        // }
        customMessenger = CustomMessenger.fromJson({"messenger": value['messenger']});
      } else {
        customMessenger = CustomMessenger(chatHeads: []);
        print("Empty, creating empty box");
      }
      setLoading(false);
    }).onError((error, stackTrace){
      print(error);
    });
  }

  addNewMessage(String chatID, Map<String, dynamic> newMessage) async {

    CustomChatHead? chatHead = _getChatHead(chatID);

    // for (CustomChatHead ch in customMessenger!.chatHeads!) {
    //   if (ch.chatId == chatID) {
    //     chatHead = ch;
    //     break;
    //   }
    // }

    if(chatHead != null){
      //chat head already exist, so we add message element into the current chat head.
      CustomMessege currentMessage = CustomMessege.fromJson(newMessage);
      chatHead.lastMessage = currentMessage;
      chatHead.messages?.add(currentMessage);
      chatHead.unread = true;
      chatHead.sortMessages(chatHead.messages);

      currentMessage = chatHead.lastMessage!;

      if(currentMessage.senderId != _holdUid){
        hasNewMessage = true;
      }
      notifyListeners();
    }else{
      //instantiate new chat head. (instead we loading whole chat box for now)
      await loadChatBox(_holdUid, _holdToken);     
    }
  }

  loadTourerRequest(CustomMessege currentMessage) async {
    if(currentMessage.TOID != null){
      setLoading(true);
      await repo_TourerProfile.LoadTourerRequestData(currentMessage.TOID!, _holdToken).then((value){
        if(value["success"] == true){
          currentMessage.tourerInfo = TourerInfo.fromJson(value["response"]);
        }
      });
    }
    setLoading(false);
  }

  seenMessage(String chatID){
    CustomChatHead? chatHead = _getChatHead(chatID);
    
    if(chatHead != null){
      chatHead.unread = false;
    }

    notifyListeners();
  }

  _getChatHead(String chatID){
    for (CustomChatHead ch in customMessenger!.chatHeads!) {
      if (ch.chatId == chatID) {
        return ch;
      }
    }
  }

  isChatChatExist(String uID){
    for (CustomChatHead ch in customMessenger!.chatHeads!) {
      if (ch.profile.uID == uID) {
        return true;
      }
    }

    return false;
  }

   isTourerRequestExist(CustomChatHead currentChat, String TOID){
    for (CustomMessege cm in currentChat.messages!) {
      if (cm.TOID != null && cm.TOID == TOID) {
        return true;
      }
    }
    return false;
  }

  setCurrentChat(CustomChatHead currentChat){
    this.currentChat = currentChat;
    notifyListeners();
  }
}