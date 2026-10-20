import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class InsurancePolicySummarySection extends StatelessWidget {
  const InsurancePolicySummarySection({
    super.key,
    required this.issuer,
    required this.name,
    required this.faceValue,
  });

  final String issuer;
  final String name;
  final double faceValue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppGradientCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  issuer,
                  style: AppTextStyle.titleM.copyWith(
                    color: colorScheme.appInversedtextMuted,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              AdaptivePressable(
                child: SizedBox(
                  // height: 44,
                  width: 44,
                  child: Icon(
                    Icons.more_horiz,
                    color: colorScheme.appInversedtext,
                  ),
                ),
              ),
            ],
          ),
          Text(
            name,
            style: AppTextStyle.headlineM.copyWith(
              color: colorScheme.appInversedtextMuted,
            ),
          ),
          Text(
            faceValue.toCurrency(),
            style: AppTextStyle.amountL.copyWith(
              color: colorScheme.appInversedtextMuted,
            ),
          ),
          SizedBox(height: 8),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Term',
                      style: AppTextStyle.labelS.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),

                    Text(
                      '20-Year Pay',
                      style: AppTextStyle.bodyS.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next Due',
                      style: AppTextStyle.labelS.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),

                    Text(
                      'December 6, 1997',
                      style: AppTextStyle.bodyS.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
