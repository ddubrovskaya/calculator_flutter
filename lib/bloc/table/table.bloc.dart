import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'table_event.dart';
import 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  List<Map<String, dynamic>> _allData = [];
  String _currentFilter = 'All';
  String _searchQuery = '';
  int? _sortColumnIndex;
  bool _sortAscending = true;

  TableBloc() : super(TableLoading()) {
    on<LoadTableData>(_onLoadTableData);
    on<SortTableData>(_onSortTableData);
    on<FilterTableData>(_onFilterTableData);
    on<ToggleFavoriteStatus>(_onToggleFavoriteStatus);
    on<SearchTableData>(_onSearchTableData);
    add(LoadTableData());
  }

  Future<void> _onLoadTableData(
      LoadTableData event, Emitter<TableState> emit) async {
    try {
      final data =
          await rootBundle.loadString('assets/api-markets-search.json');
      final jsonResult = json.decode(data);
      _allData = List<Map<String, dynamic>>.from(jsonResult['data']);
      emit(TableLoaded(_allData, null, true));
    } catch (e) {
      emit(TableError(e.toString()));
    }
  }

  void _onSortTableData(SortTableData event, Emitter<TableState> emit) {
    if (state is TableLoaded) {
      _sortColumnIndex = event.columnIndex;
      _sortAscending = event.ascending;
      _applyCurrentFilter(emit);
    }
  }

  void _onFilterTableData(FilterTableData event, Emitter<TableState> emit) {
    _currentFilter = event.filter;
    _applyCurrentFilter(emit);
  }

  void _onToggleFavoriteStatus(
      ToggleFavoriteStatus event, Emitter<TableState> emit) {
    if (state is TableLoaded) {
      _allData = _allData.map((row) {
        if (row['symbol'] == event.symbol) {
          return {
            ...row,
            'isFavorite': !(row['isFavorite'] ?? false),
          };
        }
        return row;
      }).toList();
      _applyCurrentFilter(emit);
    }
  }

  void _onSearchTableData(SearchTableData event, Emitter<TableState> emit) {
    _searchQuery = event.query;
    _applyCurrentFilter(emit);
  }

  void _applyCurrentFilter(Emitter<TableState> emit) {
    List<Map<String, dynamic>> filteredData;

    if (_currentFilter == 'All') {
      filteredData = _allData;
    } else if (_currentFilter == 'Favorites') {
      filteredData =
          _allData.where((row) => row['isFavorite'] == true).toList();
    } else {
      filteredData = _allData
          .where((row) => row['symbol'].contains(_currentFilter))
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filteredData = filteredData.where((row) {
        return row['symbol'].toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (_sortColumnIndex != null) {
      filteredData.sort((a, b) {
        final aValue = a[_getColumnKey(_sortColumnIndex!)];
        final bValue = b[_getColumnKey(_sortColumnIndex!)];
        return _sortAscending
            ? aValue.compareTo(bValue)
            : bValue.compareTo(aValue);
      });
    }

    emit(TableLoaded(filteredData, _sortColumnIndex, _sortAscending));
  }

  String _getColumnKey(int columnIndex) {
    switch (columnIndex) {
      case 0:
        return 'symbol';
      case 1:
        return 'lastPrice';
      case 2:
        return 'change';
      case 3:
        return 'highPrice';
      case 4:
        return 'lowPrice';
      case 5:
        return 'volume';
      default:
        return '';
    }
  }

  String formatNumber(String value) {
    try {
      double number = double.parse(value);
      String numberStr = number.toString();

      if (numberStr.contains('.')) {
        List<String> parts = numberStr.split('.');
        String fractionalPart = parts[1];

        if (fractionalPart.length > 8) {
          return number.toStringAsFixed(8);
        }
      }
      return numberStr;
    } catch (e) {
      return value;
    }
  }

  String formatSymbol(String symbol) {
    return symbol.replaceAll('-', '/');
  }

  String formatVolume(String value) {
    try {
      double volume = double.parse(value);

      if (volume >= 1e9) {
        double volumeInBillions = volume / 1e9;
        return 'A\$${volumeInBillions.toStringAsFixed(2)}B';
      } else if (volume >= 1e6) {
        double volumeInMillions = volume / 1e6;
        return 'A\$${volumeInMillions.toStringAsFixed(2)}M';
      } else if (volume >= 1e3) {
        double volumeInThousands = volume / 1e3;
        return 'A\$${volumeInThousands.toStringAsFixed(2)}K';
      }
      return 'A\$${volume.toStringAsFixed(2)}';
    } catch (e) {
      return value;
    }
  }
}
