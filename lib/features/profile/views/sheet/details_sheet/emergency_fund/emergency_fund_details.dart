import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_state/financial_state.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content_library.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_context.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_engine.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_thumbnail.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/emergency_fund/empty_emergency_fund_view.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/emergency_fund/filled_emergency_fund_view.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/financial_score_disclaimer_section.dart';

class EmergencyFundDetails extends GetView<FinancialProfileController> {
  final FinancialRatio ratio;
  const EmergencyFundDetails({super.key, required this.ratio});
  @override
  Widget build(BuildContext context) {
    const learnEngine = LearnEngine();
    final isAssessed = controller.canAssessEmergencyFund;
    const spacing = 20.0;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),

          if (isAssessed)
            FilledEmergencyFundView(controller: controller)
          else
            EmptyEmergencyFundView(controller: controller),

          SizedBox(height: spacing),

          Obx(() {
            final recommendations = learnEngine.getRecommendedContent(
              state: controller.financialState,
              context: LearnContext.efr,
              contents: learnContentLibrary,
            );

            if (recommendations.isEmpty) {
              return const SizedBox.shrink();
            }

            return LearningSection(
              subtitle: 'Build a good understanding of your net worth.',
              state: LearningSectionState.available,
              contents: recommendations
                  .map(
                    (content) => LearnThumbnail(
                      title: content.title,
                      description: content.description,
                      type: content.type,
                      onTap: () {
                        // Open lesson
                      },
                    ),
                  )
                  .toList(),
            );
          }),
          SizedBox(height: spacing),

          FinancialScoreDisclaimerSection(),

          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
