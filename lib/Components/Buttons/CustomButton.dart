import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

class CustomButton extends StatefulWidget {
  final String name;
  final VoidCallback onClick;
  final Color color;
  final Color onTapColor;
  final bool isLoading;
  final bool isDisable;

  const CustomButton({
    Key? key,
    required this.name,
    required this.onClick,
    required this.color,
    this.onTapColor = const Color(0xFF696E87),
    this.isLoading = false,
    this.isDisable = false,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.isLoading,
      child: GestureDetector(
        onTapDown: (_) {
          if (!widget.isLoading && !widget.isDisable) {
            setState(() {
              _isTapped = true;
            });
          }
        },
        onTapUp: (_) {
          setState(() {
            _isTapped = false;
          });
          widget.onClick();
        },
        onTapCancel: () {
          setState(() {
            _isTapped = false;
          });
        },
        child: Stack(
          children: [
            Opacity(
              opacity: widget.isLoading ? 0.0 : widget.isDisable ? 0.5 : 1.0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.0065),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _isTapped ? widget.onTapColor : widget.color,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: _isTapped ? widget.onTapColor : widget.color,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                    child: Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: _isTapped ? const Color(0xE6FFFFFF) : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.isLoading,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.0065),
                child: Center(
                  child: CircularProgressIndicator(
                    color: ThemeColors().soulColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
