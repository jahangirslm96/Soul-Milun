import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/Routes.dart';
import '../../Utils/ThemeColors.dart';

class HeaderWithBackIcon extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function()? onTap;

  const HeaderWithBackIcon({
    Key? key,
    required this.title,
    this.subtitle = "",
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: onTap ?? backScreen,
        child: SizedBox(
          width: 23,
          height: 23,
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: ThemeColors().iconColor,
          ),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: Get.height * .01),
        child: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  void backScreen() {
    Get.back();
  }
}
