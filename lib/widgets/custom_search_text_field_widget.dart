import 'package:flutter/material.dart';

import '../core/color.dart';

class CustomSearchTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onPressed;
  final TextInputType? keyboardType;

  const CustomSearchTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onPressed,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 40,
      child: TextFormField(
        keyboardType: keyboardType,
        cursorColor: ColorManager.blueColor,
        controller: controller,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.search),
          ),
          filled: true,
          fillColor: ColorManager.whiteColor,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          contentPadding: const EdgeInsets.only(top: 5, left: 10),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.blueColor),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.blueColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
