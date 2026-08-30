import 'package:flutter/material.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/transaction_form_registry.dart';

class TransactionForm extends StatelessWidget {
  const TransactionForm({super.key, required this.transactionType});

  final TransactionType transactionType;

  @override
  Widget build(BuildContext context) {
    return TransactionFormRegistry.form(transactionType);
  }
}
