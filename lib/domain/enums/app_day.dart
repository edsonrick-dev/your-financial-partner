enum AppDay {
  mon(number: 1, fullName: 'Monday', shortName: 'Mon'),
  tue(number: 2, fullName: 'Tuesday', shortName: 'Tue'),
  wed(number: 3, fullName: 'Wednesday', shortName: 'Wed'),
  thu(number: 4, fullName: 'Thursday', shortName: 'Thu'),
  fri(number: 5, fullName: 'Friday', shortName: 'Fri'),
  sat(number: 6, fullName: 'Saturday', shortName: 'Sat'),
  sun(number: 7, fullName: 'Sunday', shortName: 'Sun');

  final int number;
  final String fullName;
  final String shortName;

  const AppDay({
    required this.number,
    required this.fullName,
    required this.shortName,
  });
}

extension AppDayExtension on AppDay {
  int get index => number - 1;
}
