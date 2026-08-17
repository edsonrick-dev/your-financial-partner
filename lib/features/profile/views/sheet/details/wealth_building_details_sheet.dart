import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class WealthBuildingDetailsSheet extends StatelessWidget {
  final FinancialRatio ratio;

  const WealthBuildingDetailsSheet({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),

          AppSection(child: Text(ratio.type.shortDescription)),

          // Score Explanation
          // Insights
          // Score General
        ],
      ),
    );
  }
}
