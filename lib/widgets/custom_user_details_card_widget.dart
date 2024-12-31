import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:flutter/material.dart';

class CustomUserDetailsCardWidget extends StatelessWidget {
  final String name;
  final String date;
  final String place;
  final String payment;
  final String mobile;
  final String purchaseNumber;

  const CustomUserDetailsCardWidget({
    super.key,
    required this.name,
    required this.date,
    required this.place,
    required this.payment,
    required this.mobile,
    required this.purchaseNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.blueColor, width: 2),
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: ColorManager.blueColor,
                    child: Icon(
                      Icons.person,
                      color: ColorManager.whiteColor,
                      size: 20,
                    ),
                  ),
                  kSizedBoxW12,
                  Text(
                    name,
                    style: TextStyle(
                      color: ColorManager.blueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                date,
                style: TextStyle(
                    color: ColorManager.blueColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          kSizedBox12,
          Divider(color: ColorManager.greyColor, height: 1),
          kSizedBox12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: ColorManager.blueColor,
                    size: 18,
                  ),
                  kSizedBoxW7,
                  Text(
                    'Place: $place',
                    style: TextStyle(
                      color: ColorManager.blueColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Text(
                payment,
                style: TextStyle(
                  color: ColorManager.blueColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          kSizedBox12,
          Row(
            children: [
              Icon(
                Icons.phone,
                color: ColorManager.blueColor,
                size: 18,
              ),
              kSizedBoxW7,
              Text(
                'Mobile No: $mobile',
                style: TextStyle(
                  color: ColorManager.blueColor,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          kSizedBox8,
          Row(
            children: [
              Icon(
                Icons.receipt,
                color: ColorManager.blueColor,
                size: 18,
              ),
              kSizedBoxW7,
              Text(
                'Purchase No: $purchaseNumber',
                style: TextStyle(
                  color: ColorManager.blueColor,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
