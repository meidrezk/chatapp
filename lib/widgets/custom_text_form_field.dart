import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
  });

  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      onChanged: onChanged,
      cursorColor: Colors.white,
      validator: (value) {
        if (value!.isEmpty) {
          return " field can't be empty";
        }
      },
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconColor: Colors.white,
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
      ),
    );
  }
}
