import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/guide/guide_state.dart';

class GetStartedTile extends StatelessWidget {
  const GetStartedTile({
    super.key,
    required this.title,
    required this.description,
    required this.iconColor,
    required this.icon,
    required this.guideState,
  });
  final String title;
  final String description;
  final Color iconColor;
  final IconData icon;
  final GuideState guideState;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final unavailable = guideState == GuideState.locked;
    return Opacity(
      opacity: unavailable ? 0.5 : 1,
      child: AdaptivePressable(
        onTap: unavailable ? null : () {},
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: guideState == GuideState.completed
                ? colorScheme.appInflow.withAlpha(36)
                : colorScheme.bgLight,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(icon, color: iconColor, size: 20),
                        Opacity(
                          opacity: 0.2,
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: iconColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title, style: AppTextStyle.titleM),
                                Text(
                                  description,
                                  style: AppTextStyle.bodyS.copyWith(
                                    color: colorScheme.appTextMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            guideState.statusIcon,
                            size: 16,
                            color: guideState.statusColor(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
