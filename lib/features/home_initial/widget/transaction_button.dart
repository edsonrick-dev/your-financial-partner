import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
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
    this.bgColor = Colors.transparent,
    this.padding = 8,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AdaptivePressable(
        borderRadius: BorderRadius.circular(
          AppBorderRadius.xL, //16,
        ),
        child: GestureDetector(
          onTap: onTap ?? () {},
          child: Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(color: bgColor),
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
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
                  style: AppTextStyle.titleS.copyWith(
                    color: context.colors.appText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
