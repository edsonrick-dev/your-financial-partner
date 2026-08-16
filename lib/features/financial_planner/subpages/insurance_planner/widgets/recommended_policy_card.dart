import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/default_data/default_policy_recommendations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RecommendedPolicyCard extends StatelessWidget {
  final InsurancePolicyRecommendation policy;
  const RecommendedPolicyCard({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AdaptivePressable(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 120,
        width: 300,
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: 0.2,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.appInfo,
                        ),
                      ),
                    ),
                    Icon(
                      PhosphorIconsRegular.article,
                      color: colorScheme.appInfo,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${policy.insuranceCompany} ${policy.policyName}',
                    style: AppTextStyle.titleM,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  PhosphorIconsRegular.caretRight,
                  color: colorScheme.text,
                  size: 16,
                ),
              ],
            ),
            //Description
            const SizedBox(height: 8),
            Text(
              policy.description,
              style: AppTextStyle.bodyS,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            // Container(
            //   width: double.infinity,
            //   height: 32,
            //   decoration: BoxDecoration(
            //     color: colorScheme.appInfo,
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Center(
            //     child: Text(
            //       'View Details',
            //       style: AppTextStyle.titleM.copyWith(color: Colors.white),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
