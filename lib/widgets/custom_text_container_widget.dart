import 'package:filter_app/core/color.dart';
import 'package:flutter/material.dart';

class CustomTextContainerWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTextContainerWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
            color: isSelected
                ? ColorManager.blueColor
                : ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorManager.blueColor, width: 2)),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? ColorManager.whiteColor
                : ColorManager.blueColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
