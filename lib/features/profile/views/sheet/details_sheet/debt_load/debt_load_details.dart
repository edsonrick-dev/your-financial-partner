import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_debt_load_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/debt_load/empty_debt_load_view.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/debt_load/filled_debt_load_view.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/financial_score_disclaimer_section.dart';

class DebtLoadDetails extends GetView<FinancialProfileController> {
  final FinancialRatio ratio;
  const DebtLoadDetails({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    final isAssessed = controller.canAssessDebtLoad;
    const spacing = 20.0;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),

          if (isAssessed)
            FilledDebtLoadView(ratio: ratio)
          else
            EmptyDebtLoadView(),

          SizedBox(height: spacing),

          LearningSection(
            state: LearningSectionState.available,
            subtitle: 'Build a better understanding of your debt.',
            contents: [
              LearnThumbnail(
                title: 'What is debt load and why is it important to keep low?',
              ),
              LearnThumbnail(title: 'What counts as debt repayment?'),
              LearnThumbnail(title: 'How to improve your Debt Load'),
            ],
          ),

          SizedBox(height: spacing),

          const FinancialScoreDisclaimerSection(),

          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
