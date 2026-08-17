import 'package:flutter/cupertino.dart';
import 'package:getx_drift_app/features/profile/enum/financial_stability_level.dart';
import 'package:getx_drift_app/features/profile/models/financial_stability_score_model.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class StabilityLevelDetails extends StatelessWidget {
  final FinancialStability stability;
  const StabilityLevelDetails({super.key, required this.stability});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 12),
          //Score Summary
          AppSection(child: Text(stability.level.shortDescription)),
          //Score Explanation
          //Insights
          //Score General
        ],
      ),
    );
  }
}
