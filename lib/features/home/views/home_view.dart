import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/app_scale.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/home/controllers/home_controller.dart';
import 'package:getx_drift_app/features/home/views/section_views/budget_progress_section.dart';
import 'package:getx_drift_app/features/home/views/section_views/quick_actions_section.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/widgets/cards/fund_summary_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final spacingM = AppScale.x5;
    final spacingL = AppScale.x6;
    final colorScheme = context.colors;
    final budgetController = Get.find<CashflowController>();
    final hasBudget = budgetController.currentMonthBudgetItems.isNotEmpty;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: topPadding),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSection(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning, Edson Rick!',
                          style: AppTextStyle.headlineL,
                        ),
                        Text(
                          '''Let’s make today a great financial day.''',
                          style: AppTextStyle.labelM.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (controller.hasAccounts.value)
                    AppSection(
                      child: Column(
                        children: [
                          SizedBox(height: spacingM),
                          FundSummaryCard(),
                          SizedBox(height: spacingM),
                          QuickActionSection(),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: spacingL),
              AppSection(
                // sectionTitle: 'Get Started',
                child: AppSectionBody(
                  child: Column(
                    children: [
                      GetStartedTile(
                        title: 'Add your first account',
                        description:
                            'Add your cash, bank, e-wallet, or other accounts to track what you own.',
                        icon: PhosphorIconsRegular.creditCard,
                        iconColor: colorScheme.appInfo,
                        guideState: GuideState.completed,
                      ),
                      GetStartedTile(
                        title: 'Set up your monthly cashflow',
                        description:
                            'Plan your income and expenses, including your monthly budget.',
                        icon: PhosphorIconsRegular.calendar,
                        iconColor: Colors.orange,
                        guideState: GuideState.available,
                      ),
                      GetStartedTile(
                        title: 'Set up your bills & reminders',
                        description:
                            'Add recurring bills and payment dates so you know what’s coming up.',
                        icon: PhosphorIconsRegular.bell,
                        iconColor: colorScheme.appInfo,
                        guideState: GuideState.locked,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: spacingL),
              if (hasBudget) BudgetProgressSection(),

              LearningSection(
                state: LearningSectionState.available,
                contents: [
                  LearnThumbnail(
                    title: 'Why Financial Planning Matters',
                    onTap: () {
                      AppSheets.learningSheets.whyFinancialPlanningMatters();
                    },
                  ),
                ],
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

class AccountsOverviewTile extends StatelessWidget {
  final String accountName;
  final double value;
  final int count;
  final String iconKey;
  final bool? flowPositive;
  const AccountsOverviewTile({
    super.key,
    required this.accountName,
    required this.value,
    required this.count,
    required this.iconKey,
    this.flowPositive = true,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    String accountCount;
    if (count == 1) {
      accountCount = '$count account';
    } else {
      accountCount = '$count accounts';
    }

    Color valueColor;
    value >= 0
        ? valueColor = colorScheme.appText
        : valueColor = colorScheme.appOutflow;

    return Container(
      constraints: BoxConstraints(minHeight: 44),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                AppIcons.categories.resolve(iconKey),
                color: colorScheme.appSuccess,
              ),
              Opacity(
                opacity: 0.2,
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: colorScheme.appSuccess,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      accountName,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      accountCount,
                      style: TextStyle(color: colorScheme.appTextMuted),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      value.toCompactCurrency(kThreshold: 1000000),
                      style: TextStyle(
                        fontSize: 16,
                        color: valueColor,
                        fontWeight: FontWeight.w500,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(
                      PhosphorIconsRegular.caretRight,
                      size: 16,
                      color: colorScheme.appTextMuted,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
