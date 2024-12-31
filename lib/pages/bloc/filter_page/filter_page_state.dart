part of 'filter_page_bloc.dart';

abstract class FiltersState {}

class FiltersInitialState extends FiltersState {}

class FiltersLoadedState extends FiltersState {
  final String selectedFilter;
  final Set<String> selectedItems;
  final List<String> uniqueItems;

  FiltersLoadedState({
    required this.selectedFilter,
    required this.selectedItems,
    required this.uniqueItems,
  });
}
