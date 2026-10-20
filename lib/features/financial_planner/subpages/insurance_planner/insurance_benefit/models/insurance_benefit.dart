import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';

class InsuranceBenefit {
  final int id;
  final int? supabaseId;
  final int productId;
  final BenefitType benefitType;
  final String? name;
  final String? description;
  final bool isRequired;
  final DateTime createdAt;

  const InsuranceBenefit({
    required this.id,
    this.supabaseId,
    required this.productId,
    required this.benefitType,
    this.name,
    this.description,
    required this.isRequired,
    required this.createdAt,
  });
}
