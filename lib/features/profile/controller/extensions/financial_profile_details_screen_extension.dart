import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_debt_load_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_lifestyle_coverage_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_wealth_building_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/models/financial_stability_detail.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/debt_load/debt_load_details.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/emergency_fund/emergency_fund_details.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/lifestyle_coverage/lifestyle_coverage_details.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/stability_level/stability_level_details.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/wealth_building/wealth_building_details_sheet.dart';

extension FinancialProfileDetailsScreenExtension on FinancialProfileController {
  List<FinancialStabilityDetail> get stabilityProfileDetails => [
    FinancialStabilityDetail(
      title: 'Stability Level',
      page: StabilityLevelDetails(),
    ),
    FinancialStabilityDetail(
      title: FinancialRatioType.debtLoad.displayName,
      ratioType: FinancialRatioType.debtLoad,
      page: DebtLoadDetails(ratio: debtLoad),
    ),
    FinancialStabilityDetail(
      title: FinancialRatioType.wealthBuilding.displayName,
      ratioType: FinancialRatioType.wealthBuilding,
      page: WealthBuildingDetailsSheet(ratio: wealthBuilding),
    ),
    FinancialStabilityDetail(
      title: FinancialRatioType.emergencyFund.displayName,
      ratioType: FinancialRatioType.emergencyFund,
      page: EmergencyFundDetails(ratio: emergencyFund),
    ),
    FinancialStabilityDetail(
      title: FinancialRatioType.lifestyleCoverage.displayName,
      ratioType: FinancialRatioType.lifestyleCoverage,
      page: LifestyleCoverageDetails(ratio: lifestyleCoverage),
    ),
  ];
  void selectRatioTab(FinancialRatioType ratioType) {
    final index = getDetailIndex(ratioType);

    if (index == -1) return;

    selectedDetailsIndex.value = index;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollSelectedTabIntoView();
    });
  }

  void selectTab(int index) {
    selectedDetailsIndex.value = index;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollSelectedTabIntoView();
    });
  }

  void scrollSelectedTabIntoView() {
    final index = selectedDetailsIndex.value;

    if (index < 0 || index >= stabilityDetailKeys.length) {
      return;
    }

    final context = stabilityDetailKeys[index].currentContext;

    if (context == null) {
      return;
    }

    Scrollable.ensureVisible(
      context,
      alignment: 0.5,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  int getDetailIndex(FinancialRatioType ratioType) {
    return stabilityProfileDetails.indexWhere(
      (detail) => detail.ratioType == ratioType,
    );
  }
}
