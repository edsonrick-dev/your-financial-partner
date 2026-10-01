import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RetirementFundNeed extends GetView<FinancialProfileController> {
  const RetirementFundNeed({super.key});

  @override
  Widget build(BuildContext context) {
    final type = GoalType.retirement;
    final colorScheme = context.colors;

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppSection(
              child: AppSectionBody(
                padding: 24,
                child: Column(
                  children: [
                    Icon(type.icon, size: 60),
                    SizedBox(height: 16),

                    Text(
                      'Plan Your Retirement',
                      style: AppTextStyle.headlineM,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Let’s determine how much you may need to fund the lifestyle you want in retirement.',
                      style: AppTextStyle.bodyL,
                      textAlign: TextAlign.center,
                    ),

                    // Text(
                    //   'Why Plan Retirement?',
                    //   style: AppTextStyle.headlineM,
                    //   textAlign: TextAlign.center,
                    // ),
                    // SizedBox(height: 12),
                    // Text(
                    //   type.description,
                    //   style: AppTextStyle.bodyL,
                    //   textAlign: TextAlign.justify,
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            AppSection(
              child: AppSectionBody(
                padding: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text('How old are you now?', style: AppTextStyle.titleL),

                    const SizedBox(height: 8),

                    Text(
                      'This determines how many years you have to build your retirement fund.',
                      style: AppTextStyle.bodyM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                    SizedBox(height: 16),
                    AdaptivePressable(
                      onTap: () {
                        var selectedAge = controller.currentAge.value;

                        Get.bottomSheet(
                          AppSheet(
                            adaptiveHeight: true,
                            title: 'Select your age',
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    HorizontalAgePicker(
                                      initialAge: selectedAge,
                                      minAge: 18,
                                      maxAge: 80,
                                      onChanged: (age) {
                                        setState(() {
                                          selectedAge = age;
                                        });
                                      },
                                    ),

                                    const SizedBox(height: 16),

                                    AppSection(
                                      child: AppButton(
                                        text: 'Continue',
                                        onTap: () {
                                          controller.currentAge.value =
                                              selectedAge;

                                          Get.back();
                                        },
                                      ),
                                    ),

                                    SizedBox(height: context.bottomPaddingSub),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.bg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 44,
                              width: 44,
                              child: Icon(PhosphorIconsRegular.calendarDots),
                            ),

                            const SizedBox(width: 8),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current age',
                                  style: AppTextStyle.titleS.copyWith(
                                    color: colorScheme.appTextMuted,
                                  ),
                                ),

                                Obx(
                                  () => Text(
                                    '${controller.currentAge.value} years old',
                                    style: AppTextStyle.amountL,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            AppSection(
              child: AppSectionBody(
                padding: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Text(
                      'When do you plan to retire?',
                      style: AppTextStyle.titleL,
                    ),

                    Text(
                      'Your retirement age determines how long your savings have to grow before you begin withdrawing from them.',
                      style: AppTextStyle.bodyM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),

                    AdaptivePressable(
                      onTap: () {
                        var selectedAge = controller.retirementAge.value;

                        Get.bottomSheet(
                          AppSheet(
                            adaptiveHeight: true,
                            title: 'Select retirement age',
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    HorizontalAgePicker(
                                      initialAge: selectedAge,
                                      minAge: 40,
                                      maxAge: 80,
                                      onChanged: (age) {
                                        setState(() {
                                          selectedAge = age;
                                        });
                                      },
                                    ),

                                    const SizedBox(height: 16),

                                    AppSection(
                                      child: AppButton(
                                        text: 'Continue',
                                        onTap: () {
                                          controller.retirementAge.value =
                                              selectedAge;

                                          Get.back();
                                        },
                                      ),
                                    ),

                                    SizedBox(height: context.bottomPaddingSub),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.bg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 44,
                              width: 44,
                              child: Icon(PhosphorIconsRegular.calendarDots),
                            ),

                            const SizedBox(width: 8),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Target retirement age',
                                  style: AppTextStyle.titleS.copyWith(
                                    color: colorScheme.appTextMuted,
                                  ),
                                ),

                                Obx(
                                  () => Text(
                                    '${controller.retirementAge.value} years old',
                                    style: AppTextStyle.amountL,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(() {
                      final yearsToRetirement = controller.yearsToRetirement;
                      return Text(
                        '${(yearsToRetirement.toStringAsFixed(0))} years until retirement',
                      );
                    }),
                    Obx(() {
                      final inflatedLifestyleAtRetirement =
                          controller.futureAnnualRetirementLifestyle;
                      return Text((inflatedLifestyleAtRetirement.toCurrency()));
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            AppSection(
              child: AppSectionBody(
                padding: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Text(
                      'How long should your retirement fund last?',
                      style: AppTextStyle.titleL,
                    ),

                    Text(
                      'Choose the age your retirement savings should support you until.',
                      style: AppTextStyle.bodyM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),

                    AdaptivePressable(
                      onTap: () {
                        var selectedAge = controller.retirementFundEndAge.value;

                        Get.bottomSheet(
                          AppSheet(
                            adaptiveHeight: true,
                            title: 'Select fund end age',
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    HorizontalAgePicker(
                                      initialAge: selectedAge,
                                      minAge: controller.retirementAge.value,
                                      maxAge: 100,
                                      onChanged: (age) {
                                        setState(() {
                                          selectedAge = age;
                                        });
                                      },
                                    ),

                                    const SizedBox(height: 16),

                                    AppSection(
                                      child: AppButton(
                                        text: 'Continue',
                                        onTap: () {
                                          controller
                                                  .retirementFundEndAge
                                                  .value =
                                              selectedAge;

                                          Get.back();
                                        },
                                      ),
                                    ),

                                    SizedBox(height: context.bottomPaddingSub),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.bg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 44,
                              width: 44,
                              child: Icon(PhosphorIconsRegular.calendarDots),
                            ),

                            const SizedBox(width: 8),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fund should last until',
                                  style: AppTextStyle.titleS.copyWith(
                                    color: colorScheme.appTextMuted,
                                  ),
                                ),

                                Obx(
                                  () => Text(
                                    'Age ${controller.retirementFundEndAge.value}',
                                    style: AppTextStyle.amountL,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            AppSection(
              child: AppSectionBody(
                padding: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What Lifestyle Do You Want in Retirement?',
                      style: AppTextStyle.titleL,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Choose how much of your current lifestyle you expect to maintain in retirement.',
                      style: AppTextStyle.bodyM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Obx(
                      () => Column(
                        children: [
                          RetirementLifestyleOption(
                            percentage: 1.0,
                            title: 'Maintain my current lifestyle',
                            amount: controller.annualBudget,
                            selected:
                                controller.retirementLifestyleShare.value ==
                                1.0,
                            onTap: () {
                              controller.retirementLifestyleShare.value = 1.0;
                            },
                          ),

                          const SizedBox(height: 8),

                          RetirementLifestyleOption(
                            percentage: 0.8,
                            title: 'Spend somewhat less',
                            amount: controller.annualBudget * 0.8,
                            selected:
                                controller.retirementLifestyleShare.value ==
                                0.8,
                            onTap: () {
                              controller.retirementLifestyleShare.value = 0.8;
                            },
                          ),

                          const SizedBox(height: 8),

                          RetirementLifestyleOption(
                            percentage: 0.6,
                            title: 'Spend considerably less',
                            amount: controller.annualBudget * 0.6,
                            selected:
                                controller.retirementLifestyleShare.value ==
                                0.6,
                            onTap: () {
                              controller.retirementLifestyleShare.value = 0.6;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: context.bottomPaddingSub),
            SizedBox(height: context.bottomPaddingSub),
          ],
        ),
      ),
    );
  }
}

class RetirementAgePicker extends StatefulWidget {
  const RetirementAgePicker({
    super.key,
    required this.initialAge,
    required this.onChanged,
  });

  final int initialAge;
  final ValueChanged<int> onChanged;

  @override
  State<RetirementAgePicker> createState() => _RetirementAgePickerState();
}

class _RetirementAgePickerState extends State<RetirementAgePicker> {
  late int selectedAge;

  @override
  void initState() {
    super.initState();
    selectedAge = widget.initialAge;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 41, // 50–90
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final age = 50 + index;
          final isSelected = age == selectedAge;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedAge = age;
              });

              widget.onChanged(age);
            },
            child: SizedBox(
              width: 56,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: isSelected ? 56 : 44,
                    width: isSelected ? 56 : 44,
                    decoration: BoxDecoration(
                      color: isSelected ? colorScheme.primary : colorScheme.bg,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$age',
                      style: isSelected
                          ? AppTextStyle.titleL
                          : AppTextStyle.titleM.copyWith(
                              color: colorScheme.appTextMuted,
                            ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (isSelected)
                    Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HorizontalAgePicker extends StatefulWidget {
  const HorizontalAgePicker({
    super.key,
    required this.initialAge,
    this.minAge = 40,
    this.maxAge = 80,
    required this.onChanged,
  });

  final int initialAge;
  final int minAge;
  final int maxAge;
  final ValueChanged<int> onChanged;

  @override
  State<HorizontalAgePicker> createState() => _HorizontalAgePickerState();
}

class _HorizontalAgePickerState extends State<HorizontalAgePicker> {
  static const double itemWidth = 60;

  late final ScrollController _scrollController;
  late int selectedAge;

  @override
  void initState() {
    super.initState();

    selectedAge = widget.initialAge;

    _scrollController = ScrollController(
      initialScrollOffset: (widget.initialAge - widget.minAge) * itemWidth,
    );

    _scrollController.addListener(_handleScroll);
  }

  bool _isAnimatingToSelection = false;

  void _handleScroll() {
    if (_isAnimatingToSelection) return;

    final index = (_scrollController.offset / itemWidth).round();

    final age = (widget.minAge + index).clamp(widget.minAge, widget.maxAge);

    _selectAge(age);
  }

  Future<void> _selectAgeAndScroll(int age) async {
    _selectAge(age);

    final index = age - widget.minAge;
    final targetOffset = index * itemWidth;

    _isAnimatingToSelection = true;

    await _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
    );

    _isAnimatingToSelection = false;
  }

  void _selectAge(int age) {
    if (age == selectedAge) return;

    setState(() {
      selectedAge = age;
    });

    widget.onChanged(age);
  }

  void _snapToNearest() {
    final index = (_scrollController.offset / itemWidth).round();
    final targetOffset = index * itemWidth;

    // Already at the correct position.
    if ((_scrollController.offset - targetOffset).abs() < 0.5) {
      return;
    }

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = (constraints.maxWidth - itemWidth) / 2;

        return NotificationListener<ScrollEndNotification>(
          onNotification: (_) {
            _snapToNearest();
            return false;
          },
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              itemCount: widget.maxAge - widget.minAge + 1,
              itemBuilder: (context, index) {
                final age = widget.minAge + index;
                final isSelected = age == selectedAge;

                return SizedBox(
                  width: itemWidth,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _selectAgeAndScroll(age),
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 150),
                        style: isSelected
                            ? AppTextStyle.amountXL
                            : AppTextStyle.titleM.copyWith(
                                color: colorScheme.appTextMuted,
                              ),
                        child: Text('$age'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class RetirementLifestyleOption extends StatelessWidget {
  const RetirementLifestyleOption({
    super.key,
    required this.percentage,
    required this.title,
    required this.amount,
    required this.selected,
    required this.onTap,
  });

  final double? percentage;
  final String title;
  final double? amount;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primary.withValues(alpha: 0.08)
              : colorScheme.bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected
                ? colorScheme.primary
                : colorScheme.appTextMuted.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  percentage == null
                      ? 'Custom'
                      : '${(percentage! * 100).round()}%',
                  style: AppTextStyle.titleL,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle.titleS),

                  if (amount != null)
                    Text(
                      amount!.toCurrency(),
                      style: AppTextStyle.amountL.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                ],
              ),
            ),

            Icon(
              selected
                  ? PhosphorIconsFill.checkCircle
                  : PhosphorIconsRegular.circle,
            ),
          ],
        ),
      ),
    );
  }
}
