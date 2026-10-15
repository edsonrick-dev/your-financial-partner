import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/cards/insurance_policy_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class DeathSourcesSlide extends StatelessWidget {
  const DeathSourcesSlide({super.key, required this.type});
  final ProtectionType type;
  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.colors;
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
      child: Column(
        children: [
          AppSection(
            sectionTitle: 'Insurance Sources',
            child: Column(
              children: [
                InsuranceSourceCard(
                  amount: 10000,
                  issuer: 'AIA Philippines',
                  name: 'AIA Critical Protect 100',
                  type: ProtectionType.death,
                ),
              ],
            ),
          ),
          AppSection(sectionTitle: 'Non-Insurance Sources', child: Column()),
        ],
      ),
    );
  }
}
