// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Components/Headers/HeaderWithBackIcon.dart';
import 'package:soul_milan/Utils/Controller/api.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';
import 'package:permission_handler/permission_handler.dart';

class SelfieCameraScreen extends StatefulWidget {
  const SelfieCameraScreen({super.key});

  @override
  State<SelfieCameraScreen> createState() => _SelfieCameraScreenState();
}

class _SelfieCameraScreenState extends State<SelfieCameraScreen> {
  List<CameraDescription> _cameras = [];
  late CameraController controller;
  String selfieCount = "";
  bool isSelfieTaken = false;
  bool isCameraReady = false;
  late File imageFile;
  int selfieVerified = 0;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connector = Connector(storge.read('token'));
    startCamera();
  }

  void startCamera() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[1], ResolutionPreset.max);
    controller.initialize().then((_) {
      setState(() {
        isCameraReady = true;
      });
      if (!mounted) {
        return;
      }
    }).catchError((Object e) {
      //print(e);
      if (e is CameraException) {}
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*   isCamera(); */
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: isCameraReady
              ? Stack(children: [
                  SizedBox(
                      height: Get.height * 1, child: CameraPreview(controller)),
                  SizedBox(
                    height: Get.height * 0.9,
                    child: Column(
                      children: [
                        Padding(
                          padding: headerPadding,
                          child: const HeaderWithBackIcon(
                            title: "Capture Selfie",
                            subtitle:
                                "Position your face within our image outline",
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: mainBodyPadding,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.1,
                                  ),
                                  Image.asset(
                                    "assets/images/selfie_image_template_white.png",
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: switchCamera,
                                        child: CircleAvatar(
                                          radius: Get.width * 0.065,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.cameraswitch,
                                            color: ThemeColors().buttonColor,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: takeSeflie,
                                        child: CircleAvatar(
                                          radius: Get.width * 0.09,
                                          backgroundColor: Colors.grey,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: Get.width * 0.075,
                                            child: Text(selfieCount),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: Get.width * .09,
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ])
              : isSelfieTaken
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: Get.height * 0.001),
                        Padding(
                          padding: subscriptionBodyPadding,
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                text: "SOUL",
                                style: TextStyle(
                                  color: ThemeColors().soulColor,
                                  fontSize: CustomTheme()
                                      .soulMilanSubscriptionFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: " MILUN",
                                    style: TextStyle(
                                      color: ThemeColors().milanColor,
                                      fontSize: CustomTheme()
                                          .soulMilanSubscriptionFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: mainBodyPadding,
                          child: Column(children: [
                            Opacity(
                              opacity: selfieVerified == 1 ? 1 : 0.5,
                              child: Container(
                                height: Get.height * 0.7,
                                width: Get.width * 1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: selfieVerified == 1
                                        ? Colors.white
                                        : selfieVerified == 0
                                            ? ThemeColors().enabledBorderColor
                                            : CustomTheme().errorColor,
                                    width: 2,
                                  ),
                                ),
                                child:
                                    Image.file(imageFile, fit: BoxFit.contain),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: CustomButton(
                                      name: "Retake",
                                      onClick: retake,
                                      color:
                                          ThemeColors().onBoardingSubTextColor,
                                    )),
                                SizedBox(
                                  width: Get.width * 0.05,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CustomButton(
                                    isLoading: isLoading,
                                    name: "Proceed",
                                    onClick: () => selfieVerified == 1
                                        ? nextScreen()
                                        : () {},
                                    color: selfieVerified == 1
                                        ? ThemeColors().soulColor
                                        : ThemeColors().enabledBorderColor,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        )
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: ThemeColors().buttonColor,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          const Text("Loading Camera..."),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }

  isCamera() async {
    bool response = await Permission.camera.isDenied;

    if (response) {
      var response = await Permission.camera.request();
      if (response.isDenied) {
        Get.snackbar("Permission Denied",
            "Please allow camera permission to use this feature");
        // Get.offAndToNamed(RoutesClass.homeScreen);
      }
    }
    setState(() {});
  }

  switchCamera() {
    setState(() {
      isCameraReady = false;
    });

    if (controller.description == _cameras[0]) {
      controller = CameraController(_cameras[1], ResolutionPreset.max);
    } else {
      controller = CameraController(_cameras[0], ResolutionPreset.max);
    }

    controller.initialize().then((_) {
      setState(() {
        isCameraReady = true;
      });
    });
  }

  void nextScreen() async {
    setState(() {
      isLoading = true;
    });
    String path = "$verifyOtp/${storge.read("uid")}$selfieVerify";

    await connector
        .uploadImage_Data(path, [imageFile],
            {"uID": storge.read("uid").toString()}, "selfies","POST")
        .then((value) async {
      if (value != null) {
        if (value["isVerified"]) {
          LocationPermission permission = await Geolocator.checkPermission();

          var route = permission == LocationPermission.denied
              ? RoutesClass.enableLocationScreen
              : RoutesClass.logInPage;

          if(route == "/logIn"){
            Get.snackbar(
                  "Congratulation!",
                  "Welcome to Soul Milun - Login to proceed",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
          }
          Get.offAndToNamed(route);
          storge.write("screen", route);
        } else {
          popup("Selfie Not Verified", "Your selfie is not verified");
        }
      } else {
        popup("Selfie Not Verified", "The return is null");
      }
    });
  }

  void takeSeflie() async {
    imageFile = File((await controller.takePicture()).path);
    setState(() {
      isLoading = false;
      isCameraReady = false;
      isSelfieTaken = true;
    });

    verifySelife();
  }

  void verifySelife() async {
    List<Face> faces = await FaceDetector(options: FaceDetectorOptions())
        .processImage(InputImage.fromFilePath(imageFile.path));

    setState(() {
      selfieVerified = faces.length == 1 ? 1 : 2;
      Get.snackbar(
          "Selfie Verification",
          selfieVerified == 1
              ? "Your picture meet the Standards for the Verification"
              : "Face is not clearly visible ",
          backgroundColor: selfieVerified == 1
              ? CustomTheme().successColor
              : CustomTheme().errorColor,
          colorText: Colors.white);
    });
  }

  void retake() {
    setState(() {
      isSelfieTaken = false;
      isCameraReady = true;
      selfieVerified = 0;
    });
  }

  void popup(heading, message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05,
                vertical: Get.height * 0.01,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: "SOUL",
                        style: TextStyle(
                          color: ThemeColors().soulColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: " MILUN",
                            style: TextStyle(
                              color: ThemeColors().milanColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.02),
                    child: Center(
                      child: Text(
                        heading,
                        style: TextStyle(
                          color: ThemeColors().buttonColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.04),
                      child: Text(
                        message,
                        style: TextStyle(
                          color: ThemeColors().buttonColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.03),
                    child: CustomButton(
                      name: "OK",
                      onClick: () => Get.back(),
                      color: ThemeColors().buttonColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
