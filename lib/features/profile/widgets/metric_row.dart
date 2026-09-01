import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';

class MetricRow extends StatelessWidget {
  const MetricRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTextStyle.bodyM)),
        Text(value, style: AppTextStyle.amountL),
      ],
    );
  }
}
