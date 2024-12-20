import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:filter_app/pages/filter_page.dart';
import 'package:filter_app/pages/user_details.dart';
import 'package:filter_app/widgets/custom_elevated_button_widget.dart';
import 'package:filter_app/widgets/custom_text_container_widget.dart';
import 'package:filter_app/widgets/user_details_card_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Set<String> selectedFilter = {};
  late List<UserDetails> filteredList;
  String? selectedNameFilter;
  String? selectedPlaceFilter;
  String? selectedPaymentFilter;
  Set<String> selectedItems = {};

  @override
  void initState() {
    super.initState();
    filteredList = userDetailsList;
  }

  void applyFilter(Set<String> filter) {
    setState(() {
      selectedFilter = filter;
      filteredList = userDetailsList.where((user) {
        bool matches = true;

        if (selectedFilter.contains('Name') &&
            selectedNameFilter != null &&
            selectedNameFilter!.isNotEmpty) {
          matches &= user.name.contains(selectedNameFilter!);
        }
        if (selectedFilter.contains('Place') &&
            selectedPlaceFilter != null &&
            selectedPlaceFilter!.isNotEmpty) {
          matches &= user.place.contains(selectedPlaceFilter!);
        }
        if (selectedFilter.contains('Payment') &&
            selectedPaymentFilter != null &&
            selectedPaymentFilter!.isNotEmpty) {
          matches &= user.payment.contains(selectedPaymentFilter!);
        }
        return matches;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(
            color: ColorManager.blueColor,
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          kSizedBox10,
          Row(
            children: [
              kSizedBoxW3,
              CustomTextContainerWidget(
                title: 'All',
                isSelected: selectedFilter.isEmpty,
                onTap: () => applyFilter({}),
              ),
              kSizedBoxW7,
              CustomTextContainerWidget(
                title: 'Name',
                isSelected: selectedFilter.contains('Name'),
                onTap: () {
                  applyFilter({'Name'});
                  _showNameBottom();
                },
              ),
              kSizedBoxW7,
              CustomTextContainerWidget(
                title: 'Place',
                isSelected: selectedFilter.contains('Place'),
                onTap: () {
                  applyFilter({'Place'});
                  _showPlaceBottom();
                },
              ),
              kSizedBoxW7,
              CustomTextContainerWidget(
                title: 'Payment',
                isSelected: selectedFilter.contains('Payment'),
                onTap: () {
                  applyFilter({'Payment'});
                  _showPaymentBottom();
                },
              ),
              kSizedBoxW7,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: ColorManager.blueColor, width: 2)),
                child: InkWell(
                  onTap: () async {
                    final selectedFilters = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FilterPage(),
                      ),
                    );
                    if (selectedFilters != null && selectedFilters.isNotEmpty) {
                      setState(() {
                        selectedItems = selectedFilters;
                        filteredList = userDetailsList.where((user) {
                          return selectedItems.contains(user.name) ||
                              selectedItems.contains(user.place) ||
                              selectedItems.contains(user.mobile) ||
                              selectedItems.contains(user.payment) ||
                              selectedItems.contains(user.date) ||
                              selectedItems.contains(user.purchaseNumber);
                        }).toList();
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.blueColor,
                        ),
                      ),
                      kSizedBoxW3,
                      Icon(
                        Icons.sort,
                        color: ColorManager.blueColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          kSizedBox10,
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final userDetails = filteredList[index];
                return UserDetailsCard(
                  name: userDetails.name,
                  date: userDetails.date,
                  place: userDetails.place,
                  payment: userDetails.payment,
                  mobile: userDetails.mobile,
                  purchaseNumber: userDetails.purchaseNumber,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showNameBottom() {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final uniqueNames =
                userDetailsList.map((user) => user.name).toSet().toList();

            return Container(
              width: double.infinity,
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Text(
                    'Select Name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.blueColor,
                    ),
                  ),
                  kSizedBox10,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8.0,
                        children: uniqueNames
                            .map((name) => FilterChip(
                                  checkmarkColor: ColorManager.whiteColor,
                                  label: Text(
                                    name,
                                    style: TextStyle(
                                      color: selectedNameFilter == name
                                          ? ColorManager.whiteColor
                                          : ColorManager.blueColor,
                                    ),
                                  ),
                                  selected: selectedNameFilter == name,
                                  selectedColor: ColorManager.blueColor,
                                  backgroundColor: ColorManager.whiteColor,
                                  onSelected: (selected) {
                                    setModalState(() {
                                      selectedNameFilter =
                                          selected ? name : null;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 5,
                                  shadowColor: Colors.black.withOpacity(0.1),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomElevatedButton(
                        buttonText: 'Cancel',
                        width: 180,
                        height: 40,
                        backgroundColor: ColorManager.whiteColor,
                        textColor: ColorManager.blueColor,
                        borderColor: ColorManager.blueColor,
                        onPressed: () => Navigator.pop(context),
                      ),
                      CustomElevatedButton(
                        buttonText: 'Apply',
                        width: 180,
                        height: 40,
                        backgroundColor: ColorManager.blueColor,
                        textColor: ColorManager.whiteColor,
                        borderColor: ColorManager.blueColor,
                        onPressed: () {
                          applyFilter({'Name'});
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showPlaceBottom() {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final uniquePlaces =
                userDetailsList.map((user) => user.place).toSet().toList();

            return Container(
              width: double.infinity,
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Text(
                    'Select Place',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.blueColor,
                    ),
                  ),
                  kSizedBox10,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8.0,
                        children: uniquePlaces
                            .map((place) => FilterChip(
                                  checkmarkColor: ColorManager.whiteColor,
                                  label: Text(
                                    place,
                                    style: TextStyle(
                                      color: selectedPlaceFilter == place
                                          ? ColorManager.whiteColor
                                          : ColorManager.blueColor,
                                    ),
                                  ),
                                  selected: selectedPlaceFilter == place,
                                  selectedColor: ColorManager.blueColor,
                                  backgroundColor: ColorManager.whiteColor,
                                  onSelected: (selected) {
                                    setModalState(() {
                                      selectedPlaceFilter =
                                          selected ? place : null;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 5,
                                  shadowColor: Colors.black.withOpacity(0.1),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomElevatedButton(
                        buttonText: 'Cancel',
                        width: 180,
                        height: 40,
                        backgroundColor: ColorManager.whiteColor,
                        textColor: ColorManager.blueColor,
                        borderColor: ColorManager.blueColor,
                        onPressed: () => Navigator.pop(context),
                      ),
                      CustomElevatedButton(
                        buttonText: 'Apply',
                        width: 180,
                        height: 40,
                        backgroundColor: ColorManager.blueColor,
                        textColor: ColorManager.whiteColor,
                        borderColor: ColorManager.blueColor,
                        onPressed: () {
                          applyFilter({'Place'});
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showPaymentBottom() {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final uniquePayments =
                userDetailsList.map((user) => user.payment).toSet().toList();

            return Container(
              width: double.infinity,
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Text(
                    'Select Payment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.blueColor,
                    ),
                  ),
                  kSizedBox10,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8.0,
                        children: uniquePayments
                            .map((payment) => FilterChip(
                                  checkmarkColor: ColorManager.whiteColor,
                                  label: Text(
                                    payment,
                                    style: TextStyle(
                                      color: selectedPaymentFilter == payment
                                          ? ColorManager.whiteColor
                                          : ColorManager.blueColor,
                                    ),
                                  ),
                                  selected: selectedPaymentFilter == payment,
                                  selectedColor: ColorManager.blueColor,
                                  backgroundColor: ColorManager.whiteColor,
                                  onSelected: (selected) {
                                    setModalState(() {
                                      selectedPaymentFilter =
                                          selected ? payment : null;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 5,
                                  shadowColor: Colors.black.withOpacity(0.1),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomElevatedButton(
                        buttonText: 'Cancel',
                        width: 180,
                        height: 40,
                        backgroundColor: ColorManager.whiteColor,
                        textColor: ColorManager.blueColor,
                        borderColor: ColorManager.blueColor,
                        onPressed: () => Navigator.pop(context),
                      ),
                      CustomElevatedButton(
                        buttonText: 'Apply',
                        width: 180,
                        height: 40,
                        backgroundColor: ColorManager.blueColor,
                        textColor: ColorManager.whiteColor,
                        borderColor: ColorManager.blueColor,
                        onPressed: () {
                          applyFilter({'Payment'});
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
