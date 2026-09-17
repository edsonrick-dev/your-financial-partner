import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_scale.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_state/financial_state.dart';
import 'package:getx_drift_app/features/home/controllers/home_controller.dart';
import 'package:getx_drift_app/features/home/views/section_views/bills_reminder_section.dart';
import 'package:getx_drift_app/features/home/views/section_views/budget_progress_section.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content_library.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_context.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_engine.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_thumbnail.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/fund_summary_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final spacingM = AppScale.x5;
    final spacingL = AppScale.x6;
    final colorScheme = context.colors;

    final financialProfileController = Get.find<FinancialProfileController>();

    const learnEngine = LearnEngine();

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Obx(() {
          final recommendations = learnEngine.getRecommendedContent(
            state: financialProfileController.financialState,
            context: LearnContext.home,
            contents: learnContentLibrary,
          );

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: context.topPaddingSub,
                bottom: context.bottomPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  _greetingSection(colorScheme),

                  Padding(
                    padding: EdgeInsets.only(top: spacingL),
                    child: AppSection(
                      child: Column(children: [FundSummaryCard()]),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: spacingM),
                    child: BudgetProgressSection(),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: spacingM),
                    child: BillsReminderSection(),
                  ),

                  if (recommendations.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: spacingM),
                      child: LearningSection(
                        subtitle:
                            'Learn something useful for your financial journey',
                        state: LearningSectionState.available,
                        contents: recommendations
                            .map(
                              (content) => LearnThumbnail(
                                title: content.title,
                                description: content.description,
                                type: content.type,
                                onTap: () async {
                                  if (content.url == null) return;

                                  final uri = Uri.parse(content.url!);

                                  await launchUrl(
                                    uri,
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  AppSection _greetingSection(ColorScheme colorScheme) {
    return AppSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.userName.value.isEmpty
                ? '${controller.timeBasedGreeting}!'
                : '${controller.timeBasedGreeting}, '
                      '${controller.userName.value}!',
            style: AppTextStyle.headlineL,
          ),
          Text(
            'Let’s make today a great financial day.',
            style: AppTextStyle.labelM.copyWith(
              color: colorScheme.appTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}
