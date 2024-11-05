import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

class AgeRangeSlider extends StatefulWidget {
  final int initialAge;
  final int maxAge;
  final Function(RangeValues) onChanged;
  RangeValues rangeValues;

  AgeRangeSlider({super.key,
    required this.initialAge,
    required this.maxAge,
    required this.onChanged,
    required this.rangeValues,
  });

  @override
  _AgeRangeSliderState createState() => _AgeRangeSliderState();
}

class _AgeRangeSliderState extends State<AgeRangeSlider> {
  bool isAnyAge = false;

  @override
  void initState() {
    super.initState();
    isAnyAge =
        widget.rangeValues.start == widget.initialAge.toDouble() &&
            widget.rangeValues.end == widget.maxAge.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: Get.height * 0.04),
          child: Text(
            isAnyAge
                ? "Age (any age)"
                : "Age (${widget.rangeValues.start.toInt()} - ${widget.rangeValues.end.toInt()})",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Get.height * 0.02),
          child: Row(
            children: [
              Text(widget.initialAge.toString()),
              Expanded(
                child: RangeSlider(
                  activeColor: ThemeColors().buttonColor,
                  inactiveColor: ThemeColors().gridPartnerProfileColor,
                  values: widget.rangeValues,
                  onChanged: (newRange) {
                    setState(() {
                      widget.rangeValues = newRange;
                      isAnyAge = newRange.start == widget.initialAge.toDouble() &&
                          newRange.end == widget.maxAge.toDouble();
                    });
                    widget.onChanged(newRange);
                  },
                  min: widget.initialAge.toDouble(),
                  max: widget.maxAge.toDouble(),
                  divisions: widget.maxAge - widget.initialAge,
                ),
              ),
              Text(widget.maxAge.toString()),
            ],
          ),
        ),
      ],
    );
  }
}
