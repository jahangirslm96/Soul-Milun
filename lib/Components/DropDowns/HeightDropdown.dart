import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';

import '../../Utils/ThemeColors.dart';

class HeightInput extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;

  const HeightInput({
    Key? key,
    required this.controller1,
    required this.controller2,
  });

  @override
  _HeightInputState createState() => _HeightInputState();
}

class _HeightInputState extends State<HeightInput> {
  List<int> feetOptions = List.generate(3, (index) => index + 4);
  List<int> inchesOptions = List.generate(12, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: DropdownButton2(
            value: int.tryParse(widget.controller1.text),
            onChanged: (newValue) {
              setState(() {
                widget.controller1.text = newValue.toString();
              });
            },
            isExpanded: true,
            items: feetOptions.map((int value) {
              return DropdownMenuItem(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 14,
                  ),
                  child: Text("$value'"),
                ),
              );
            }).toList(),
            underline: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ThemeColors().enabledBorderColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: Get.width * .05,
        ),
        Expanded(
          flex: 1,
          child: DropdownButton2(
            value: int.tryParse(widget.controller2.text),
            onChanged: (newValue) {
              setState(() {
                widget.controller2.text = newValue.toString();
              });
            },
            isExpanded: true,
            items: inchesOptions.map((int value) {
              return DropdownMenuItem(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 14,
                  ),
                  child: Text('$value"'),
                ),
              );
            }).toList(),
            underline: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ThemeColors().enabledBorderColor,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
