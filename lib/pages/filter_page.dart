import 'package:filter_app/core/constants.dart';
import 'package:filter_app/pages/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/color.dart';
import '../widgets/custom_elevated_button_widget.dart';
import 'bloc/filter_page/filter_page_bloc.dart';

class FiltersPage extends StatelessWidget {
  final List<UserDetails> userDetailsList;

  const FiltersPage({super.key, required this.userDetailsList});

  @override
  Widget build(BuildContext context) {
    context.read<FiltersBloc>().add(FilterChangedEvent('Name'));

    return BlocBuilder<FiltersBloc, FiltersState>(
      builder: (context, state) {
        if (state is FiltersInitialState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FiltersLoadedState) {
          return FiltersPageContent(state: state);
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}

class FiltersPageContent extends StatelessWidget {
  final FiltersLoadedState state;

  const FiltersPageContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: ColorManager.lightGreyColor,
            child: Column(
              children: filters.map((filter) {
                final isSelected = state.selectedFilter == filter;
                print('${state.selectedItems}');
                return InkWell(
                  onTap: () {
                    context.read<FiltersBloc>().add(FilterChangedEvent(filter));
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
                      filter,
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
                if (state.uniqueItems.isNotEmpty)
                  ...state.uniqueItems.map((item) {
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
                      value: state.selectedItems.contains(item),
                      onChanged: (bool? value) {
                        context.read<FiltersBloc>().add(
                              ItemSelectionChangedEvent(item, value ?? false),
                            );
                      },
                    );
                  }).toList()
                else
                  const Center(child: Text('No found')),
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
                      context
                          .read<FiltersBloc>()
                          .add(ApplyFiltersEvent(state.selectedItems));
                      Navigator.pop(context, state.selectedItems);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


