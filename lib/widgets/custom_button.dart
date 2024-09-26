import 'package:flutter/material.dart';

import '../constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.buttonColor = Colors.white,
    this.borderRadius = 10.0,
    this.height = 60.0,
    this.width = double.infinity,
    this.padding,
    this.elevation,
    this.shape,
    this.textColor = Constant.kPrimaryColor,
  });

  final String text;
  final Function() onPressed;
  final TextStyle? textStyle;
  final Color buttonColor;
  final double borderRadius;
  final double height;
  final double width;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final OutlinedBorder? shape;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      height: height,
      width: width,
      child: MaterialButton(
        padding: padding,
        elevation: elevation,
        shape: shape,
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle ?? TextStyle(color: textColor,),
        ),
      ),
    );
  }
}
