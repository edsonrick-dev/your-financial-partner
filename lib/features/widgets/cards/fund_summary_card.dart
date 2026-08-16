import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/home/controllers/home_controller.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class FundSummaryCard extends GetView<HomeController> {
  const FundSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AdaptivePressable(
      onTap: controller.toggleIsFundHidden,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: AppGradient.gradientA(colorScheme),
        ),
        padding: EdgeInsets.only(top: 24, bottom: 24, left: 24, right: 12),
        child: Column(
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
                      () => TweenAnimationBuilder<double>(
                        tween: Tween(
                          begin: 0,
                          end: controller.isFundHidden.value ? 8 : 0,
                        ),
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        builder: (context, blur, child) {
                          return AnimatedOpacity(
                            duration: const Duration(milliseconds: 180),
                            opacity: controller.isFundHidden.value ? 1 : 1,
                            child: ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: blur,
                                sigmaY: blur,
                              ),
                              child: child,
                            ),
                          );
                        },

                        child: Text(
                          availableFunds.abs().toCurrency(),
                          style: AppTextStyle.amountXL.copyWith(
                            color: availableFunds.isNegative
                                ? colorScheme.appOutflow
                                : colorScheme.appInversedtext,
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      width: 44,
                      height: 44,

                      child: Obx(
                        () => Icon(
                          controller.isFundHidden.value
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,

                          key: ValueKey(controller.isFundHidden.value),

                          size: 24,

                          color: colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
