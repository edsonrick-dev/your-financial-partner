import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';

class PolicyBenefitDraft {
  final int? insuranceBenefitId;
  final BenefitType benefitType;
  final String? name;
  final double coverageAmount;

  const PolicyBenefitDraft({
    this.insuranceBenefitId,
    required this.benefitType,
    this.name,
    this.coverageAmount = 0,
  });

  PolicyBenefitDraft copyWith({
    int? insuranceBenefitId,
    BenefitType? benefitType,
    String? name,
    double? coverageAmount,
  }) {
    return PolicyBenefitDraft(
      insuranceBenefitId: insuranceBenefitId ?? this.insuranceBenefitId,
      benefitType: benefitType ?? this.benefitType,
      name: name ?? this.name,
      coverageAmount: coverageAmount ?? this.coverageAmount,
    );
  }
}
