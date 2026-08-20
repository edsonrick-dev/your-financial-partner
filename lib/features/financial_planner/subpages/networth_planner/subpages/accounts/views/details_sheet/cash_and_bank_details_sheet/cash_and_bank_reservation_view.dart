import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';

class CashAndBankReservationView extends StatelessWidget {
  final int accountId;

  const CashAndBankReservationView({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.receipt_long_outlined, size: 48),
            const SizedBox(height: 16),
            Text(
              'No Goal Reservation Yet',
              style: AppTextStyle.titleL,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Transactions charged to this card will appear here.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
