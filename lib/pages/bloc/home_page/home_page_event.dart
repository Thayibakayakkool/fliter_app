part of 'home_page_bloc.dart';

abstract class HomePageEvent {}

class FilterSelectedEvent extends HomePageEvent {
  final String selectedFilter;

  FilterSelectedEvent(this.selectedFilter);
}

class SearchQueryUpdatedEvent extends HomePageEvent {
  final String searchQuery;

  SearchQueryUpdatedEvent(this.searchQuery);
}

class FilterTriggeredEvent extends HomePageEvent {}

class ButtonClickedEvent extends HomePageEvent {}

class DateSelectedEvent extends HomePageEvent {
  final String? date;
  final String type;

  DateSelectedEvent({required this.date, required this.type});

  @override
  List<Object?> get props => [date, type];
}

class FilterUpdatedEvent extends HomePageEvent {
  final Set<String> selectedFilters;

  FilterUpdatedEvent({required this.selectedFilters});
}

class ApplyDateFilterEvent extends HomePageEvent {}
