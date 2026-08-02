import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/widgets/cards/account_card.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class AccountsView extends StatelessWidget {
  const AccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accounts', style: AppTextStyle.headlineL)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSection(
            child: Text('Manage your acounts and track your balances'),
          ),
          Expanded(
            child: StreamBuilder<List<AccountsTableData>>(
              stream: database.accountsDao.watchAccounts(),

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final accounts = snapshot.data!;

                if (accounts.isEmpty) {
                  return const Center(child: Text('No accounts yet.'));
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),

                  itemCount: accounts.length,

                  separatorBuilder: (_, _) => const SizedBox(height: 12),

                  itemBuilder: (context, index) {
                    final account = accounts[index];

                    return AccountCard(account: account);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
