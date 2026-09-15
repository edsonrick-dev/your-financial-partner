import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/onboarding/enums/onboarding_selection_type.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_option_tile.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            onPressed: controller.previousPage,
            icon: Icon(PhosphorIconsRegular.arrowLeft),
          ),
          title: Text("Ascend's Assessment", style: AppTextStyle.headlineL),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Obx(
                () => AppSection(
                  child: Row(
                    spacing: 4,
                    children: List.generate(
                      controller.totalPages,
                      (index) => Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: index <= controller.currentPage.value
                                ? colorScheme.appText
                                : colorScheme.appBorder,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _NamePage(),
                    _GoalsPage(),
                    _ConfidencePage(),
                    _ManagementPage(),
                  ],
                ),
              ),

              Obx(
                () => AppSection(
                  child: AppButton(
                    text: controller.isLastPage
                        ? 'Finish assessment'
                        : 'Continue',
                    onTap: controller.canContinue ? controller.nextPage : null,
                  ),
                ),
              ),

              // SizedBox(height: context.bottomPaddingSub),
            ],
          ),
        ),
      ),
    );
  }
}

class _NamePage extends GetView<OnboardingController> {
  const _NamePage();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AppSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('What should we call you?', style: AppTextStyle.displayM),

            const SizedBox(height: 24),

            AppTextField(
              label: 'Name',
              focusNode: controller.nameFocusNode,
              controller: controller.nameController,
              onChanged: (value) {
                controller.name.value = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalsPage extends GetView<OnboardingController> {
  const _GoalsPage();

  static const goals = [
    'Managing my spending',
    'Building an emergency fund',
    'Paying off debt',
    'Building wealth',
    'Protecting myself and my family',
    'Planning for my financial future',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What would you like Ascend to help you improve?',
                style: AppTextStyle.displayM,
              ),

              const SizedBox(height: 20),

              Text('Select all that apply.', style: AppTextStyle.bodyL),
            ],
          ),
        ),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            itemCount: goals.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final goal = goals[index];

              return Obx(
                () => OnboardingOptionTile(
                  title: goal,
                  isSelected: controller.isImprovementAreaSelected(goal),
                  onTap: () {
                    controller.toggleImprovementArea(goal);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ConfidencePage extends GetView<OnboardingController> {
  const _ConfidencePage();

  static const confidenceLevels = [
    'I’m just getting started',
    'I understand the basics',
    'I actively manage my finances',
    'I feel confident managing my finances',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How confident are you managing your finances?',
                style: AppTextStyle.displayM,
              ),

              const SizedBox(height: 20),

              Text('Choose one.', style: AppTextStyle.bodyL),
            ],
          ),
        ),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            itemCount: confidenceLevels.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final level = confidenceLevels[index];

              return Obx(
                () => OnboardingOptionTile(
                  selectionType: OnboardingSelectionType.single,
                  title: level,
                  isSelected: controller.selectedConfidence.value == level,
                  onTap: () {
                    controller.selectConfidence(level);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ManagementPage extends GetView<OnboardingController> {
  const _ManagementPage();

  static const options = [
    "I don't really have a system",
    'I mostly keep it in my head',
    'I use notes or spreadsheets',
    'I use a finance/budgeting app',
    'I work with a financial professional',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How do you currently manage your finances?',
                style: AppTextStyle.displayM,
              ),

              const SizedBox(height: 20),

              Text('Choose one.', style: AppTextStyle.bodyL),
            ],
          ),
        ),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            itemCount: options.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final option = options[index];

              return Obx(
                () => OnboardingOptionTile(
                  selectionType: OnboardingSelectionType.single,
                  title: option,
                  isSelected: controller.currentManagement.value == option,
                  onTap: () {
                    controller.selectCurrentManagement(option);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class OnboardingView1 extends StatelessWidget {
  const OnboardingView1({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          // width: double.infinity,
          decoration: BoxDecoration(color: const Color(0xFF141C29)),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Growth pattern
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Image.asset(
                  'assets/icons/ascendyfp_growth_pattern_white.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  children: [
                    const Spacer(),

                    // Brand
                    Image.asset(
                      'assets/icons/ascendyfp_brand_lockup.png',
                      width: 270,
                      fit: BoxFit.contain,
                    ),

                    const Spacer(flex: 2),

                    // CTA
                    AppButton(
                      isInversed: true,
                      text: 'Get started',
                      onTap: () {
                        Get.toNamed(Routes.ONBOARDING_FIRST_QUESTION);
                      },
                    ),

                    SizedBox(height: bottomPadding),
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
