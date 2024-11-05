import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/Routes.dart';

class DiscountCard extends StatelessWidget {
  final String type;
  final AssetImage image;

  const DiscountCard({
    super.key,
    required this.type,
    required this.image,
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: GestureDetector(
        onTap: (){},
        child: Container(
          height: Get.height * 0.15,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.srcOver),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, bottom: Get.height * 0.03,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  type,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
