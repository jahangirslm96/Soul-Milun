import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/ThemeColors.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const Header({
    super.key,
    required this.title,
    this.subtitle = "",
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: null,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
  void backScreen() {
    Get.back();
  }
}
