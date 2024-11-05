import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';

import '../../Utils/Controller/constant.dart';
import '../../Utils/Controller/model/customMessege.model.dart';
import '../../Utils/ThemeColors.dart';
import '../../view_model/MessengerChat_ViewModel.dart';

class VoiceMessageListTile extends StatefulWidget {
  final CustomMessege customMessege;
  String voiceId = "";
  VoiceMessageListTile({
      super.key,
    required this.customMessege, CustomMessege? customMessage,
     required this.voiceId
  });
  @override
  _VoiceMessageListTileState createState() => _VoiceMessageListTileState();
}

class _VoiceMessageListTileState extends State<VoiceMessageListTile> with TickerProviderStateMixin {
  // bool isPlaying = false;
  double progressValue = 0.0;
  Duration duration = const Duration(seconds: 30);
  late Timer timer;
  late AnimationController controller;
  String? filePath;
  bool isVoiceLoaded = false;
  Duration audioDuration = Duration(seconds: 0);
  @override
  void initState() {
    super.initState();
    MessengerChat_ViewModel messengerChat_ViewModel = Provider.of<MessengerChat_ViewModel>(context, listen: false);
    progressValue = messengerChat_ViewModel.progressValue;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (messengerChat_ViewModel.isAudioPlaying && messengerChat_ViewModel.audioVoiceMessageId == widget.customMessege.CDID && messengerChat_ViewModel.progressValue < 1.0) {
        setState(() {
          progressValue += 1.0 / messengerChat_ViewModel.audioDuration.inSeconds;
          messengerChat_ViewModel.updateProgressBarValue(progressValue);
        });
      } else if (messengerChat_ViewModel.isAudioPlaying && messengerChat_ViewModel.audioVoiceMessageId == widget.customMessege.CDID) {
        // Playback completed, reset the play/pause button and progress bar
        progressValue = 0.0;
        messengerChat_ViewModel.updateProgressBarValue(0);
        messengerChat_ViewModel.stop();
        setState(() {
          // isPlaying = false;
          // progressValue = 0.0;
        });
        // Optionally, you can add logic here for handling completion actions
      }
    });

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Adjust animation duration as needed
    );
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

      Future<void> _loadFile(String voiceId) async {
      print("downloading voice message "+voiceId);
      final bytes = await readBytes(Uri.parse('http://103.236.135.219:5000/download/'+voiceId));

      Directory storageDirectory = await getApplicationDocumentsDirectory();
      final file = File('${storageDirectory.path}/voice_audio.mp3');

      await file.writeAsBytes(bytes);

      if (await file.exists()) {

        print("file exist now");

        // setState(() {
        //   isPlayingMsg = true;
        // });
        filePath = file.path;
        await _loadAudio(filePath!);

        // play('https://filesamples.com/samples/audio/mp3/Symphony%20No.6%20(1st%20movement).mp3');
        // play('assets/testaudio.mp3');
        
        // setState(() {
        //   isPlayingMsg = false;
        // });
      }else{
        print('file not exist: '+voiceId);
      }
    }

      final _audioPlayer = AudioPlayer();

      Future<void> _loadAudio(String url) async {
        // await _audioPlayer.setAsset('assets/testaudio.mp3');
        await _audioPlayer.setUrl(url);
        await _audioPlayer.load(); // Load the audio file
        isVoiceLoaded = true;
        audioDuration = _audioPlayer.duration!;
        // setState(() {
        //           isPlaying = !isPlaying;
        // });
        await _playAudio();
      }

      Future<void> _playAudio() async {
        await _audioPlayer.play();
      }

      Future<void> pause() async {
        await _audioPlayer.pause();
        //  setState(() {
        //           isPlaying = !isPlaying;
        // });
      }

      
      Future<void> stop() async {
        //  setState(() {
        //           isPlaying = !isPlaying;
        // });
        await _audioPlayer.stop();
        progressValue = 0;
      }

  @override
  Widget build(BuildContext context) {
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context, listen: false);
    MessengerChat_ViewModel messengerChat_ViewModel = Provider.of<MessengerChat_ViewModel>(context);
    progressValue = messengerChat_ViewModel.progressValue;
    return Container(
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * 0.03),
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.005),
      decoration: BoxDecoration(
        color: widget.customMessege.senderId == soulProfile_ViewModel.profileOverview!.profileData!.uId ? ThemeColors().labelTextColor : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: 
      ListTile(
        leading: GestureDetector(
          onTap: () {
            setState(() {
                messengerChat_ViewModel.stop();
                messengerChat_ViewModel.loadFile(widget.voiceId, widget.customMessege.CDID);
                // if(!isPlaying){
                //     _loadFile(widget.voiceId);
                // }else{ 
                //     stop(); 
                // }
                // if (isPlaying && progressValue >= 1.0) {
                //   // Reset when play is tapped after completion
                //   progressValue = 0.0;
                // }
              // if(isVoiceLoaded){
               
              // }else{
              //   _loadFile(widget.voiceId);
              // }
            });
          },
          child: Icon(
            messengerChat_ViewModel.isAudioPlaying && messengerChat_ViewModel.audioVoiceMessageId == widget.customMessege.CDID ? Icons.pause : Icons.play_arrow,
            size: 35,
            color: widget.customMessege.senderId == soulProfile_ViewModel.profileOverview!.profileData!.uId ? Colors.white : Colors.black,
          ),
        ),
        title: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget? child) {
                  return SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      // thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4.0 * controller.value), // Adjust the value as needed
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 8.0 * controller.value), // Adjust the value as needed
                      trackHeight: 5.0,
                    ),
                    child: Slider(
                      value: messengerChat_ViewModel.audioVoiceMessageId == widget.customMessege.CDID ? messengerChat_ViewModel.progressValue : 0,
                      min: 0,
                      max: 1.0,
                      onChanged: (value) {
                        messengerChat_ViewModel.updateProgressBarValue(value);
                        // setState(() {
                        //   progressValue = value;
                        // });
                      },
                      activeColor: ThemeColors().voiceCallBackgroundColor,
                      inactiveColor: widget.customMessege.senderId == soulProfile_ViewModel.profileOverview!.profileData!.uId ? Colors.grey[300] : Colors.grey[500],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
                width: 40,
              child: Text(
                messengerChat_ViewModel.isAudioPlaying && messengerChat_ViewModel.audioVoiceMessageId == widget.customMessege.CDID ? _formatDuration(messengerChat_ViewModel.audioDuration - Duration(seconds: (messengerChat_ViewModel.audioDuration.inSeconds * messengerChat_ViewModel.progressValue).toInt())) : "00:00",
                style: TextStyle(
                  color: widget.customMessege.senderId == soulProfile_ViewModel.profileOverview!.profileData!.uId ? Colors.white : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
        trailing: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                connector.api.fileUrl + (widget.customMessege.senderId == soulProfile_ViewModel.profileOverview!.profileData!.uId ?  soulProfile_ViewModel.profileOverview!.profileData!.profilePicture! : messengerChat_ViewModel.currentChat!.profile.image),
              ),
            ),
            Expanded(
              child: Text(
                  widget.customMessege.timeDifference_(),
                  style: TextStyle(
                    fontSize: 8,
                    color: widget.customMessege.senderId == soulProfile_ViewModel.profileOverview!.profileData!.uId ? Colors.grey[300] : Colors.grey[500],
                  ),
                ),
            )
          ],
        ),
      ),     
    );
  }

  String _formatDuration(Duration duration) {
    String minutes = (duration.inMinutes).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}