int calculateAge(DateTime birthday, {DateTime? asOf}) {
  final today = asOf ?? DateTime.now();

  var age = today.year - birthday.year;

  if (today.month < birthday.month ||
      (today.month == birthday.month && today.day < birthday.day)) {
    age--;
  }

  return age;
}
