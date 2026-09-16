import 'package:getx_drift_app/features/financial_state/financial_state.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_context.dart';

class LearnEngine {
  const LearnEngine();

  List<LearnContent> getRecommendedContent({
    required FinancialState state,
    required LearnContext context,
    required List<LearnContent> contents,
  }) {
    final recommendations = contents
        .where((content) => content.context == context)
        .where((content) => content.isEligible(state))
        .where((content) => content.isTriggered(state))
        .toList();

    recommendations.sort((a, b) => b.priority.compareTo(a.priority));

    return recommendations;
  }
}
