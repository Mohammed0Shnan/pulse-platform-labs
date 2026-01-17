import 'package:intl/intl.dart';

class NumberHelper {

  //Input : 43250.50  Output: "$43,250.50"
  static String priceFormatter(num number, {String currency = 'USD'}) {
    final formatter = NumberFormat.currency(
      symbol: _getCurrencySymbol(currency),
      decimalDigits: 2,
    );
    return formatter.format(number);
  }
  // Input 2.5  Output: +2.50%
  static String percentageFormatter(num number, {int decimals = 2}) {
    final sign = number >= 0 ? '+' : '';
    return '$sign${number.toStringAsFixed(decimals)}%';
  }

  // Gets currency symbol for a given currency code
  static String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'USD':
        return '\$';
      default:
        return '\$';
    }
  }
}