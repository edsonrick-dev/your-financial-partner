import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/home/widgets/budget_progress_bar.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'dart:math' as math;

import 'package:phosphor_flutter/phosphor_flutter.dart';

class BudgetGridView extends StatelessWidget {
  const BudgetGridView({
    super.key,
    required this.budget,
    required this.consumption,
    required this.budgetName,
    required this.iconKey,
    required this.categoryId,
  });

  final double budget;
  final double consumption;
  final String budgetName;
  final String iconKey;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    double remainingBalance = budget - consumption;
    bool isOverBudget = remainingBalance < 0;
    double consumptionPercentage = budget <= 0
        ? 0
        : (consumption / budget).clamp(0.0, 1.0);

    Color progressColor;
    if (consumptionPercentage >= 1) {
      progressColor = colorScheme.appOutflow;
    } else if (consumptionPercentage >= 0.8) {
      progressColor = colorScheme.appAccent;
    } else {
      progressColor = colorScheme.appInflow;
    }

    return AdaptivePressable(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        AppSheets.transaction.spend(categoryId: categoryId);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(24),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withValues(alpha: 0.06),
          //     blurRadius: 8,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
          // border: Border.all(color: colorScheme.appBorder),
        ),
        constraints: BoxConstraints(minHeight: 60),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(AppIcons.categories.resolve(iconKey), size: 16),
                    const SizedBox(width: 4),
                    Text(budgetName, style: AppTextStyle.bodyS, maxLines: 1),
                  ],
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${remainingBalance.abs().toCurrency()} ${isOverBudget ? 'over' : 'left'}',
                  style: AppTextStyle.amountXS.copyWith(color: progressColor),
                ),
              ),
              SizedBox(width: 4),
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    '${(consumptionPercentage * 100).round()}%',
                    style: AppTextStyle.amountXS,
                  ),
                  CustomPaint(
                    size: const Size(60, 60),
                    painter: BudgetConsumptionGuagePainter(
                      progress: consumptionPercentage,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),

              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      consumption.toCurrency(),
                      style: AppTextStyle.amountXS,
                    ),
                    Text(
                      ' / ${budget.toCurrency()}',
                      style: AppTextStyle.amountXS.copyWith(
                        color: colorScheme.appTextMuted.withAlpha(160),
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

class BudgetListView extends StatelessWidget {
  const BudgetListView({
    super.key,
    required this.budget,
    required this.consumption,
    required this.budgetName,
    required this.iconKey,
    required this.categoryId,
  });

  final double budget;
  final double consumption;
  final String budgetName;
  final String iconKey;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    double remainingBalance = budget - consumption;
    bool isOverBudget = remainingBalance < 0;
    double consumptionPercentage = budget <= 0
        ? 0
        : (consumption / budget).clamp(0.0, 1.0);

    Color progressColor;
    if (consumptionPercentage >= 1) {
      progressColor = colorScheme.appOutflow;
    } else if (consumptionPercentage >= 0.8) {
      progressColor = colorScheme.appAccent;
    } else {
      progressColor = colorScheme.appInflow;
    }

    // Color iconColor = colorScheme.appInfo;
    return AdaptivePressable(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        AppSheets.transaction.spend(categoryId: categoryId);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        constraints: BoxConstraints(minHeight: 60),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Icon(
                      AppIcons.categories.resolve(iconKey),
                      // color: iconColor,
                    ),
                    Opacity(
                      opacity: 0.2,
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: iconColor,
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(budgetName, style: AppTextStyle.bodyM),
                          Spacer(),
                          Text(
                            '${remainingBalance.abs().toCurrency()} ${isOverBudget ? 'over' : 'left'}',
                            style: TextStyle(
                              color: progressColor,
                              fontWeight: FontWeight.w500,
                              fontFeatures: [FontFeature.tabularFigures()],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            consumption.toCurrency(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFeatures: [FontFeature.tabularFigures()],
                            ),
                          ),

                          Text(
                            ' / ${budget.toCurrency()}',
                            style: TextStyle(
                              color: colorScheme.appTextMuted,
                              fontFeatures: [FontFeature.tabularFigures()],
                            ),
                          ),
                          Spacer(),

                          Text(
                            '${(consumptionPercentage * 100).round()}%',
                            style: TextStyle(
                              color: colorScheme.appTextMuted,
                              fontWeight: FontWeight.w500,
                              fontFeatures: [FontFeature.tabularFigures()],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      BudgetProgressBar(
                        progress: consumptionPercentage,
                        // marker: 0.90, // optional
                        color: progressColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BudgetConsumptionGuagePainter extends CustomPainter {
  final double progress;

  const BudgetConsumptionGuagePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 8.0;

    final center = Offset(size.width / 2, size.height / 2);

    final radius = (size.width / 2) - strokeWidth;

    final rect = Rect.fromCircle(center: center, radius: radius);

    const gapAngle = math.pi * 0.4; // 72°
    const sweepAngle = (math.pi * 2) - gapAngle;
    const startAngle = math.pi / 2 + (gapAngle / 2);

    final consumption = progress.clamp(0.0, 1.0);

    // ----------------------------------------------------------
    // Consumption color
    // ----------------------------------------------------------

    const green = Color(0xFF16A34A);
    const yellow = Color(0xFFEAB308);
    const orange = Color(0xFFF97316);
    const red = Color(0xFFDC2626);

    Color consumptionColor;

    if (consumption <= 0.5) {
      // 0% → 50%
      // Green → Yellow
      consumptionColor = Color.lerp(green, yellow, consumption / 0.5)!;
    } else if (consumption <= 0.8) {
      // 50% → 80%
      // Yellow → Orange
      consumptionColor = Color.lerp(yellow, orange, (consumption - 0.5) / 0.3)!;
    } else {
      // 80% → 100%
      // Orange → Red
      consumptionColor = Color.lerp(orange, red, (consumption - 0.8) / 0.2)!;
    }

    // ----------------------------------------------------------
    // Background
    // ----------------------------------------------------------

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = Colors.black.withValues(alpha: 0.06);

    canvas.drawArc(rect, startAngle, sweepAngle, false, backgroundPaint);

    // ----------------------------------------------------------
    // Progress
    // ----------------------------------------------------------

    if (progress > 0) {
      final progressPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..color = consumptionColor;

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle * consumption,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant BudgetConsumptionGuagePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

enum DisplayMode { grid, list }

class DisplayModeToggle extends StatelessWidget {
  const DisplayModeToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final DisplayMode value;
  final ValueChanged<DisplayMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Padding(
      padding: EdgeInsetsGeometry.only(right: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.appBorderMuted),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ModeButton(
              regularIcon: PhosphorIconsRegular.list,
              fillIcon: PhosphorIconsFill.list,
              selected: value == DisplayMode.list,
              onTap: () => onChanged(DisplayMode.list),
              name: 'List',
            ),
            _ModeButton(
              regularIcon: PhosphorIconsRegular.squaresFour,
              fillIcon: PhosphorIconsFill.squaresFour,
              selected: value == DisplayMode.grid,
              onTap: () => onChanged(DisplayMode.grid),
              name: 'Grid',
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.regularIcon,
    required this.fillIcon,
    required this.selected,
    required this.onTap,
    this.name,
  });

  final IconData regularIcon;
  final IconData fillIcon;
  final bool selected;
  final VoidCallback onTap;
  final String? name;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 8),

        decoration: BoxDecoration(
          color: selected
              ? colorScheme.pageShifterFillSelected
              : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              Icon(
                selected ? fillIcon : regularIcon,
                size: 18,
                color: selected
                    ? colorScheme.pageShifterTextSelected
                    : colorScheme.appTextMuted,
              ),

              if (name != null)
                Text(
                  name!,
                  style: AppTextStyle.labelS.copyWith(
                    color: selected
                        ? colorScheme.pageShifterTextSelected
                        : colorScheme.appText,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
