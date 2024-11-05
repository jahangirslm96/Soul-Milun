// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';

import '../../Utils/Controller/constant.dart';

class imageUpload extends StatefulWidget {
  final Map<String, dynamic> picture;
  final int index;
  final bool isSpecial;
  bool isDeleting;
  final void Function(int index) removeImage;
  final void Function(int index) profileImage;

   imageUpload(
      {super.key,
      required this.picture,
      required this.removeImage,
      required this.index,
      required this.profileImage,
      required this.isSpecial,
      required this.isDeleting});

  @override
  State<imageUpload> createState() => _imageUploadState();
}

class _imageUploadState extends State<imageUpload> {
  Map<String, dynamic> image = {};

  @override
  void initState() {
    // TODO: implement initState
    image = widget.picture;
    super.initState();
  }

  RemoveTheImage(SoulProfile_ViewModel soulProfile_ViewModel) {
    widget.removeImage(widget.index);
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () => {
            if (!widget.isSpecial) {widget.profileImage(widget.index)}
          },
          onLongPress: () => {},
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: image["isVerified"] != 2
                    ? ThemeColors().deleteFromThisDevice
                    : CustomTheme().errorColor,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Opacity(
              opacity: (image["isVerified"] == 1 && widget.isDeleting == false) ? 1 : (image["isVerified"] == 0 && widget.isDeleting == false) ? 0.5 : 0.1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: image["isUploaded"] == false
                    ? Image.file(
                        File(image["image"].path),
                        fit: BoxFit
                            .fill, // Ensure the image fully covers the container
                        width: 100,
                      )
                    : Image.network(
                        fileUrl + image["image"],
                        fit: BoxFit
                            .cover, // Ensure the image fully covers the container
                        width: 100,
                        height: 1000,
                      ),
              ),
            ),
          ),
        ),
        image["isVerified"] != 0
            ? Positioned(
                top: -12,
                right: -12,
                child: Consumer<SoulProfile_ViewModel>(builder: (context, soulProfile_ViewModel, child) => 
                   GestureDetector(
                    onTap: () => RemoveTheImage(soulProfile_ViewModel),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: CustomTheme().errorColor,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.close,
                          color: CustomTheme().errorColor,
                          size: 25,
                        ),
                      ),
                    ),
                  )
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                color: ThemeColors().buttonColor,
              )),
        widget.isSpecial
            ? Positioned(
                top: 12,
                left: 12,
                child: Consumer<SoulProfile_ViewModel>(builder: (context, soulProfile_ViewModel, child) => 
                  GestureDetector(
                    onTap: () => RemoveTheImage(soulProfile_ViewModel),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: CustomTheme().successColor,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.star,
                          color: ThemeColors().buttonColor,
                          size: 15,
                        ),
                      ),
                    ),
                  )
                ),
              )
            : Container()
      ],
    );
  }
}
