import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/Constants.dart';
import '../../Utils/ThemeColors.dart';


class MultipleCheckBox extends StatefulWidget {
  final List<String> arrayNameOptions;
  final List<String> selectionArray;
  final ValueChanged<List<String>>? onChanged;
  final bool allowMultipleSelection;

  const MultipleCheckBox({
    Key? key,
    required this.arrayNameOptions,
    required this.selectionArray,
    this.onChanged,
    this.allowMultipleSelection = true,
  }) : super(key: key);

  @override
  State<MultipleCheckBox> createState() => _MultipleCheckBoxState();
}

class _MultipleCheckBoxState extends State<MultipleCheckBox> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.arrayNameOptions.length,
      itemBuilder: (context, index) {
        final selected = widget.arrayNameOptions[index];
        return Theme(
          data: Theme.of(context).copyWith(
            checkboxTheme: CheckboxThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          child: Transform.scale(
            scale: 1.0,
            child: CheckboxListTile(
              side: BorderSide(
                color: ThemeColors().containerOutlineColor,
                width: Get.width * 0.002,
              ),
              activeColor: ThemeColors().buttonColor,
              title: Text(
                selected,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: ThemeColors().buttonColor,
                ),
              ),
              value: widget.selectionArray.contains(selected),
              onChanged: (bool? value) {
                setState(() {
                  if (value != null) {
                    if (widget.allowMultipleSelection) {
                      if (index == widget.arrayNameOptions.length - 1) {
                        widget.selectionArray.clear();
                        if (value) {
                          widget.selectionArray.add(selected);
                        }
                      } else {
                        if (widget.selectionArray.contains(widget.arrayNameOptions.last)) {
                          widget.selectionArray.remove(widget.arrayNameOptions.last);
                        }
                        if (value) {
                          widget.selectionArray.add(selected);
                        } else if (widget.selectionArray.isNotEmpty) {
                          widget.selectionArray.remove(selected);
                        }
                      }
                    } else {
                      widget.selectionArray.clear();
                      if (value) {
                        widget.selectionArray.add(selected);
                      }
                    }
                    widget.onChanged?.call(widget.selectionArray);
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }
}








