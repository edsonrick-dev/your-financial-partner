class InsuranceProduct {
  /// Local Drift primary key. Null if not yet stored locally.
  final int? id;

  /// Supabase insurance_policies.id.
  final int? supabaseId;

  /// Local Drift EntitiesTable.id.
  final int companyId;

  final String name;
  final String? shortName;
  final String? description;
  final bool isUserGenerated;
  final int? minAge;
  final int? maxAge;
  final String? note;

  /// Supabase auth.users UUID for custom products.
  final String? createdByUserId;

  const InsuranceProduct({
    this.id,
    this.supabaseId,
    required this.companyId,
    required this.name,
    this.shortName,
    this.description,
    this.isUserGenerated = false,
    this.minAge,
    this.maxAge,
    this.note,
    this.createdByUserId,
  });

  String get displayName =>
      shortName?.trim().isNotEmpty == true ? shortName!.trim() : name;

  /// Maps a row fetched from Supabase.
  factory InsuranceProduct.fromJson(Map<String, dynamic> json) {
    return InsuranceProduct(
      supabaseId: (json['id'] as num).toInt(),
      companyId: (json['insurer_id'] as num).toInt(),
      name: json['name'] as String,
      shortName: json['short_name'] as String?,
      description: json['description'] as String?,
      isUserGenerated: json['is_user_generated'] as bool? ?? false,
      minAge: (json['min_age'] as num?)?.toInt(),
      maxAge: (json['max_age'] as num?)?.toInt(),
      note: json['note'] as String?,
      createdByUserId: json['created_by_user_id'] as String?,
    );
  }
}
