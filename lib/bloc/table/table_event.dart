import 'package:equatable/equatable.dart';

abstract class TableEvent extends Equatable {
  const TableEvent();

  @override
  List<Object> get props => [];
}

class LoadTableData extends TableEvent {}

class SortTableData extends TableEvent {
  final int columnIndex;
  final bool ascending;

  const SortTableData(this.columnIndex, this.ascending);

  @override
  List<Object> get props => [columnIndex, ascending];
}

class FilterTableData extends TableEvent {
  final String filter;

  const FilterTableData(this.filter);

  @override
  List<Object> get props => [filter];
}

class ToggleFavoriteStatus extends TableEvent {
  final String symbol;

  const ToggleFavoriteStatus(this.symbol);

  @override
  List<Object> get props => [symbol];
}

class SearchTableData extends TableEvent {
  final String query;

  const SearchTableData(this.query);

  @override
  List<Object> get props => [query];
}
