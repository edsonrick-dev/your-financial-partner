import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';

class BillsRow extends StatelessWidget {
  final String title;
  final double amount;
  final String frequency;
  final bool isMain;
  const BillsRow({
    super.key,
    required this.title,
    required this.amount,
    required this.frequency,
    this.isMain = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isMain ? 1 : 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Expanded(child: Text('$title:', style: AppTextStyle.bodyM)),
            Text(
              '${amount.toCurrency()}/$frequency',
              style: AppTextStyle.amountM,
            ),
          ],
        ),
      ),
    );
  }
}
