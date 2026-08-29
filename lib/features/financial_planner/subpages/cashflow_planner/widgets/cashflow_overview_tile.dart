import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/core/num_extension.dart';

class CashFlowOverviewTile extends StatelessWidget {
  final IconData icon;
  final String type;
  final double amount;
  final int count;
  const CashFlowOverviewTile({
    super.key,
    required this.icon,
    required this.type,
    this.amount = 0,
    this.count = 1,
  });

  @override
  Widget build(BuildContext context) {
    String label = count > 1 ? 'sources' : 'source';
    final colorScheme = context.colors;
    return Row(
      children: [
        Row(
          spacing: 12,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.appInflow,
                    ),
                  ),
                ),
                Icon(icon, color: colorScheme.appInflow, size: 20),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: TextStyle(fontWeight: FontWeight.w600)),
                Text(
                  '$count $label',
                  style: TextStyle(
                    color: colorScheme.appTextMuted,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        Text(
          amount.toCurrency(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            height: 20 / 15,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
        SizedBox(width: 12),
      ],
    );
  }
}
