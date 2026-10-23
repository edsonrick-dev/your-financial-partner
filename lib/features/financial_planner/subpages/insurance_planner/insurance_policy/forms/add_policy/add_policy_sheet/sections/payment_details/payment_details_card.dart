import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class PaymentDetailsCard extends StatelessWidget {
  const PaymentDetailsCard({
    super.key,
    required this.name,
    this.description,
    this.onTap,
    this.isSelected = false,
  });
  final String name;
  final String? description;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppCard(
      borderColor: isSelected ? colorScheme.appText : colorScheme.appBorder,
      onTap: onTap,
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: AppTextStyle.bodyL),
          if (description != null)
            Text(description ?? 'No description', style: AppTextStyle.bodyM),
        ],
      ),
    );
  }
}
