import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSection(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: AppGradient.gradientA(colorScheme),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.appInversedtext,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                // spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      'Juan Dela Cruz',
                      style: AppTextStyle.headlineM.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      'juand_dela_cruz@gmail.com',
                      style: AppTextStyle.titleM.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: colorScheme.appAccent,
                    ),
                    child: Text(
                      'Free Account',
                      style: TextStyle(
                        color: colorScheme.pageShifterTextSelected,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 2),
            Icon(
              PhosphorIconsRegular.pencilSimple,
              color: colorScheme.appInversedtext,
            ),
            SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
