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
      showHeader: false,
      height: AppSheetHeight.full,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(38),
                bottom: Radius.circular(38),
              ),
              color: colorScheme.bg,
            ),
            child: Column(
              children: [
                ///Grabber
                AppGrabber(isDark: true),

                ///Toolbar
                AppToolbar(
                  title: 'Personal Balance',
                  isDark: true,
                  showLeading: false,
                ),
                StreamBuilder(
                  stream: database.peopleBalanceDao.watchPersonBalance(
                    entityId,
                  ),
                  builder: (context, snapshot) {
                    final summary = snapshot.data;

                    if (summary == null) {
                      return const SizedBox();
                    }

                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        bottom: 28,
                        left: 24,
                        right: 24,
                        top: 12,
                      ),
                      // height: 44,
                      // decoration: BoxDecoration(
                      //   gradient: LinearGradient(
                      //     colors: [
                      //       const Color(0xFF141C29),
                      //       const Color(0xFF1E293B),
                      //     ],
                      //   ),
                      //   borderRadius: BorderRadius.vertical(
                      //     bottom: Radius.circular(24),
                      //   ),
                      // ),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Opacity(
                                opacity: 0.60,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: colorScheme.inversePrimary,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                              ),

                              Text(
                                summary.entity.name.trim()[0],
                                style: AppTextStyle.displayL,
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
                          SizedBox(height: 8),
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
                          Text(
                            summary.netBalance.abs().toCurrency(),
                            style: AppTextStyle.amountXL.copyWith(
                              color: colorScheme.appInversedtext,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
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
