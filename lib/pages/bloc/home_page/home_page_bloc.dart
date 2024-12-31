import 'package:filter_app/pages/user_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


part 'home_page_state.dart';

part 'home_page_event.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final List<UserDetails> userDetailsList;

  String? selectedFilter;
  String searchQuery = '';
  bool showList = false;
  String? fromDate;

  HomePageBloc(this.userDetailsList) : super(FilterInitialState()) {
    on<FilterSelectedEvent>(_onFilterSelectedEvent);
    on<SearchQueryUpdatedEvent>(_onSearchQueryUpdatedEvent);
    on<FilterTriggeredEvent>(_onFilterTriggeredEvent);
    on<ButtonClickedEvent>(_onButtonClickedEvent);
    on<DateSelectedEvent>(_onDateSelected);
    on<ApplyDateFilterEvent>(_applyDateFilter);
    on<FilterUpdatedEvent>(_onFilterEvent);
  }

  void _onFilterSelectedEvent(
      FilterSelectedEvent event, Emitter<HomePageState> emit) {
    selectedFilter = event.selectedFilter;
    searchQuery = '';
    showList = selectedFilter == 'All';
    add(FilterTriggeredEvent());
  }

  void _onSearchQueryUpdatedEvent(
      SearchQueryUpdatedEvent event, Emitter<HomePageState> emit) {
    searchQuery = event.searchQuery;
    add(FilterTriggeredEvent());
  }

  void _onFilterTriggeredEvent(
      FilterTriggeredEvent event, Emitter<HomePageState> emit) {
    List<UserDetails> filteredList;
    if (selectedFilter == 'Customer Name') {
      filteredList = userDetailsList
          .where((user) =>
              user.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    } else if (selectedFilter == 'Place') {
      filteredList = userDetailsList
          .where((user) =>
              user.place.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    } else if (selectedFilter == 'Mobile Number') {
      filteredList = userDetailsList
          .where((user) =>
              user.mobile.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    } else if (selectedFilter == 'Payment Type') {
      filteredList = userDetailsList
          .where((user) =>
              user.payment.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    } else if (selectedFilter == 'Purchase Number') {
      filteredList = userDetailsList
          .where((user) => user.purchaseNumber
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    } else {
      filteredList = userDetailsList;
    }

    emit(FilterUpdatedState(
      filteredList,
      filteredList.isNotEmpty,
      showList,
    ));
  }

  void _onButtonClickedEvent(
      ButtonClickedEvent event, Emitter<HomePageState> emit) {
    showList = true;
    add(FilterTriggeredEvent());
  }

  void _onDateSelected(DateSelectedEvent event, Emitter<HomePageState> emit) {
    if (state is DateFilterState) {
      final currentState = state as DateFilterState;
      if (event.type == 'from') {
        emit(currentState.copyWith(fromDate: event.date));
      } else if (event.type == 'to') {
        emit(currentState.copyWith(toDate: event.date));
      }
    } else {
      emit(DateFilterState(
        fromDate: event.type == 'from' ? event.date : null,
        toDate: event.type == 'to' ? event.date : null,
      ));
    }
  }

  void _applyDateFilter(
      ApplyDateFilterEvent event, Emitter<HomePageState> emit) {
    if (state is DateFilterState) {
      final currentState = state as DateFilterState;
      final fromDate = currentState.fromDate;
      final toDate = currentState.toDate;

      final filteredList = userDetailsList.where((user) {
        bool matchesFromDate = true;
        if (fromDate != null) {
          DateTime userDate = DateFormat("dd-MM-yyyy").parse(user.date);
          DateTime filterDate = DateFormat("dd-MM-yyyy").parse(fromDate);
          matchesFromDate =
              userDate.isAfter(filterDate) || userDate == filterDate;
        }

        bool matchesToDate = true;
        if (toDate != null) {
          DateTime userDate = DateFormat("dd-MM-yyyy").parse(user.date);
          DateTime filterDate = DateFormat("dd-MM-yyyy").parse(toDate);
          matchesToDate =
              userDate.isBefore(filterDate) || userDate == filterDate;
        }

        return matchesFromDate && matchesToDate;
      }).toList();

      emit(currentState.copyWith(
        filteredList: filteredList,
        isListVisible: filteredList.isNotEmpty,
      ));
    }
  }

  void _onFilterEvent(FilterUpdatedEvent event, Emitter<HomePageState> emit) {
    final selectedItems = event.selectedFilters;

    final filteredList = userDetailsList.where((user) {
      return selectedItems.contains(user.name) ||
          selectedItems.contains(user.place) ||
          selectedItems.contains(user.mobile) ||
          selectedItems.contains(user.payment) ||
          selectedItems.contains(user.date) ||
          selectedItems.contains(user.purchaseNumber);
    }).toList();

    emit(FilterLoadedState(
      filteredList: filteredList,
      isListVisible: filteredList.isNotEmpty,
    ));
  }
}
