import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/widgets/cards/person_activity_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/person_debt_activity.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';

class PersonalBalanceDetailsSheet extends StatelessWidget {
  const PersonalBalanceDetailsSheet({super.key, required this.entityId});

  final int entityId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSheet(
      title: 'Personal Balance',
      height: AppSheetHeight.full,
      child: Column(
        children: [
          Column(
            children: [
              StreamBuilder(
                stream: database.peopleBalanceDao.watchPersonBalance(entityId),
                builder: (context, snapshot) {
                  final summary = snapshot.data;

                  if (summary == null) {
                    return const SizedBox();
                  }

                  return AppSection(
                    child: Container(
                      padding: EdgeInsets.all(24),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [colorScheme.text, colorScheme.gradient2],
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            spacing: 8,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Opacity(
                                    opacity: 0.60,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: colorScheme.inversePrimary,
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Text(
                                    summary.entity.name.trim()[0],
                                    style: AppTextStyle.headlineL,
                                  ),
                                ],
                              ),

                              Expanded(
                                child: Text(
                                  summary.entity.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.displayM.copyWith(
                                    color: colorScheme.appInversedtext,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Opacity(
                                    opacity: 0.8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: summary.isSettled
                                            ? colorScheme.appNeutral
                                            : summary.owesMe
                                            ? colorScheme.appText
                                            : colorScheme.appText,
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                      ),
                                      child: Text(
                                        summary.owesMe
                                            ? 'Owes You'
                                            : summary.iOwe
                                            ? 'You Owe'
                                            : 'Settled',
                                        style: AppTextStyle.labelM.copyWith(
                                          color: Colors.transparent,
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
                                    style: AppTextStyle.labelM.copyWith(
                                      color: summary.isSettled
                                          ? colorScheme.appNeutral
                                          : summary.owesMe
                                          ? colorScheme.appInversedtext
                                          : colorScheme.appInversedtext,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            summary.netBalance.abs().toCurrency(),
                            style: AppTextStyle.amountXL.copyWith(
                              color: summary.netBalance < 0
                                  ? colorScheme.appOutflowInversed
                                  : colorScheme.appInflowInverse,
                            ),
                          ),
                          Text(
                            summary.netBalance < 0 ? 'Payable' : 'Receivable',
                            style: AppTextStyle.titleS.copyWith(
                              color: colorScheme.appInversedtextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
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
                entityId,
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
