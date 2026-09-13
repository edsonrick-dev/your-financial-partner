import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_insight_type.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

class CashflowInsight {
  final CashflowInsightType type;

  final String title;
  final String Function(FinancialProfileController controller) interpretation;
  final String Function(FinancialProfileController controller)
  recommendedAction;

  const CashflowInsight({
    required this.type,
    required this.title,
    required this.interpretation,
    required this.recommendedAction,
  });
}
