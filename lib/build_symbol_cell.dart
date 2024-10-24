import 'package:calculator_flutter/bloc/table/table.bloc.dart';
import 'package:calculator_flutter/bloc/table/table_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

DataCell buildSymbolCell(
    String symbol, bool isFavorite, BuildContext context, String filter) {
  String formattedSymbol = symbol.replaceAll('-', '/');

  String iconPath;
  if (symbol.startsWith('BTC')) {
    iconPath = 'assets/icons/bitcoin.png';
  } else if (symbol.startsWith('ADA')) {
    iconPath = 'assets/icons/ada.png';
  } else if (symbol.startsWith('AVAX')) {
    iconPath = 'assets/icons/avax.png';
  } else if (symbol.startsWith('BNB')) {
    iconPath = 'assets/icons/bnb.png';
  } else if (symbol.startsWith('DAI')) {
    iconPath = 'assets/icons/dai.png';
  } else if (symbol.startsWith('DOGE')) {
    iconPath = 'assets/icons/doge.png';
  } else if (symbol.startsWith('DOT')) {
    iconPath = 'assets/icons/dot.png';
  } else if (symbol.startsWith('ETH')) {
    iconPath = 'assets/icons/eth.png';
  } else if (symbol.startsWith('LINK')) {
    iconPath = 'assets/icons/link.png';
  } else if (symbol.startsWith('LTC')) {
    iconPath = 'assets/icons/ltc.png';
  } else if (symbol.startsWith('POL')) {
    iconPath = 'assets/icons/pol.png';
  } else if (symbol.startsWith('SHIB')) {
    iconPath = 'assets/icons/shib.png';
  } else if (symbol.startsWith('SOL')) {
    iconPath = 'assets/icons/sol.png';
  } else if (symbol.startsWith('TRX')) {
    iconPath = 'assets/icons/trx.png';
  } else if (symbol.startsWith('UNI')) {
    iconPath = 'assets/icons/uni.png';
  } else if (symbol.startsWith('USDC')) {
    iconPath = 'assets/icons/usdc.png';
  } else if (symbol.startsWith('USDT')) {
    iconPath = 'assets/icons/usdt.png';
  } else if (symbol.startsWith('XRP')) {
    iconPath = 'assets/icons/xrp.png';
  } else {
    iconPath = 'assets/icons/person.png';
  }

  return DataCell(
    Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.star,
            color: isFavorite ? Colors.orange : Colors.grey,
          ),
          onPressed: () {
            context.read<TableBloc>().add(ToggleFavoriteStatus(symbol));
          },
        ),
        const SizedBox(width: 4),
        Image.asset(iconPath, width: 24, height: 24),
        const SizedBox(width: 8),
        Text(formattedSymbol),
      ],
    ),
  );
}
