import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';

import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/enum/financial_stability_level.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LearnThumbnail extends StatelessWidget {
  const LearnThumbnail({
    super.key,
    this.status = LearnStatus.available,
    this.type = ContentType.article,
    this.showThumbnail = true,
    this.onTap,
    required this.title,
  });

  final LearnStatus status;
  final ContentType type;
  final bool showThumbnail;
  final String title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final icon = switch (status) {
      LearnStatus.watched => PhosphorIconsRegular.check,
      LearnStatus.available =>
        type == ContentType.video
            ? PhosphorIconsRegular.play
            : PhosphorIconsRegular.book,
      LearnStatus.locked => PhosphorIconsRegular.lock,
    };
    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(08),
        decoration: BoxDecoration(
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
                      child: Container(color: colorScheme.appText),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                  SizedBox(
                    height: 44,
                    child: Text(
                      title,
                      style: AppTextStyle.titleM,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
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

enum LearnStatus {
  available,
  watched,
  locked;

  IconData get icon {
    return switch (this) {
      LearnStatus.available => PhosphorIconsFill.book,
      LearnStatus.watched => PhosphorIconsRegular.check,
      LearnStatus.locked => PhosphorIconsRegular.lock,
    };
  }
}

enum ContentType {
  article,
  video;

  String get label {
    switch (this) {
      case ContentType.article:
        return 'Article';
      case ContentType.video:
        return 'Video';
    }
  }

  String get actionLabel {
    switch (this) {
      case ContentType.article:
        return 'read';
      case ContentType.video:
        return 'watch';
    }
  }
}

enum LearnContext {
  home,
  netWorth,
  cashFlow,
  debt,
  insurance,
  savingsInvestment,
  dti,
  wbr,
  lcr,
  efr,
  financialStability,
}

class CashflowLearnContent {}
