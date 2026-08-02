import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/widgets/cards/person_balance_card.dart';
import 'package:getx_drift_app/data/models/person_balance_summary_model.dart';

class PeopleBalancesView extends StatelessWidget {
  const PeopleBalancesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Personal Balances', style: AppTextStyle.headlineL),
      ),
      body: StreamBuilder<List<PersonBalanceSummary>>(
        stream: database.peopleBalanceDao.watchPeopleBalances(),

        builder: (context, snapshot) {
          /// LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          /// ERROR
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final people = snapshot.data ?? [];

          /// EMPTY
          if (people.isEmpty) {
            return const Center(child: Text('No personal balances yet.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),

            itemCount: people.length,

            separatorBuilder: (_, _) => const SizedBox(height: 12),

            itemBuilder: (context, index) {
              final person = people[index];

              return PersonBalanceCard(item: person);
            },
          );
        },
      ),
    );
  }
}
