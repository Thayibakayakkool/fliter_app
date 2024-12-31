import 'package:filter_app/core/constants.dart';
import 'package:flutter/material.dart';

import '../core/color.dart';

class CustomDatePickerSelectorWidget extends StatelessWidget {
  final String label;
  final String? selectedDate;
  final String todayDate;
  final ValueChanged<String?> onDateSelected;

  const CustomDatePickerSelectorWidget({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.todayDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorManager.blueColor,
          ),
        ),
        kSizedBox8,
        InkWell(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime(2050),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: ColorManager.blueColor,
                      onPrimary: ColorManager.whiteColor,
                      surface: ColorManager.whiteColor,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: ColorManager.blueColor,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              String formattedDate =
                  "${picked.day}-${picked.month}-${picked.year}";
              onDateSelected(formattedDate);
            } else {
              onDateSelected(null);
            }
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: ColorManager.blueColor),
            ),
            color: ColorManager.whiteColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: ColorManager.blueColor,
                    size: 20,
                  ),
                  kSizedBoxW7,
                  Text(
                    selectedDate == null ? todayDate : selectedDate!,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorManager.blueColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
