import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';

class CreditCardBillsPaymentView extends StatelessWidget {
  final int accountId;

  const CreditCardBillsPaymentView({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Text('Bills Payment', style: AppTextStyle.titleL),

        const SizedBox(height: 12),

        // TODO: Load payments made toward this credit card
        const ListTile(
          title: Text('Credit Card Payment'),
          subtitle: Text('Aug 15, 2026'),
          trailing: Text('₱5,000.00'),
        ),
      ],
    );
  }
}
