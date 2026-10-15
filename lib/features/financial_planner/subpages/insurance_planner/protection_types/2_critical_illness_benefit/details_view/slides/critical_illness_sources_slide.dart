import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/cards/insurance_policy_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class CriticalIllnessSourcesSlide extends StatelessWidget {
  const CriticalIllnessSourcesSlide({super.key, required this.type});
  final ProtectionType type;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
      child: AppSection(
        sectionTitle: 'Insurance Sources',
        child: Column(
          children: [
            InsuranceSourceCard(
              type: type,
              amount: 1000000,
              issuer: 'AIA Philippines',
              name: 'AIA Critical Protect 100',
            ),
          ],
        ),
      ),
    );
  }
}
