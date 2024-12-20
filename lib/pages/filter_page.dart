import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:filter_app/pages/user_details.dart';
import 'package:filter_app/widgets/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({
    super.key,
  });

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? selectedFilter;
  late List<UserDetails> filteredList;
  List<UserDetails> selectedItemsList = [];
  final List<String> filters = [
    'Name',
    'Place',
    'Date',
    'Payment',
    'Purchase No'
  ];
  Set<String> selectedItems = {};

  @override
  void initState() {
    super.initState();
    filteredList = List.from(userDetailsList);
    selectedFilter = 'Name';
  }

  Set<String> getUniqueItems(String filter) {
    switch (filter) {
      case 'Name':
        return userDetailsList.map((user) => user.name).toSet();
      case 'Place':
        return userDetailsList.map((user) => user.place).toSet();
      case 'Date':
        return userDetailsList.map((user) => user.date).toSet();
      case 'Payment':
        return userDetailsList.map((user) => user.payment).toSet();
      case 'Purchase No':
        return userDetailsList.map((user) => user.purchaseNumber).toSet();
      default:
        return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          'Filter',
          style: TextStyle(
            color: ColorManager.blueColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: ColorManager.lightGreyColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: filters.map((filter) {
                  int selectedCount = selectedItems.where((item) {
                    return getUniqueItems(filter).contains(item);
                  }).length;
                  bool isSelected = selectedFilter == filter;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Container(
                      width: 155,
                      padding: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorManager.blueColor
                            : ColorManager.lightGreyColor,
                      ),
                      child: Text(
                        selectedCount == 0
                            ? filter
                            : '$filter  ($selectedCount)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? ColorManager.whiteColor
                              : ColorManager.blueColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedFilter != null)
                    Expanded(
                      child: ListView(
                        children: getUniqueItems(selectedFilter!).map((item) {
                          return CheckboxListTile(
                            activeColor: ColorManager.blueColor,
                            checkColor: ColorManager.whiteColor,
                            title: Text(
                              item,
                              style: TextStyle(
                                color: ColorManager.blueColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            value: selectedItems.contains(item),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  selectedItems.add(item);
                                } else {
                                  selectedItems.remove(item);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    )
                  else
                    const Text(
                      'No results found.',
                      style: TextStyle(fontSize: 16),
                    ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomElevatedButton(
                      buttonText: 'Apply',
                      width: 190,
                      height: 40,
                      backgroundColor: ColorManager.blueColor,
                      textColor: ColorManager.whiteColor,
                      borderColor: ColorManager.blueColor,
                      onPressed: () {
                        Navigator.of(context).pop(selectedItems);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
