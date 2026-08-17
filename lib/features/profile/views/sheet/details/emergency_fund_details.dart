import 'package:flutter/cupertino.dart';
import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class EmergencyFundDetails extends StatelessWidget {
  final FinancialRatio ratio;
  const EmergencyFundDetails({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 12),
          //Score Summary
          AppSection(child: Text(ratio.type.shortDescription)),
          //Score Explanation
          //Insights
          //Score General
        ],
      ),
    );
  }
}
