class InsuranceCompany {
  final int id;
  final String name;
  final String shortName;

  const InsuranceCompany({
    required this.id,
    required this.name,
    required this.shortName,
  });

  factory InsuranceCompany.fromJson(Map<String, dynamic> json) {
    return InsuranceCompany(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      shortName: json['short_name'] as String,
    );
  }
}
