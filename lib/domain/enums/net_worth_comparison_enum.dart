enum NetWorthComparison { wtd, mtd, ytd }

extension NetWorthComparisonExtension on NetWorthComparison {
  String get comparisonLabel {
    switch (this) {
      case NetWorthComparison.wtd:
        return 'last week';

      case NetWorthComparison.mtd:
        return 'last month';

      case NetWorthComparison.ytd:
        return 'last year';
    }
  }

  String get selectorLabel {
    switch (this) {
      case NetWorthComparison.wtd:
        return 'Week';
      case NetWorthComparison.mtd:
        return 'Month';
      case NetWorthComparison.ytd:
        return 'YTD';
    }
  }
}
