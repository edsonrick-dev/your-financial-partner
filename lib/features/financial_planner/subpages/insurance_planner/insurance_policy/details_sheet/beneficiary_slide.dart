import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/details_sheet/beneficiary_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class BeneficiarySlide extends StatelessWidget {
  const BeneficiarySlide({super.key, required this.faceValue});
  final double faceValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
      child: AppSection(
        child: Column(
          spacing: 20,
          children: [
            BeneficiaryCard(
              name: 'Katrina Francesca D. Villano',
              relationship: 'Wife',
              faceAmount: faceValue,
              share: 0.8,
            ),
            BeneficiaryCard(
              name: 'Primo Exequiel C. Talegon',
              relationship: 'Nephew',
              faceAmount: faceValue,
              share: 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
