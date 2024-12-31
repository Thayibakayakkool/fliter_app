part of 'home_page_bloc.dart';

abstract class HomePageState {}

class FilterInitialState extends HomePageState {}

class FilterUpdatedState extends HomePageState {
  final List<UserDetails> filteredList;
  final bool isListVisible;
  final bool showList;

  FilterUpdatedState(
    this.filteredList,
    this.isListVisible,
    this.showList,
  );
}

class DateFilterState extends HomePageState {
  final String? fromDate;
  final String? toDate;
  final List<UserDetails> filteredList;
  final bool isListVisible;

  DateFilterState({
    this.fromDate,
    this.toDate,
    this.filteredList = const [],
    this.isListVisible = false,
  });

  DateFilterState copyWith({
    String? fromDate,
    String? toDate,
    List<UserDetails>? filteredList,
    bool? isListVisible,
  }) {
    return DateFilterState(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      filteredList: filteredList ?? this.filteredList,
      isListVisible: isListVisible ?? this.isListVisible,
    );
  }
}

class FilterLoadedState extends HomePageState {
  final List<UserDetails> filteredList;
  final bool isListVisible;

  FilterLoadedState({
    required this.filteredList,
    required this.isListVisible,
  });
}

