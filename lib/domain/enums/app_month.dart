enum AppMonth {
  jan(number: 1, fullName: 'January', shortName: 'Jan'),
  feb(number: 2, fullName: 'February', shortName: 'Feb'),
  mar(number: 3, fullName: 'March', shortName: 'Mar'),
  apr(number: 4, fullName: 'April', shortName: 'Apr'),
  may(number: 5, fullName: 'May', shortName: 'May'),
  jun(number: 6, fullName: 'June', shortName: 'Jun'),
  jul(number: 7, fullName: 'July', shortName: 'Jul'),
  aug(number: 8, fullName: 'August', shortName: 'Aug'),
  sep(number: 9, fullName: 'September', shortName: 'Sep'),
  oct(number: 10, fullName: 'October', shortName: 'Oct'),
  nov(number: 11, fullName: 'November', shortName: 'Nov'),
  dec(number: 12, fullName: 'December', shortName: 'Dec');

  final int number;
  final String fullName;
  final String shortName;

  const AppMonth({
    required this.number,
    required this.fullName,
    required this.shortName,
  });
}

extension DateTimeMonthExtension on DateTime {
  AppMonth get appMonth => AppMonth.values[month - 1];
}

extension AppMonthExtension on AppMonth {
  int get index => number - 1;
}
