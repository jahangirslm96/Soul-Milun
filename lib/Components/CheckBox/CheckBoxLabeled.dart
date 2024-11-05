import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/ThemeColors.dart';

class CheckBoxLabeled extends StatefulWidget {
  final bool? value;
  final String label;
  final ValueChanged<bool?>? onChanged;

  const CheckBoxLabeled({
    Key? key,
    this.value,
    this.onChanged,
    this.label = '',
  }) : super(key: key);

  @override
  State<CheckBoxLabeled> createState() => _CheckBoxLabeledState();
}

class _CheckBoxLabeledState extends State<CheckBoxLabeled> {
  var value = false;

  @override
  void initState() {
    super.initState();
    value = widget.value == true;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () => _onCheckedChanged(),
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        dense: true,
        leading: Theme(
          data: Theme.of(context).copyWith(
            checkboxTheme: CheckboxThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          child: Transform.scale(
            scale: 1.0,
            child: Checkbox(
              side: BorderSide(
                color: ThemeColors().containerOutlineColor,
                width: Get.width * 0.002,
              ),
              activeColor: ThemeColors().buttonColor,
              value: value,
              onChanged: (v) => _onCheckedChanged(),
            ),
          ),
        ),
        title: Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            color: ThemeColors().buttonColor,
          ),
        ),
      ),
    );
  }
  void _onCheckedChanged() {
    setState(() {
      value = !value;
    });
    if (widget.onChanged != null) {
      widget.onChanged!.call(value);
    }
  }
}

