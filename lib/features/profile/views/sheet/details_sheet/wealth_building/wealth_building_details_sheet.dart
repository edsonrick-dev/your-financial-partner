import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_wealth_building_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/financial_score_disclaimer_section.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/wealth_building/empty_wealth_building_view.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/wealth_building/filled_wealth_building_view.dart';

class WealthBuildingDetailsSheet extends GetView<FinancialProfileController> {
  final FinancialRatio ratio;

  const WealthBuildingDetailsSheet({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    final isAssessed = controller.canAssessWealthBuilding;
    const spacing = 20.0;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),

          if (isAssessed)
            FilledWealthBuildingView(ratio: ratio)
          else
            const EmptyWealthBuildingView(),

          SizedBox(height: spacing),

          LearningSection(
            state: LearningSectionState.available,
            subtitle: 'Build a better understanding of wealth building.',
            contents: [
              LearnThumbnail(
                title: 'What is wealth building and why does it matter?',
              ),
              LearnThumbnail(
                title: 'What counts toward your wealth-building rate?',
              ),
              LearnThumbnail(title: 'How to improve your wealth-building rate'),
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
