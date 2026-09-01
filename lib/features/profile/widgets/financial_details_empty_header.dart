import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class FinancialDetailsEmptyHeader extends StatelessWidget {
  final String text;
  final String description;
  final String instruction;
  const FinancialDetailsEmptyHeader({
    super.key,
    required this.text,
    required this.description,
    required this.instruction,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppGradient.gradientA(colorScheme),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: AppTextStyle.headlineL.copyWith(
              color: colorScheme.appInversedtext,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            description,
            style: AppTextStyle.bodyM.copyWith(
              color: colorScheme.appInversedtext,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            instruction,
            style: AppTextStyle.bodyM.copyWith(
              color: colorScheme.appInversedtextMuted,
            ),
          ),
        ],
      ),
    );
  }
}
