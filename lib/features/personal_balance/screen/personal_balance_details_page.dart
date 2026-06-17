import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/personal_balance/controller/personal_balance_controller.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/features/widgets/cards/person_activity_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/person_debt_activity.dart';

class PersonalBalanceDetailsPage extends GetView<PersonalBalanceController> {
  const PersonalBalanceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Balance'),
        backgroundColor: colorScheme.appText,
        foregroundColor: colorScheme.appInversedtext,
        elevation: 0,
        scrolledUnderElevation: 0,

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF141C29), Color(0xFF1E293B)],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: database.peopleBalanceDao.watchPersonBalance(
              controller.entityId,
            ),
            builder: (context, snapshot) {
              final summary = snapshot.data;

              if (summary == null) {
                return const SizedBox();
              }

              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  bottom: 24,
                  left: 24,
                  right: 24,
                  top: 12,
                ),
                // height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFF141C29), const Color(0xFF1E293B)],
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: 0.60,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: colorScheme.inversePrimary,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),

                        Text(
                          summary.entity.name.trim()[0],
                          style: TextStyle(
                            fontSize: 40,
                            color: colorScheme.appText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      summary.entity.name,
                      style: TextStyle(
                        color: colorScheme.inversePrimary,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      summary.netBalance.abs().toCurrency(),
                      style: TextStyle(
                        color: colorScheme.inversePrimary,
                        fontFeatures: [FontFeature.tabularFigures()],
                        fontSize: 32,
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: 0.25,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: summary.isSettled
                                  ? colorScheme.appNeutral
                                  : summary.owesMe
                                  ? colorScheme.appInflow
                                  : colorScheme.appOutflow,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              summary.owesMe
                                  ? 'Owes You'
                                  : summary.iOwe
                                  ? 'You Owe'
                                  : 'Settled',
                              style: TextStyle(
                                color: Colors.transparent,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          summary.owesMe
                              ? 'Owes You'
                              : summary.iOwe
                              ? 'You Owe'
                              : 'Settled',
                          style: TextStyle(
                            color: summary.isSettled
                                ? colorScheme.appNeutral
                                : summary.owesMe
                                ? colorScheme.appInflow
                                : colorScheme.appOutflow,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: 44,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          // color: Colors.blue,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Center(
                          child: Text(
                            'Transactions',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(PhosphorIconsRegular.plus),
                // ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<Map<String, List<PersonDebtActivity>>>(
              stream: database.peopleBalanceDao.watchGroupedPersonDebtActivity(
                controller.entityId,
              ),
              builder: (context, snapshot) {
                final groups = snapshot.data ?? {};

                return ListView(
                  children: groups.entries.map((entry) {
                    return AppSection(
                      sectionTitle: entry.key,
                      child: Column(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...entry.value.map(
                            (activity) =>
                                PersonDebtActivityCard(activity: activity),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
