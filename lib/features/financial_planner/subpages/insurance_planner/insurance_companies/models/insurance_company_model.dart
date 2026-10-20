class InsuranceCompany {
  /// Local Drift EntitiesTable.id.
  final int id;

  /// Remote Supabase entities.id.
  /// Null when the company has not been linked to Supabase.
  final int? supabaseId;

  final String name;
  final String displayName;

  const InsuranceCompany({
    required this.id,
    this.supabaseId,
    required this.name,
    required this.displayName,
  });

  /// Use when parsing a Supabase entities row directly.
  factory InsuranceCompany.fromJson(Map<String, dynamic> json) {
    return InsuranceCompany(
      id: (json['id'] as num).toInt(),
      supabaseId: (json['id'] as num).toInt(),
      name: json['name'] as String,
      displayName: json['display_name'] as String,
    );
  }
}
