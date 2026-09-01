import 'package:flutter/cupertino.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class RequirementRow extends StatelessWidget {
  const RequirementRow({
    super.key,
    required this.label,
    required this.isComplete,
  });

  final String label;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isComplete
              ? CupertinoIcons.checkmark_circle_fill
              : CupertinoIcons.circle,
          size: 20,
          color: isComplete
              ? context.colors.appSuccess
              : context.colors.appTextMuted,
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(label, style: AppTextStyle.bodyM)),
      ],
    );
  }
}
