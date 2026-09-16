import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_state/financial_state.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content_library.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_context.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_engine.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_thumbnail.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_stability_profile_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/financial_score_disclaimer_section.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/stability_level/empty_stability_level_view.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/stability_level/filled_stability_level_view.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';

class StabilityLevelDetails extends GetView<FinancialProfileController> {
  const StabilityLevelDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final isAssessed = controller.hasCompleteFinancialStabilityProfile;

    const spacing = 20.0;
    const learnEngine = LearnEngine();
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),

          if (isAssessed)
            const FilledStabilityLevelView()
          else
            const EmptyStabilityLevelView(),

          SizedBox(height: spacing),
          Obx(() {
            final recommendations = learnEngine.getRecommendedContent(
              state: controller.financialState,
              context: LearnContext.financialStability,
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

          const FinancialScoreDisclaimerSection(),

          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
