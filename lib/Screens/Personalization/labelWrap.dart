import 'package:flutter/material.dart';
import 'package:get/get.dart';

class labelWrap extends StatelessWidget {
  final String label;
  final Widget child;
  final bool isRequired;

  const labelWrap(
      {super.key,
      required this.label,
      required this.child,
      this.isRequired = false,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: Get.height * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              isRequired
                  ? Text(
                      "Optional",
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  : Container(),
            ],
          ),
        ),
        child
      ],
    );
  }
}
