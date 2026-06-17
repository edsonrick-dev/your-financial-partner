import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class TransactionButton extends StatelessWidget {
  final Color color;
  final Color bgColor;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final double padding;
  const TransactionButton({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
    this.bgColor = Colors.white,
    this.padding = 8,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap ?? () {},
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(8),
            color: bgColor,
            // border: Border.all(color: colorScheme.appBorder),
            // border: Border.all(color: Colors.transparent, width: 0.5),
          ),
          child: Column(
            spacing: 4,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: 0.2,
                    child: Container(
                      height: 36,
                      width: 36,
                      padding: EdgeInsets.all(6),
                      // width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: color,
                      ),
                    ),
                  ),
                  Icon(
                    icon,
                    color: color,
                    size: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ],
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  height: 16 / 12,
                  color: context.colors.appText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
