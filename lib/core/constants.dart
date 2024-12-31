import 'package:filter_app/pages/user_details.dart';
import 'package:flutter/material.dart';

// height

SizedBox kSizedBox5 = const SizedBox(
  height: 5,
);
SizedBox kSizedBox10 = const SizedBox(
  height: 10,
);
SizedBox kSizedBox8 = const SizedBox(
  height: 8,
);
SizedBox kSizedBox12 = const SizedBox(
  height: 12,
);
SizedBox kSizedBox15 = const SizedBox(
  height: 15,
);
SizedBox kSizedBox20 = const SizedBox(
  height: 20,
);

//width
SizedBox kSizedBoxW3 = const SizedBox(
  width: 3,
);
SizedBox kSizedBoxW7 = const SizedBox(
  width: 7,
);
SizedBox kSizedBoxW12 = const SizedBox(
  width: 12,
);
SizedBox kSizedBoxW15 = const SizedBox(
  width: 15,
);

final List<UserDetails> userDetailsList = [
  UserDetails(
    name: 'Aishwarya Lekshmi',
    date: '25-11-2024',
    place: 'Kannur',
    payment: 'Google Pay',
    mobile: '7382697696',
    purchaseNumber: 'cxmnusd',
  ),
  UserDetails(
    name: 'Nazriya Nazim',
    date: '12-03-2023',
    place: 'Kochi',
    payment: 'Paytm',
    mobile: '8123456789',
    purchaseNumber: 'ab123xyz',
  ),
  UserDetails(
    name: 'Rahul',
    date: '05-06-2024',
    place: 'Trivandrum',
    payment: 'Credit Card',
    mobile: '9123456780',
    purchaseNumber: 'pqrs0987',
  ),
  UserDetails(
    name: 'Keerthy Suresh',
    date: '1-11-2024',
    place: 'Kannur',
    payment: 'Paytm',
    mobile: '9837321294',
    purchaseNumber: 'cxmp2833',
  ),
  UserDetails(
    name: 'Aisha',
    date: '05-03-2024',
    place: 'Palakkad',
    payment: 'Cash on Delivery',
    mobile: '0987654321',
    purchaseNumber: 'lmno2345',
  ),
  UserDetails(
    name: 'John',
    date: '15-09-2024',
    place: 'Kochi',
    payment: 'Credit Card',
    mobile: '9876543210',
    purchaseNumber: 'abc1234',
  ),
];
final List<String> items = [
  'All',
  'Customer Name',
  'Place',
  'Mobile Number',
  'Payment Type',
  'Purchase Number'
];
final List<String> dateRanges = [
  'Today',
  'Yesterday',
  'This Week',
  'Last Week',
  'This Month',
  'Last Month',
  'This Year',
  'Last Year',
];

DateTimeRange getDateRange(String range) {
  final today = DateTime.now();
  switch (range) {
    case 'Today':
      return DateTimeRange(start: today, end: today);
    case 'This Week':
      final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      return DateTimeRange(start: startOfWeek, end: endOfWeek);
    case 'Last Week':
      final startOfLastWeek = today.subtract(Duration(days: today.weekday + 6));
      final endOfLastWeek = startOfLastWeek.add(const Duration(days: 6));
      return DateTimeRange(start: startOfLastWeek, end: endOfLastWeek);
    case 'Yesterday':
      final yesterday = today.subtract(const Duration(days: 1));
      return DateTimeRange(start: yesterday, end: yesterday);
    case 'This Month':
      final startOfMonth = DateTime(today.year, today.month, 1);
      final endOfMonth = DateTime(today.year, today.month + 1, 0);
      return DateTimeRange(start: startOfMonth, end: endOfMonth);
    case 'Last Month':
      final firstDayOfLastMonth = DateTime(today.year, today.month - 1, 1);
      final lastDayOfLastMonth = DateTime(today.year, today.month, 0);
      return DateTimeRange(start: firstDayOfLastMonth, end: lastDayOfLastMonth);
    case 'This Year':
      final startOfYear = DateTime(today.year, 1, 1);
      final endOfYear = DateTime(today.year, 12, 31);
      return DateTimeRange(start: startOfYear, end: endOfYear);
    case 'Last Year':
      final startOfLastYear = DateTime(today.year - 1, 1, 1);
      final endOfLastYear = DateTime(today.year - 1, 12, 31);
      return DateTimeRange(start: startOfLastYear, end: endOfLastYear);
    default:
      return DateTimeRange(start: today, end: today);
  }
}

final List<String> filters = [
  'Name',
  'Place',
  'Mobile No',
  'Date',
  'Payment',
  'Purchase No'
];
