import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/enums/protection_profile_enum.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class ProtectionScoreContainerSection extends StatelessWidget {
  final ProtectionProfile profile;
  final int unmetGoals;

  const ProtectionScoreContainerSection({
    super.key,
    required this.profile,
    required this.unmetGoals,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSection(
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.text, colorScheme.gradient2],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              'Protection Score',
              style: AppTextStyle.titleL.copyWith(
                color: colorScheme.appInversedtextMuted,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.title,
                  style: AppTextStyle.displayL.copyWith(
                    color: colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$unmetGoals of 3 essential protection goals are not yet met.',
                  style: AppTextStyle.labelM.copyWith(
                    color: colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
