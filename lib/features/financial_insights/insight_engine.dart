import 'package:getx_drift_app/features/financial_insights/cashflow/cashflow_insights.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_insight.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_state.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/rules/cashflow_insight_rule.dart';

class InsightEngine {
  const InsightEngine();

  CashflowInsight? resolveCashflow(CashflowState state) {
    final matchingRules =
        cashflowInsightRules.where((rule) => rule.matches(state)).toList()
          ..sort((a, b) => b.priority.compareTo(a.priority));

    if (matchingRules.isEmpty) {
      return null;
    }

    final type = matchingRules.first.type;

    return cashflowInsights[type];
  }
}
