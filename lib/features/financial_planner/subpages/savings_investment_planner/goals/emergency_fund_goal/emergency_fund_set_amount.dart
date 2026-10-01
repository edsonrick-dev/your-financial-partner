import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EmergencyFundSetAmount extends StatelessWidget {
  const EmergencyFundSetAmount({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppSection(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Set aside amount from your accounts',
                          style: AppTextStyle.titleL,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Select which payment accounts to use for your emergency fund '
                          'and how much is set aside.',
                          style: AppTextStyle.bodyM,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'You can adjust this anytime.',
                          style: AppTextStyle.bodyM.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                        SizedBox(height: 16),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: colorScheme.bgLight,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(PhosphorIconsRegular.wallet),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          'BPI Savings',
                                          style: AppTextStyle.titleL,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        0.toCurrency(),
                                        style: AppTextStyle.amountL,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${120000.toCurrency()} available',
                                          style: AppTextStyle.amountM,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          AppSection(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.bg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total amount set', style: AppTextStyle.titleM),
                  Text(30000.toCurrency(), style: AppTextStyle.amountXL),
                  Text(
                    'from n accounts',
                    style: AppTextStyle.titleM.copyWith(
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
