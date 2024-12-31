import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: borderColor)
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style:  TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
