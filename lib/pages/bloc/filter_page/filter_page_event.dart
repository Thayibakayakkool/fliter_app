part of 'filter_page_bloc.dart';

abstract class FiltersEvent {}

class FilterChangedEvent extends FiltersEvent {
  final String selectedFilter;

  FilterChangedEvent(this.selectedFilter);
}

class ItemSelectionChangedEvent extends FiltersEvent {
  final String item;
  final bool isSelected;

  ItemSelectionChangedEvent(this.item, this.isSelected);
}

class ApplyFiltersEvent extends FiltersEvent {
  final Set<String> selectedItems;

  ApplyFiltersEvent(this.selectedItems);
}
