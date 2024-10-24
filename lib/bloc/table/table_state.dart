import 'package:equatable/equatable.dart';

abstract class TableState extends Equatable {
  const TableState();

  @override
  List<Object> get props => [];
}

class TableLoading extends TableState {}

class TableLoaded extends TableState {
  final List<Map<String, dynamic>> tableData;
  final int? sortColumnIndex;
  final bool sortAscending;

  const TableLoaded(this.tableData, this.sortColumnIndex, this.sortAscending);

  @override
  List<Object> get props => [tableData, sortColumnIndex ?? 0, sortAscending];
}

class TableError extends TableState {
  final String error;

  const TableError(this.error);

  @override
  List<Object> get props => [error];
}
