import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_card.dart';

class ProtectionNeedCardBuilder {
  ProtectionNeedCardBuilder._();

  static List<Widget> build({
    required ProtectionType type,
    VoidCallback? Function(ProtectionNeedType needType)? onTapResolver,
  }) {
    return type.requiredNeeds.map((needType) {
      return ProtectionNeedCard(
        type: type,
        needType: needType,
        onTap: onTapResolver?.call(needType),
      );
    }).toList();
  }
}
