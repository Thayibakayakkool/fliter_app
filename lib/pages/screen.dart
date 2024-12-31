import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:filter_app/pages/filter_page.dart';
import 'package:filter_app/pages/user_details.dart';
import 'package:filter_app/widgets/custom_date_picker_selector_widget.dart';
import 'package:filter_app/widgets/custom_elevated_button_widget.dart';
import 'package:filter_app/widgets/custom_search_text_field_widget.dart';
import 'package:filter_app/widgets/custom_user_details_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'bloc/home_page/home_page_bloc.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();

    String todayDate =
        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 320,
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.blueColor),
                    borderRadius: BorderRadius.circular(8),
                    color: ColorManager.whiteColor,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      padding: const EdgeInsets.only(left: 5),
                      dropdownColor: ColorManager.whiteColor,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.grey,
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Select',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      items: items.map((valueItems) {
                        return DropdownMenuItem<String>(
                          value: valueItems,
                          child: Text(
                            valueItems,
                            style: TextStyle(
                                fontSize: 18, color: ColorManager.blueColor),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        context
                            .read<HomePageBloc>()
                            .add(FilterSelectedEvent(val!));
                      },
                      value: context.watch<HomePageBloc>().selectedFilter,
                    ),
                  ),
                ),
                kSizedBoxW15,
                InkWell(
                  onTap: () async {
                    final selectedFilters =
                        await showModalBottomSheet<Set<String>>(
                      backgroundColor: ColorManager.whiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      context: context,
                      builder: (context) =>
                          FiltersPage(userDetailsList: userDetailsList),
                    );

                    if (selectedFilters != null && selectedFilters.isNotEmpty) {
                      context.read<HomePageBloc>().add(
                          FilterUpdatedEvent(selectedFilters: selectedFilters));
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: ColorManager.blueColor, width: 2)),
                    child: Icon(
                      Icons.sort,
                      color: ColorManager.blueColor,
                    ),
                  ),
                ),
              ],
            ),
            kSizedBox15,
            if (context.watch<HomePageBloc>().selectedFilter != null &&
                context.watch<HomePageBloc>().selectedFilter != 'All') ...[
                  CustomSearchTextFieldWidget(
                controller: searchController,
                hintText:
                    'Search ${context.watch<HomePageBloc>().selectedFilter}',
                onPressed: () {
                  context.read<HomePageBloc>().add(
                        SearchQueryUpdatedEvent(searchController.text),
                      );
                  context.read<HomePageBloc>().add(ButtonClickedEvent());
                },
              ),
              kSizedBox20,
            ],
            BlocBuilder<HomePageBloc, HomePageState>(
              builder: (context, state) {
                String? fromDate =
                    (state is DateFilterState) ? state.fromDate : null;
                String? toDate =
                    (state is DateFilterState) ? state.toDate : null;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomDatePickerSelectorWidget(
                      label: 'From',
                      selectedDate: fromDate,
                      todayDate: todayDate,
                      onDateSelected: (date) => context.read<HomePageBloc>().add(
                            DateSelectedEvent(date: date, type: 'from'),
                          ),
                    ),
                    CustomDatePickerSelectorWidget(
                      label: 'To',
                      selectedDate: toDate,
                      todayDate: todayDate,
                      onDateSelected: (date) => context.read<HomePageBloc>().add(
                            DateSelectedEvent(date: date, type: 'to'),
                          ),
                    ),
                    CustomElevatedButton(
                      buttonText: 'Show',
                      width: 100,
                      height: 39,
                      backgroundColor: ColorManager.blueColor,
                      textColor: ColorManager.whiteColor,
                      borderColor: ColorManager.blueColor,
                      onPressed: () {
                        context.read<HomePageBloc>().add(ApplyDateFilterEvent());
                      },
                    ),
                  ],
                );
              },
            ),
            kSizedBox10,
            Divider(
              color: ColorManager.greyColor,
            ),
            kSizedBox10,
            BlocBuilder<HomePageBloc, HomePageState>(
              builder: (context, state) {
                List<UserDetails>? filteredList;
                bool isListVisible = false;
                bool showList = true;

                if (state is FilterUpdatedState) {
                  filteredList = state.filteredList;
                  isListVisible = state.isListVisible;
                  showList = state.showList;
                } else if (state is DateFilterState) {
                  filteredList = state.filteredList;
                  isListVisible = state.isListVisible;
                } else if (state is FilterLoadedState) {
                  filteredList = state.filteredList;
                  isListVisible = state.isListVisible;
                }

                if (filteredList != null &&
                    filteredList.isNotEmpty &&
                    showList) {
                  return Visibility(
                    replacement: const Center(
                      child: Text(
                        'Not found',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    visible: isListVisible,
                    child: Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final userDetails = filteredList![index];
                          return CustomUserDetailsCardWidget(
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
                  );
                }

                return const Center(
                  child: Text(
                    'Not found',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

