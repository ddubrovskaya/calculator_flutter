import 'package:calculator_flutter/bloc/carousel/carousel_bloc.dart';
import 'package:calculator_flutter/bloc/carousel/carousel_event.dart';
import 'package:calculator_flutter/bloc/carousel/carousel_state.dart';
import 'package:calculator_flutter/bloc/table/table.bloc.dart';
import 'package:calculator_flutter/bloc/table/table_event.dart';
import 'package:calculator_flutter/bloc/table/table_state.dart';
import 'package:calculator_flutter/build_symbol_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  String _selectedFilter = 'All';
  String _searchQuery = '';

  Widget _buildFilterButton(BuildContext context, String filter) {
    final isSelected = _selectedFilter == filter;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          setState(() {
            _selectedFilter = filter;
          });
          context.read<TableBloc>().add(FilterTableData(filter));
        },
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? Colors.grey[200] : Colors.transparent,
          foregroundColor: isSelected ? Colors.blue : Colors.grey,
        ),
        child: Text(
          filter,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButtons(BuildContext context) {
    final filters = [
      'All',
      'Favorites',
      'AUD',
      'BTC',
      'ETH',
      'USDT',
      'BNB',
      'USDC',
      'DOGE',
      'TRX',
      'SHIB',
      'DOT',
      'DAI',
      'LTC',
      'MATIC',
      'UNI'
    ];
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: filters
            .map((filter) => _buildFilterButton(context, filter))
            .toList(),
      ),
    );
  }

  Widget _buildDataTable(BuildContext context, TableLoaded state) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.white,
            child: DataTable(
              sortAscending: state.sortAscending,
              sortColumnIndex: state.sortColumnIndex,
              columns: _buildDataColumns(context, state),
              rows: _buildDataRows(context, state),
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildDataColumns(BuildContext context, TableLoaded state) {
    return [
      _buildDataColumn(context, 'Instrument', 0, state),
      _buildDataColumn(context, 'Last Price', 1, state),
      _buildDataColumn(context, '24H Change', 2, state),
      _buildDataColumn(context, '24H High', 3, state),
      _buildDataColumn(context, '24H Low', 4, state),
      _buildDataColumn(context, 'Volume', 5, state),
      const DataColumn(label: Text('')),
    ];
  }

  DataColumn _buildDataColumn(
      BuildContext context, String label, int index, TableLoaded state) {
    return DataColumn(
      label: Row(
        children: [
          Text(label),
          IconButton(
            icon: Icon(
              state.sortColumnIndex == index && state.sortAscending
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
            onPressed: () {
              context
                  .read<TableBloc>()
                  .add(SortTableData(index, !state.sortAscending));
            },
          ),
        ],
      ),
    );
  }

  List<DataRow> _buildDataRows(BuildContext context, TableLoaded state) {
    return state.tableData.map((row) {
      return DataRow(cells: [
        buildSymbolCell(
            row['symbol'], row['isFavorite'] ?? false, context, 'Favorites'),
        DataCell(
            Text(context.read<TableBloc>().formatNumber(row['lastPrice']))),
        DataCell(Text(context.read<TableBloc>().formatNumber(row['change']))),
        DataCell(
            Text(context.read<TableBloc>().formatNumber(row['highPrice']))),
        DataCell(Text(context.read<TableBloc>().formatNumber(row['lowPrice']))),
        DataCell(Text(context.read<TableBloc>().formatVolume(row['volume']))),
        DataCell(
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.grey.shade300),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
            onPressed: () {},
            child: const Text('GET VERIFIED & TRADE'),
          ),
        ),
      ]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            BlocProvider(
              create: (context) => CarouselBloc()..add(LoadCarouselItems()),
              child: BlocBuilder<CarouselBloc, CarouselState>(
                builder: (context, state) {
                  if (state is CarouselLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CarouselError) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is CarouselLoaded) {
                    return SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          final formattedPrice =
                              NumberFormat('#,##0.00').format(item.price);
                          return Container(
                            width: 145,
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Image.asset(item.iconPath,
                                        width: 40, height: 40),
                                    const SizedBox(width: 8.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.heading,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          item.subheading,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  formattedPrice,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  '${item.percentage >= 0 ? '+' : ''}${item.percentage.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    color: item.percentage >= 0
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Buy Crypto',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            _buildFilterButtons(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Markets',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                  context.read<TableBloc>().add(SearchTableData(_searchQuery));
                },
              ),
            ),
            const SizedBox(height: 5),
            BlocBuilder<TableBloc, TableState>(
              builder: (context, state) {
                if (state is TableLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TableError) {
                  return Center(child: Text('Error: ${state.error}'));
                } else if (state is TableLoaded) {
                  return _buildDataTable(context, state);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
