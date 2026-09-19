import 'package:flutter/material.dart';

class CreditCardBillsPaymentView extends StatelessWidget {
  final int accountId;

  const CreditCardBillsPaymentView({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 12, bottom: 24, left: 16, right: 16),
      children: [
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
