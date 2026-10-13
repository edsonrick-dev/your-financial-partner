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
        case ProtectionNeedType.funeralAndFinalExpense:
          return controller.funeralAndFinalExpenseFund.value;
        case ProtectionNeedType.expenseContinuity:
          return controller.deathExpenseContinuityFund.value;
        case ProtectionNeedType.educationFunding:
          return controller.educationFunding.value;
        case ProtectionNeedType.debtsAndObligations:
          return controller.debtsAndObligations.value;
        case ProtectionNeedType.estateSettlement:
          return controller.estateSettlementFund.value;

        default:
          return 0;
      }

    case ProtectionType.criticalIllness:
      switch (needType) {
        case ProtectionNeedType.expenseContinuity:
          return controller.criticalIllnessExpenseContinuityFund.value;

        default:
          return controller.fakeDouble.value;
      }

    case ProtectionType.disability:
      switch (needType) {
        case ProtectionNeedType.expenseContinuity:
          return controller.disabilityExpenseContinuityFund.value;

        default:
          return controller.fakeDouble.value;
      }
  }
}
