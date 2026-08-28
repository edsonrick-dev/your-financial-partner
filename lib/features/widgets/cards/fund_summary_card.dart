import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/home/controllers/home_controller.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class FundSummaryCard extends GetView<HomeController> {
  const FundSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Obx(
      () => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: AppGradient.gradientA(colorScheme),
        ),
        padding: const EdgeInsets.only(
          top: 24,
          bottom: 24,
          left: 24,
          right: 12,
        ),
        child: controller.hasAccounts.value
            ? _buildFilledView(context)
            : _buildEmptyState(context),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's get your finances ready",
          style: AppTextStyle.headlineL.copyWith(
            color: colorScheme.appInversedtext,
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'Add your accounts to start tracking your available funds, spending, and progress towards your financial goals.',
          style: AppTextStyle.bodyL.copyWith(
            color: colorScheme.appInversedtextMuted,
          ),
        ),

        const SizedBox(height: 24),

        AdaptivePressable(
          onTap: () {
            // Navigate to Add Account
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, color: colorScheme.appText),
                const SizedBox(width: 12),
                Text(
                  'Add an account',
                  style: AppTextStyle.titleL.copyWith(
                    color: colorScheme.appText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilledView(BuildContext context) {
    final colorScheme = context.colors;

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Funds',
          style: AppTextStyle.titleL.copyWith(
            color: colorScheme.appInversedtextMuted,
          ),
        ),

        StreamBuilder<double>(
          stream: controller.availableFundsStream,
          builder: (context, snapshot) {
            final availableFunds = snapshot.data ?? 0.0;

            return Row(
              children: [
                Obx(
                  () => SizedBox(
                    height: 40,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        AnimatedOpacity(
                          opacity: controller.isFundHidden.value ? 0 : 1,
                          duration: const Duration(milliseconds: 180),
                          child: Text(
                            availableFunds.abs().toCurrency(),
                            style: AppTextStyle.amountXL.copyWith(
                              color: availableFunds.isNegative
                                  ? colorScheme.appOutflow
                                  : colorScheme.appInversedtext,
                            ),
                          ),
                        ),

                        AnimatedOpacity(
                          opacity: controller.isFundHidden.value ? 1 : 0,
                          duration: const Duration(milliseconds: 180),
                          child: Text(
                            '••••••',
                            style: AppTextStyle.amountXL.copyWith(
                              color: colorScheme.appInversedtext,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                SizedBox(
                  width: 44,
                  height: 44,
                  child: Obx(
                    () => AdaptivePressable(
                      onTap: controller.toggleIsFundHidden,
                      child: Icon(
                        controller.isFundHidden.value
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                        size: 24,
                        color: colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
