import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_group/account_group_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_group/account_group_summary.dart';

class LiabilitiesList extends StatelessWidget {
  const LiabilitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AccountGroupSummary>>(
      stream: database.accountsDao.watchLiabilityAccountGroups(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final groups = snapshot.data!;

        if (groups.isEmpty) {
          return const Center(child: Text('No liabilities yet.'));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              for (final group in groups) AccountGroupSection(summary: group),
            ],
          ),
        );
      },
    );
  }
}
