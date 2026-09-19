import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_scale.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
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
                _greetingSection(colorScheme),
                // AppSection(
                //   child: Column(
                //     spacing: 8,
                //     children: AppIcons.categories.availableIcons.map((item) {
                //       return Row(
                //         children: [
                //           Icon(item.icon),
                //           const SizedBox(width: 8),
                //           Expanded(child: Text(item.key)),
                //           const SizedBox(width: 8),
                //           Text(item.group.name),
                //         ],
                //       );
                //     }).toList(),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(top: spacingL),
                  child: AppSection(
                    child: Column(children: [FundSummaryCard()]),
                  ),
                ),
                SizedBox(height: 20),
                AppSection(
                  sectionTitle: "This Month's Finances",
                  child: Obx(() {
                    final index = controller.selectedBudgetIndex.value;

                    return Column(
                      children: [
                        _Selector(
                          selectedIndex: index,
                          onChanged: controller.selectBudget,
                        ),

                        const SizedBox(height: 12),

                        AnimatedSize(
                          duration: const Duration(milliseconds: 160),
                          curve: Curves.easeInOut,
                          alignment: Alignment.topCenter,
                          child: index == 0
                              ? const BudgetProgressSection(
                                  key: ValueKey('budget'),
                                )
                              : const BillsReminderSection(
                                  key: ValueKey('bills'),
                                ),
                        ),
                      ],
                    );
                  }),
                ),

                Obx(() {
                  final recommendations = learnEngine.getRecommendedContent(
                    state: financialProfileController.financialState,
                    context: LearnContext.home,
                    contents: learnContentLibrary,
                  );
                  if (recommendations.isNotEmpty) {
                    return Padding(
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
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
              ],
            ),
          ),
        ),
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

class _Selector extends StatelessWidget {
  const _Selector({required this.selectedIndex, required this.onChanged});

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.bgLight,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colorScheme.appBorderMuted),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SelectorItem(
              title: 'My Budget',
              selected: selectedIndex == 0,
              onTap: () => onChanged(0),
            ),
          ),
          Expanded(
            child: _SelectorItem(
              title: 'My Bills',
              selected: selectedIndex == 1,
              onTap: () => onChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectorItem extends StatelessWidget {
  const _SelectorItem({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.pageShifterFillSelected
              : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyle.titleM.copyWith(
            color: selected
                ? colorScheme.pageShifterTextSelected
                : colorScheme.pageShifterTextUnselected,
          ),
        ),
      ),
    );
  }
}
