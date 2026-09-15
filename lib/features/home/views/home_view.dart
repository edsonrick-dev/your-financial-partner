import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_scale.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_setup/financial_setup_controller.dart';
import 'package:getx_drift_app/features/home/controllers/home_controller.dart';
import 'package:getx_drift_app/features/home/views/section_views/bills_reminder_section.dart';
import 'package:getx_drift_app/features/home/views/section_views/budget_progress_section.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/widgets/cards/fund_summary_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final spacingM = AppScale.x5;
    final spacingL = AppScale.x6;
    final colorScheme = context.colors;

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: context.topPaddingSub,
              bottom: context.bottomPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                AppSection(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          controller.userName.value.isEmpty
                              ? '${controller.timeBasedGreeting}!'
                              : '${controller.timeBasedGreeting}, '
                                    '${controller.userName.value}!',
                          style: AppTextStyle.headlineL,
                        ),
                      ),
                      Text(
                        'Let’s make today a great financial day.',
                        style: AppTextStyle.labelM.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                    ],
                  ),
                ),
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

                // LEARNING
                Padding(
                  padding: EdgeInsets.only(top: spacingM),
                  child: LearningSection(
                    state: LearningSectionState.available,
                    contents: [
                      LearnThumbnail(
                        title: 'Why Financial Planning Matters',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeView1 extends GetView<HomeController> {
  const HomeView1({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final spacingM = AppScale.x5;
    final spacingL = AppScale.x6;

    final setupController = Get.find<FinancialSetupController>();
    final cashflowController = Get.find<CashflowController>();
    final colorScheme = context.colors;

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: topPadding,
              bottom: context.bottomPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                AppSection(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good morning, Juan Dela Cruz!',
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
                ),

                // ACCOUNT-DEPENDENT CONTENT
                Obx(() {
                  if (!setupController.hasAccounts) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: EdgeInsets.only(top: spacingM),
                    child: AppSection(
                      child: Column(
                        children: [
                          FundSummaryCard(),
                          // SizedBox(height: spacingM),
                          // QuickActionSection(),
                        ],
                      ),
                    ),
                  );
                }),
                // AppSection(
                //   child: AppButton(
                //     text: 'Open Onboarding Flow',
                //     onTap: () {
                //       Get.bottomSheet(
                //         CashflowInsightSheet(),
                //         isScrollControlled: true,
                //         isDismissible: true,
                //       );
                //     },
                //   ),
                // ),
                // CASHFLOW-DEPENDENT CONTENT
                Obx(() {
                  if (cashflowController.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: EdgeInsets.only(top: spacingL),
                    child: BudgetProgressSection(),
                  );
                }),
                Obx(() {
                  if (cashflowController.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: EdgeInsets.only(top: spacingL),
                    child: BillsReminderSection(),
                  );
                }),

                // SETUP GUIDE
                Obx(() {
                  if (setupController.hasAccounts &&
                      setupController.hasCashflow) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: EdgeInsets.only(top: spacingL),
                    child: const FinancialSetupGuideCarousel(),
                  );
                }),

                // LEARNING
                Padding(
                  padding: EdgeInsets.only(top: spacingL),
                  child: LearningSection(
                    state: LearningSectionState.available,
                    contents: [
                      LearnThumbnail(
                        title: 'Why Financial Planning Matters',
                        onTap: () {
                          // AppSheets.learningSheets.openLearnArticle(
                          //   // 'https://ascendyfp.com/learn/why-financial-planning-matters',
                          // );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
