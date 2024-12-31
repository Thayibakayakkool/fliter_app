import 'package:filter_app/pages/user_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filter_page_event.dart';

part 'filter_page_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  final List<UserDetails> userDetailsList;

  FiltersBloc(this.userDetailsList) : super(FiltersInitialState()) {
    on<FilterChangedEvent>((event, emit) {
      final uniqueItems = _getUniqueItems(event.selectedFilter).toList();
      emit(FiltersLoadedState(
        selectedFilter: event.selectedFilter,
        selectedItems: {},
        uniqueItems: uniqueItems,
      ));
    });

    on<ItemSelectionChangedEvent>((event, emit) {
      if (state is FiltersLoadedState) {
        final currentState = state as FiltersLoadedState;
        final updatedSelectedItems =
            Set<String>.from(currentState.selectedItems);
        if (event.isSelected) {
          updatedSelectedItems.add(event.item);
        } else {
          updatedSelectedItems.remove(event.item);
        }
        emit(FiltersLoadedState(
          selectedFilter: currentState.selectedFilter,
          selectedItems: updatedSelectedItems,
          uniqueItems: currentState.uniqueItems,
        ));
      }
    });

    on<ApplyFiltersEvent>((event, emit) {
      emit(FiltersLoadedState(
        selectedFilter: '', // Clear the selected filter after applying
        selectedItems: event.selectedItems,
        uniqueItems: [], // Can leave empty since no need for unique items here
      ));
    });
  }

  Set<String> _getUniqueItems(String filter) {
    switch (filter) {
      case 'Name':
        return userDetailsList.map((user) => user.name).toSet();
      case 'Place':
        return userDetailsList.map((user) => user.place).toSet();
      case 'Mobile No':
        return userDetailsList.map((user) => user.mobile).toSet();
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
}
