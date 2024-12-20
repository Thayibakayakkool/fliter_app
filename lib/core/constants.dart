import 'package:filter_app/pages/user_details.dart';
import 'package:flutter/material.dart';

// height

SizedBox kSizedBox10 = const SizedBox(
  height: 10,
);
SizedBox kSizedBox8 = const SizedBox(
  height: 8,
);
SizedBox kSizedBox12 = const SizedBox(
  height: 12,
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
    date: '12-03-1998',
    place: 'Kochi',
    payment: 'Paytm',
    mobile: '8123456789',
    purchaseNumber: 'ab123xyz',
  ),
  UserDetails(
    name: 'Rahul',
    date: '05-06-2022',
    place: 'Trivandrum',
    payment: 'Credit Card',
    mobile: '9123456780',
    purchaseNumber: 'pqrs0987',
  ),
  UserDetails(
    name: 'Rajisha Vijayan',
    date: '15-11-2008',
    place: 'Calicut',
    payment: 'Google Pay',
    mobile: '7012345678',
    purchaseNumber: 'mnop5678',
  ),
  UserDetails(
    name: 'Keerthy Suresh',
    date: '1-11-2015',
    place: 'Kannur',
    payment: 'Paytm',
    mobile: '9837321294',
    purchaseNumber: 'cxmp2833',
  ),
];
