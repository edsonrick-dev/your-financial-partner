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
    return Container(
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
                  // Obx(
                  //   () => AnimatedSwitcher(
                  //     duration: const Duration(milliseconds: 250),
                  //     // switchInCurve: Curves.easeOut,
                  //     // switchOutCurve: Curves.easeIn,
                  //     // transitionBuilder: (child, animation) {
                  //     //   return FadeTransition(
                  //     //     opacity: animation,
                  //     //     child: SlideTransition(
                  //     //       position: Tween<Offset>(
                  //     //         // begin: const Offset(0, 0.15),
                  //     //         end: Offset.zero,
                  //     //       ).animate(animation),
                  //     //       child: child,
                  //     //     ),
                  //     //   );
                  //     // },
                  //     child: Text(
                  //       controller.isFundHidden.value
                  //           ? '••••••'
                  //           : availableFunds.abs().toCurrency(),
                  //       key: ValueKey(controller.isFundHidden.value),
                  //       style: AppTextStyle.amountXL.copyWith(
                  //         color: availableFunds.isNegative
                  //             ? colorScheme.appOutflow
                  //             : colorScheme.appInversedtext,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Obx(
                    () => SizedBox(
                      height: 40, // match your amount text height
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

                          key: ValueKey(controller.isFundHidden.value),

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
      ),
    );
  }
}
