import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_lifestyle_coverage_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/financial_score_disclaimer_section.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/lifestyle_coverage/empty_lifestyle_coverage_view.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/lifestyle_coverage/filled_lifestyle_coverage_view.dart';

class LifestyleCoverageDetails extends GetView<FinancialProfileController> {
  final FinancialRatio ratio;

  const LifestyleCoverageDetails({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    final isAssessed = controller.canAssessLifestyleCoverage;
    const spacing = 20.0;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),

          if (isAssessed)
            const FilledLifestyleCoverageView()
          else
            const EmptyLifestyleCoverageView(),

          SizedBox(height: spacing),

          LearningSection(
            state: LearningSectionState.available,
            subtitle: 'Build a better understanding of lifestyle coverage.',
            contents: [
              LearnThumbnail(
                title: 'What is lifestyle coverage and why does it matter?',
              ),
              LearnThumbnail(
                title: 'How long could your net worth support your lifestyle?',
              ),
              LearnThumbnail(title: 'How to improve your lifestyle coverage'),
            ],
          ),
          SizedBox(height: spacing),

          FinancialScoreDisclaimerSection(),

          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
