import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/ThemeColors.dart';

class CustomTabForProfile extends StatefulWidget {
  final List<dynamic> array;
  final List<dynamic> similar;

  const CustomTabForProfile({
    super.key,
    required this.array,
    required this.similar,
  });

  @override
  State<CustomTabForProfile> createState() => _CustomTabForProfileState();
}

class _CustomTabForProfileState extends State<CustomTabForProfile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Wrap(
        spacing: 2.0,
        runSpacing: 0.0,
        // alignment: WrapAlignment.start,
        children: widget.array.map((word) {
          return Chip(
            label: Text(
              word,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: widget.similar.contains(word)
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: widget.similar.contains(word)
                    ? Colors.white
                    : ThemeColors().buttonColor,
              ),
            ),
            backgroundColor: widget.similar.contains(word)
                ? ThemeColors().buttonColor
                : ThemeColors().gridPartnerProfileColor,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          );
        }).toList(),
      ),
    );
  }
}
