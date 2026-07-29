import 'package:getx_drift_app/data/models/cashflow_plan_model.dart';
import 'package:getx_drift_app/data/enums/frequency_type_enum.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/services/occurrence_generators/annual_occurrence_generator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/services/occurrence_generators/daily_occurrence_generator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/services/occurrence_generators/monthly_occurrence_generator.dart';
import 'package:getx_drift_app/domain/enums/cashflow_plan_enum.dart';

class PlanProjection {
  final AppMonth month;
  final double amount;

  const PlanProjection({required this.month, required this.amount});
}

class MonthlyProjection {
  final AppMonth month;

  double income;
  double expenses;
  double debtRepayment;
  double savings;

  MonthlyProjection({
    required this.month,
    this.income = 0,
    this.expenses = 0,
    this.debtRepayment = 0,
    this.savings = 0,
  });

  double get allocated => expenses + debtRepayment + savings;

  double get surplus => income - allocated;

  double amount(CashflowPlanType type) {
    switch (type) {
      case CashflowPlanType.income:
        return income;

      case CashflowPlanType.expense:
        return expenses;

      case CashflowPlanType.debtRepayment:
        return debtRepayment;

      case CashflowPlanType.savingsInvestment:
        return savings;
    }
  }
}

class Occurrence {
  final DateTime date;

  final double amount;

  const Occurrence({required this.date, required this.amount});
}

abstract class OccurrenceGenerator {
  List<Occurrence> generate({required CashFlowPlan plan, required int year});
}

// class CashFlowProjectionService {
//   List<MonthlyProjection> buildYearProjection({
//     required int year,
//     required List<CashFlowPlan> plans,
//   }) {
//     final projections = List.generate(
//       12,
//       (index) => MonthlyProjection(month: DateTime(year, index + 1)),
//     );

//     for (final plan in plans) {
//       _applyPlan(plan: plan, projections: projections);
//     }

//     return projections;
//   }

//   void _applyPlan({
//     required CashFlowPlan plan,
//     required List<MonthlyProjection> projections,
//   }) {
//     switch (plan.frequency) {
//       case FrequencyType.monthly:
//         _applyMonthly(plan, projections);

//       // case FrequencyType.yearly:
//       //   _applyYearly(plan, projections);

//       // case FrequencyType.quarterly:
//       //   _applyQuarterly(plan, projections);

//       // case FrequencyType.semiAnnual:
//       //   _applySemiAnnual(plan, projections);

//       default:
//         break;
//     }
//   }

//   void _applyMonthly(CashFlowPlan plan, List<MonthlyProjection> projections) {
//     for (final projection in projections) {
//       _addAmount(projection: projection, plan: plan, amount: plan.amount);
//     }
//   }

//   void _addAmount({
//     required MonthlyProjection projection,
//     required CashFlowPlan plan,
//     required double amount,
//   }) {
//     switch (plan.planType) {
//       case CashflowPlanType.income:
//         projection.income += amount;

//       case CashflowPlanType.expense:
//         projection.expenses += amount;

//       case CashflowPlanType.debtRepayment:
//         projection.debtRepayment += amount;

//       case CashflowPlanType.savingsInvestment:
//         projection.savings += amount;
//     }
//   }
// }

class CashFlowProjectionService {
  List<MonthlyProjection> buildYearProjection({
    required int year,
    required List<CashFlowPlan> plans,
  }) {
    final projections = List.generate(
      12,
      (index) => MonthlyProjection(month: AppMonth.values[index]),
    );

    for (final plan in plans) {
      final generator = OccurrenceFactory.getGenerator(plan.frequency);

      final occurrences = generator.generate(plan: plan, year: year);

      for (final occurrence in occurrences) {
        final monthIndex = occurrence.date.month - 1;

        _applyOccurrence(projections[monthIndex], plan, occurrence.amount);
      }
    }

    return projections;
  }

  List<PlanProjection> buildPlanPreview({
    required int year,
    required CashFlowPlan plan,
  }) {
    final occurences = OccurrenceFactory.getGenerator(
      plan.frequency,
    ).generate(plan: plan, year: year);

    final amounts = List<double>.filled(12, 0);

    for (final occurence in occurences) {
      final monthIndex = occurence.date.month - 1;
      amounts[monthIndex] += occurence.amount;
    }
    // final projections = List.generate(
    //   12,
    //   (index) =>
    //       PlanProjection(month: AppMonth.values[index], amount: amounts[index]),
    // );
    return List.generate(
      12,
      (index) =>
          PlanProjection(month: AppMonth.values[index], amount: amounts[index]),
    );
  }

  void _applyOccurrence(
    MonthlyProjection projection,
    CashFlowPlan plan,
    double amount,
  ) {
    switch (plan.planType) {
      case CashflowPlanType.income:
        projection.income += amount;
        break;

      case CashflowPlanType.expense:
        projection.expenses += amount;
        break;

      case CashflowPlanType.debtRepayment:
        projection.debtRepayment += amount;
        break;

      case CashflowPlanType.savingsInvestment:
        projection.savings += amount;
        break;
    }
  }
}

class OccurrenceFactory {
  static OccurrenceGenerator getGenerator(FrequencyType frequency) {
    switch (frequency) {
      case FrequencyType.daily:
        return DailyOccurrenceGenerator();

      case FrequencyType.weekly:
        return WeeklyOccurrenceGenerator();

      case FrequencyType.biWeekly:
        return BiWeeklyOccurrenceGenerator();

      case FrequencyType.fortnightly:
        return FortnightlyOccurrenceGenerator();

      case FrequencyType.monthly:
        return MonthlyOccurrenceGenerator();

      case FrequencyType.quarterly:
        return QuarterlyOccurrenceGenerator();

      case FrequencyType.semiAnnual:
        return SemiAnnualOccurrenceGenerator();

      case FrequencyType.annual:
        return AnnualOccurrenceGenerator();
    }
  }
}

List<int> selectedMonths(int mask) {
  final result = <int>[];

  for (int month = 1; month <= 12; month++) {
    if ((mask & (1 << (month - 1))) != 0) {
      result.add(month);
    }
  }

  return result;
}

class SemiAnnualOccurrenceGenerator implements OccurrenceGenerator {
  @override
  List<Occurrence> generate({required CashFlowPlan plan, required int year}) {
    final months = selectedMonths(plan.monthMask!);

    final occurrences = <Occurrence>[];

    for (int i = 0; i < months.length; i++) {
      final amount = plan.isUniform ? plan.amount! : plan.customAmounts![i];

      occurrences.add(
        Occurrence(date: DateTime(year, months[i], 1), amount: amount),
      );
    }

    return occurrences;
  }
}

class QuarterlyOccurrenceGenerator implements OccurrenceGenerator {
  @override
  List<Occurrence> generate({required CashFlowPlan plan, required int year}) {
    final months = selectedMonths(plan.monthMask!);

    final occurrences = <Occurrence>[];

    for (int i = 0; i < months.length; i++) {
      final amount = plan.isUniform ? plan.amount! : plan.customAmounts![i];

      occurrences.add(
        Occurrence(date: DateTime(year, months[i], 1), amount: amount),
      );
    }

    return occurrences;
  }
}

class BiWeeklyOccurrenceGenerator implements OccurrenceGenerator {
  @override
  List<Occurrence> generate({required CashFlowPlan plan, required int year}) {
    return [];
  }
}

class FortnightlyOccurrenceGenerator implements OccurrenceGenerator {
  @override
  List<Occurrence> generate({required CashFlowPlan plan, required int year}) {
    return [];
  }
}

class WeeklyOccurrenceGenerator implements OccurrenceGenerator {
  @override
  List<Occurrence> generate({required CashFlowPlan plan, required int year}) {
    final occurrences = <Occurrence>[];

    for (int month = 1; month <= 12; month++) {
      final daysInMonth = DateTime(year, month + 1, 0).day;

      final weekCount = (daysInMonth / 7).ceil();

      for (int week = 0; week < weekCount; week++) {
        final amount = plan.isUniform
            ? plan.amount!
            : plan.customAmounts![week];

        if (amount == 0) continue;

        occurrences.add(
          Occurrence(
            date: DateTime(year, month, (week * 7) + 1),
            amount: amount,
          ),
        );
      }
    }

    return occurrences;
  }
}
