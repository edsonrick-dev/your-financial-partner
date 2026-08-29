import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/account_form_registry.dart';

class AccountForm extends StatelessWidget {
  const AccountForm({super.key, required this.accountType});

  final AccountType accountType;

  @override
  Widget build(BuildContext context) {
    return AccountFormRegistry.form(accountType);
  }
}
