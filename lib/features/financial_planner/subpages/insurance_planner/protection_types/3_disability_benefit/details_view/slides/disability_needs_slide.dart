import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_card_builder.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

class DisabilityNeedsSlide extends StatelessWidget {
  const DisabilityNeedsSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: context.bottomPaddingSub,
        right: 16,
        left: 16,
      ),
      child: Column(
        spacing: 20,
        children: ProtectionNeedCardBuilder.build(
          type: ProtectionType.disability,
        ),
      ),
    );
  }
}
