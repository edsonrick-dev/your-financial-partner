import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

double? resolveProtectionNeedAmount({
  required ProtectionType type,
  required ProtectionNeedType needType,
  required InsurancePlannerController controller,
}) {
  switch (type) {
    case ProtectionType.death:
      switch (needType) {
        case ProtectionNeedType.expenseContinuity:
          return controller.deathExpenseContinuityFund.value;

        default:
          return null;
      }

    case ProtectionType.criticalIllness:
      switch (needType) {
        case ProtectionNeedType.expenseContinuity:
          // Connect your critical illness calculation here.
          return null;

        default:
          return null;
      }

    case ProtectionType.disability:
      switch (needType) {
        case ProtectionNeedType.expenseContinuity:
          // Connect your disability calculation here.
          return null;

        default:
          return null;
      }
  }
}
