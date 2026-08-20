import 'package:intl/intl.dart';

extension DoubleCurrencyExt on num {
  String toCurrency({
    String symbol = '₱',
    int decimalDigits = 2,
    String locale = 'en_PH',
    bool accountingStyle = false,
  }) {
    final format = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );

    if (accountingStyle && this < 0) {
      return '(${format.format(abs())})';
    }

    return format.format(this);
  }

  /// Compact currency. Falls back to `toCurrency()` for values below threshold.
  ///
  /// useSmallK: true => K starts at 10,000; false => K starts at 100,000
  /// compactDecimalDigits: number of decimals for compact units (e.g. 1 => 1.2M)
  String toCompactCurrency({
    double kThreshold = 1000,
    bool useSmallK = true,
    int compactDecimalDigits = 1, // controls decimals in 102.3K
    String symbol = '₱',
    int fullDecimalDigits = 2,
    String locale = 'en_PH',
    bool accountingStyle = false,
  }) {
    final double absValue = abs().toDouble();
    final bool isNegative = this < 0;

    // final double kThreshold = useSmallK ? 10_000 : 100_000;

    // Use full currency if below threshold
    if (absValue < kThreshold) {
      return toCurrency(
        symbol: symbol,
        decimalDigits: fullDecimalDigits,
        locale: locale,
        accountingStyle: accountingStyle,
      );
    }

    // Helper to format decimals: trims trailing zeros unless decimals = 2 and you want full precision
    String fmt(double v, int decimals) {
      String s = v.toStringAsFixed(decimals);
      // Remove trailing zeros only if decimals > 0
      if (decimals > 0) {
        s = s.replaceAll(RegExp(r'\.?0+$'), '');
      }
      return s;
    }

    String result;

    if (absValue < 1_000_000) {
      // K format (thousands)
      final double val = absValue / 1000;
      result = '${fmt(val, compactDecimalDigits)}K';
    } else if (absValue < 1_000_000_000) {
      // M format (millions)
      final double val = absValue / 1_000_000;
      result = '${fmt(val, compactDecimalDigits)}M';
    } else if (absValue < 1_000_000_000_000) {
      // B format (billions)
      final double val = absValue / 1_000_000_000;
      result = '${fmt(val, compactDecimalDigits)}B';
    } else {
      // T format (trillions)
      final double val = absValue / 1_000_000_000_000;
      result = '${fmt(val, compactDecimalDigits)}T';
    }

    final compactString = '$symbol$result';

    // Accounting: wrap negative in parentheses
    if (accountingStyle && isNegative) {
      return '($compactString)';
    }

    return isNegative ? '-$compactString' : compactString;
  }
}

extension TrendExtensions on List<double> {
  double get percentChange {
    if (length < 2) return 0;

    final previous = this[length - 2];
    final current = last;

    if (previous == 0) {
      return current == 0 ? 0 : 100;
    }

    return ((current - previous) / previous) * 100;
  }
}
