import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content_type.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_status.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LearnThumbnail extends StatelessWidget {
  const LearnThumbnail({
    super.key,
    this.status = LearnStatus.available,
    this.type = LearnContentType.article,
    this.showThumbnail = true,
    this.onTap,
    this.description,
    this.showHelper = true,
    required this.title,
  });

  final String? description;
  final LearnStatus status;
  final LearnContentType type;
  final bool showThumbnail;
  final String title;
  final VoidCallback? onTap;
  final bool showHelper;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final icon = switch (status) {
      LearnStatus.watched => PhosphorIconsRegular.check,
      LearnStatus.available =>
        type == LearnContentType.video
            ? PhosphorIconsRegular.play
            : PhosphorIconsRegular.book,
      LearnStatus.locked => PhosphorIconsRegular.lock,
    };
    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: showThumbnail
            ? EdgeInsets.all(8)
            : EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          boxShadow: AppShadows.card(colorScheme.appText),
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showThumbnail)
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 108,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppGradient.gradientA(colorScheme),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showHelper)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(icon, size: 14, color: colorScheme.appTextMuted),
                        const SizedBox(width: 4),
                        Text(type.label, style: AppTextStyle.labelM),

                        const SizedBox(width: 4),

                        Text('•', style: AppTextStyle.labelM),

                        const SizedBox(width: 4),

                        Text(
                          '5 min. ${type.actionLabel}',
                          style: AppTextStyle.labelM,
                        ),

                        const Spacer(),
                      ],
                    ),

                  const SizedBox(height: 6),

                  Text(
                    title,
                    style: AppTextStyle.titleL,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  if (description != null)
                    Column(
                      children: [
                        const SizedBox(height: 2),

                        Text(
                          description ?? '',
                          style: showThumbnail
                              ? AppTextStyle.bodyS
                              : AppTextStyle.bodyM.copyWith(
                                  // color: colorScheme.appTextMuted,
                                ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
