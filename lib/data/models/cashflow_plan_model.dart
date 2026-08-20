// import 'dart:convert';

// import 'package:getx_drift_app/data/app_database.dart';
// import 'package:getx_drift_app/data/enums/frequency_type_enum.dart';
// import 'package:getx_drift_app/domain/enums/cashflow_plan_enum.dart';

// class CashFlowPlan {
//   final int id;

//   final String name;

//   final CashflowPlanType planType;

//   final ExpenseMode? expenseMode;

//   final int? categoryId;

//   final int? debtId;

//   final FrequencyType frequency;

//   final double? amount;

//   final List<double>? customAmounts;

//   final int? weekdayMask;

//   final int? monthMask;

//   final List<int>? occurrenceDays;

//   final DateTime? anchorDate;

//   final double dependentSurvivalFactor;
//   bool get isUniform => amount != null;

//   bool get isCustom => customAmounts != null && customAmounts!.isNotEmpty;
//   CashFlowPlan({
//     required this.id,
//     required this.name,
//     required this.planType,
//     required this.frequency,
//     this.amount,

//     this.customAmounts,
//     this.expenseMode,
//     this.categoryId,
//     this.debtId,

//     this.weekdayMask,
//     this.monthMask,

//     this.occurrenceDays,
//     this.anchorDate,

//     this.dependentSurvivalFactor = 0,
//   }) : assert(
//          (amount != null) !=
//              (customAmounts != null && customAmounts.isNotEmpty),
//          'Provide either amount or customAmounts, but not both.',
//        );
// }

// extension CashFlowPlanMapper on CashflowPlansTableData {
//   CashFlowPlan toDomain() {
//     return CashFlowPlan(
//       id: id,
//       name: name,

//       planType: CashflowPlanType.values.byName(planType),

//       expenseMode: expenseMode == null
//           ? null
//           : ExpenseMode.values.byName(expenseMode!),

//       categoryId: categoryId,

//       debtId: debtId,

//       frequency: FrequencyType.values.byName(frequency),

//       amount: amount,

//       customAmounts: customAmountsJson == null
//           ? null
//           : (jsonDecode(customAmountsJson!) as List)
//                 .map((e) => (e as num).toDouble())
//                 .toList(),

//       monthMask: monthMask,

//       occurrenceDays: occurrenceDaysJson == null
//           ? null
//           : (jsonDecode(occurrenceDaysJson!) as List).cast<int>(),

//       anchorDate: anchorDate,

//       dependentSurvivalFactor: dependentSurvivalFactor,
//     );
//   }
// }

// enum ExpenseMode { budget, bill }
