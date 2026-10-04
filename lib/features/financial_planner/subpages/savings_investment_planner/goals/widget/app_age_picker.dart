import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class AppAgePickerSheet extends StatefulWidget {
  const AppAgePickerSheet({
    super.key,
    required this.title,
    required this.initialAge,
    required this.minAge,
    required this.maxAge,
    required this.onContinue,
  });

  final String title;
  final int initialAge;
  final int minAge;
  final int maxAge;
  final ValueChanged<int> onContinue;

  @override
  State<AppAgePickerSheet> createState() => _AppAgePickerSheetState();
}

class _AppAgePickerSheetState extends State<AppAgePickerSheet> {
  late int selectedAge;

  @override
  void initState() {
    super.initState();
    selectedAge = widget.initialAge;
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      adaptiveHeight: true,
      title: widget.title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HorizontalAgePicker(
            initialAge: selectedAge,
            minAge: widget.minAge,
            maxAge: widget.maxAge,
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
                widget.onContinue(selectedAge);
                Get.back();
              },
            ),
          ),

          SizedBox(height: context.bottomPaddingSub),
        ],
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
                  child: AdaptivePressable(
                    onTap: () => _selectAgeAndScroll(age),
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 150),
                        style: isSelected
                            ? AppTextStyle.amountXL.copyWith(
                                color: colorScheme.appText,
                              )
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
