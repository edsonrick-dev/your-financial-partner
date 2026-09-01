import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/app_scale.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_setup/financial_setup_controller.dart';
import 'package:getx_drift_app/features/home/controllers/home_controller.dart';
import 'package:getx_drift_app/features/home/views/section_views/budget_progress_section.dart';
import 'package:getx_drift_app/features/home/views/section_views/quick_actions_section.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/widgets/cards/fund_summary_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final spacingM = AppScale.x5;
    final spacingL = AppScale.x6;
    final colorScheme = context.colors;

    final setupController = Get.find<FinancialSetupController>();
    final cashflowController = Get.find<CashflowController>();

    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: topPadding),

              // HEADER
              AppSection(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning, Edson Rick!',
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
                        SizedBox(height: spacingM),
                        QuickActionSection(),
                      ],
                    ),
                  ),
                );
              }),

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
                        AppSheets.learningSheets.openLearnArticle(
                          'https://ascendyfp.com/learn/why-financial-planning-matters',
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spacingL),
            ],
          ),
        ),
      ),
    );
  }
}

enum GuideState {
  available,
  locked,
  completed;

  String get statusLabel => switch (this) {
    GuideState.available => 'In Progress',
    GuideState.locked => 'Locked',
    GuideState.completed => 'Completed',
  };
  IconData get statusIcon => switch (this) {
    GuideState.available => PhosphorIconsRegular.caretRight,
    GuideState.locked => PhosphorIconsFill.lock,
    GuideState.completed => PhosphorIconsRegular.check,
  };

  Color statusColor(BuildContext context) {
    final colorScheme = context.colors;

    return switch (this) {
      GuideState.available => colorScheme.appText,
      GuideState.locked => colorScheme.appOutflow,
      GuideState.completed => colorScheme.appInflow,
    };
  }

  bool get isLocked => this == GuideState.locked;

  bool get isCompleted => this == GuideState.completed;
}

class GetStartedTile extends StatelessWidget {
  const GetStartedTile({
    super.key,
    required this.title,
    required this.description,
    required this.iconColor,
    required this.icon,
    required this.guideState,
  });
  final String title;
  final String description;
  final Color iconColor;
  final IconData icon;
  final GuideState guideState;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final unavailable = guideState == GuideState.locked;
    return Opacity(
      opacity: unavailable ? 0.5 : 1,
      child: AdaptivePressable(
        onTap: unavailable ? null : () {},
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: guideState == GuideState.completed
                ? colorScheme.appInflow.withAlpha(36)
                : colorScheme.bgLight,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(icon, color: iconColor, size: 20),
                        Opacity(
                          opacity: 0.2,
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: iconColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title, style: AppTextStyle.titleM),
                                Text(
                                  description,
                                  style: AppTextStyle.bodyS.copyWith(
                                    color: colorScheme.appTextMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            guideState.statusIcon,
                            size: 16,
                            color: guideState.statusColor(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
