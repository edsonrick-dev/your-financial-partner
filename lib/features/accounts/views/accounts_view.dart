import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/widgets/cards/account_card.dart';
import 'package:getx_drift_app/data/app_database.dart';

class AccountsView extends StatelessWidget {
  const AccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Accounts')),

      body: StreamBuilder<List<AccountsTableData>>(
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
    );
  }
}
