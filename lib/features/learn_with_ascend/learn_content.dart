import 'package:getx_drift_app/features/financial_state/financial_state.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content_type.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_context.dart';

class LearnContent {
  final String id;
  final String title;
  final String description;
  final Duration? duration;
  final LearnContext context;
  final LearnContentType type;
  final int priority;

  final bool Function(FinancialState state) isEligible;
  final bool Function(FinancialState state) isTriggered;

  final String? actionRoute;
  final String? url;

  const LearnContent({
    required this.id,
    required this.title,
    required this.description,
    this.duration,
    required this.context,
    required this.type,
    required this.priority,
    required this.isEligible,
    required this.isTriggered,
    this.actionRoute,
    this.url,
  });
}
