import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';

import '../../../Utils/Controller/constant.dart';
import '../../../Utils/ThemeColors.dart';
import '../../../view_model/MessengerChat_ViewModel.dart';

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({Key? key}) : super(key: key);

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  late bool isVolumeTapped;
  late bool isVideoTapped;
  late bool isMicTapped;

  @override
  void initState() {
    super.initState();
    isVolumeTapped = false;
    isVideoTapped = false;
    isMicTapped = false;
  }

  @override
  Widget build(BuildContext context) {
    MessengerChat_ViewModel messengerChat_ViewModel = Provider.of<MessengerChat_ViewModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors().voiceCallBackgroundColor,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.1),
                child: Column(
                  children: [
                    Container(
                              width: Get.width * 0.35 ,
                              height: Get.height * 0.35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: CustomTheme().successColor,
                                  //width: chat.isOnline ? 3 : 0,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    connector.api.fileUrl + messengerChat_ViewModel.currentChat!.profile.image,
                                  ),
                                  
                                ),
                              ),
                            ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.04),
                      child: Text(
                        messengerChat_ViewModel.currentChat!.profile.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      "Ringing",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: ThemeColors().containerOutlineColor.withOpacity(0.5),
              ),
              padding: mainBodyPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isVolumeTapped = !isVolumeTapped;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !isVolumeTapped ? ThemeColors().onBoardingHeadingColor : Colors.white,
                      ),
                      child: Icon(
                        !isVolumeTapped ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                        size: 30,
                        color: !isVolumeTapped ? Colors.white :  Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isVideoTapped = !isVideoTapped;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !isVideoTapped ? ThemeColors().onBoardingHeadingColor : Colors.white,
                      ),
                      child: Icon(
                        !isVideoTapped ? Icons.videocam_rounded : Icons.videocam_off_rounded,
                        size: 30,
                        color: !isVideoTapped ? Colors.white :  Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isMicTapped = !isMicTapped;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !isMicTapped ? ThemeColors().onBoardingHeadingColor : Colors.white,
                      ),
                      child:  Icon(
                        !isMicTapped ? Icons.mic_rounded : Icons.mic_off_rounded,
                        size: 30,
                        color: !isMicTapped ? Colors.white :  Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomTheme().errorColor,
                      ),
                      child: const Icon(
                        Icons.call_end_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
