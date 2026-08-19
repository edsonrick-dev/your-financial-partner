import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CashflowController extends GetxController {
  final seletectedDetailsTabIndex = 0.obs;

  double get annualExpense => 390000;
  double get expensePercentage =>
      clampDouble(annualExpense / dummyAnnualAllocation, 0, 1);

  double get annualDebtRepayment => 90000;
  double get debtRepaymentPercentage =>
      clampDouble(annualDebtRepayment / dummyAnnualAllocation, 0, 1);

  double get annualIncome => 750000;
  double get lifestyleCost => annualDebtRepayment + annualExpense;
  double get annualSavings => annualIncome - lifestyleCost;
  double get savingsPercentage =>
      clampDouble(annualSavings / dummyAnnualAllocation, 0, 1);
  double get dummyAnnualAllocation =>
      annualDebtRepayment + annualExpense + annualSavings;
  // double get annualAllocated =>
  //     projections.fold(0.0, (sum, p) => sum + p.allocated);

  // double get annualSurplus => annualIncome - annualAllocated;
}
