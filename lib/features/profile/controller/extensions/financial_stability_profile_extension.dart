import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_debt_load_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_lifestyle_coverage_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_wealth_building_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

extension FinancialStabilityProfileExtension on FinancialProfileController {
  bool get hasCompleteFinancialStabilityProfile {
    return canAssessDebtLoad &&
        canAssessWealthBuilding &&
        canAssessEmergencyFund &&
        canAssessLifestyleCoverage;
  }
}
