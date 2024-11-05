import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';

import '../../../Utils/ThemeColors.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                color: ThemeColors().containerOutlineColor,
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
                    onTap: (){
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
