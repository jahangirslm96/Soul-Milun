import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

class CustomRadioButtons extends StatefulWidget {
  final List<String> option;
  final Function(int) onTap;
  final int selection;

  const CustomRadioButtons({
    super.key,
    required this.onTap,
    required this.option,
    required this.selection,
  });

  @override
  State<CustomRadioButtons> createState() => _CustomRadioButtonsState();
}

class _CustomRadioButtonsState extends State<CustomRadioButtons> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          unselectedWidgetColor: ThemeColors().buttonColor,
        ),
        child: Container(
          padding: EdgeInsets.only(top: Get.height * 0.02),
          height: Get.height * 0.05,
          child: ListView.builder(
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => widget.onTap(index),
              child: Padding(
                padding: EdgeInsets.only(right: Get.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.scale(
                      scale: 1.0,
                      child: Radio(
                        activeColor: ThemeColors().buttonColor,
                        groupValue: widget.option[widget.selection],
                        value: widget.option[index],
                        onChanged: (value) => widget.onTap(index),
                      ),
                    ),
                    Text(
                      widget.option[index],
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: ThemeColors().buttonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            itemCount: widget.option.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
          ),
        ));
  }
}
