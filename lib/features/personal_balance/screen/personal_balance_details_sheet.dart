import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';
import 'package:getx_drift_app/features/add_transaction_sheet.dart';
import 'package:getx_drift_app/features/widgets/cards/person_activity_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/person_debt_activity.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/anchored_action_menu.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PersonalBalanceDetailsSheet extends StatelessWidget {
  const PersonalBalanceDetailsSheet({super.key, required this.entityId});

  final int entityId;
  void openTransactionSheet(PersonDebtActivity activity) {
    final item = activity.transactionDetails;

    if (item == null) return;

    switch (item.transaction.type) {
      case TransactionType.give:
        AppSheets.transaction.giveMoney(item: item);

      case TransactionType.receive:
        AppSheets.transaction.receiveMoney(item: item);

      case TransactionType.spend:
        AppSheets.transaction.spend(item: item);

      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final RxInt selectedIndex = 0.obs;
    final colorScheme = context.colors;
    final LayerLink addButtonLink = LayerLink();
    final RxBool isAddMenuOpen = false.obs;
    return AppSheet(
      title: 'Personal Balance',
      height: AppSheetHeight.full,
      child: Stack(
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
                        gradient: AppGradient.gradientA(colorScheme),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
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
                              SizedBox(width: 8),
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
                              SizedBox(width: 16),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Opacity(
                                    opacity: 0.8,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: summary.isSettled
                                            ? colorScheme.appNeutral
                                            : summary.owesMe
                                            ? colorScheme.appOutflowInversed
                                            : colorScheme.appInflowInverse,
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
                                        style: AppTextStyle.labelM,
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
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              summary.netBalance.abs().toCurrency(),
                              style: AppTextStyle.amountXL.copyWith(
                                color: summary.netBalance < 0
                                    ? colorScheme.appOutflowInversed
                                    : colorScheme.appInflowInverse,
                              ),
                            ),
                          ),
                          Text(
                            summary.netBalance < 0 ? 'Payable' : 'Receivable',
                            style: AppTextStyle.titleM.copyWith(
                              color: colorScheme.appInversedtextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              AppDetailsPageActionSection(
                selectedIndex: selectedIndex,
                actions: ['Transactions'],
                addButtonLink: addButtonLink,
                onAdd: () {
                  isAddMenuOpen.toggle();
                },
                isAddMenuOpen: isAddMenuOpen,
              ),

              Expanded(
                child: StreamBuilder<Map<String, List<PersonDebtActivity>>>(
                  stream: database.peopleBalanceDao
                      .watchGroupedPersonDebtActivity(entityId),
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
                                (activity) => PersonDebtActivityCard(
                                  activity: activity,
                                  // onTap: () {
                                  //   openTransactionSheet(activity);
                                  // },
                                ),
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
          Obx(
            () => AnchoredActionMenu(
              isOpen: isAddMenuOpen.value,
              link: addButtonLink,
              onDismiss: () {
                isAddMenuOpen.value = false;
              },
              child: selectedIndex.value == 0
                  ? Column(
                      spacing: 12,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        NewTransactionButton(
                          color: colorScheme.appOutflow,
                          icon: Icons.remove,
                          label: 'Split Expense',
                          onTap: () {
                            // AppSheets.transaction.spend(
                            //   account: currentAccount,
                            // );
                            isAddMenuOpen.toggle();
                          },
                        ),

                        NewTransactionButton(
                          color: colorScheme.appInflow,
                          icon: PhosphorIconsRegular.handCoins,
                          label: 'Receive Debt Payment',
                          onTap: () {
                            // AppSheets.transaction.receiveMoney(
                            //   account: currentAccount,
                            // );
                            isAddMenuOpen.toggle();
                          },
                        ),
                        NewTransactionButton(
                          color: colorScheme.appOutflow,
                          icon: PhosphorIconsRegular.handDeposit,
                          label: 'Give Debt Payment',
                          onTap: () {
                            // AppSheets.transaction.giveMoney(
                            //   account: currentAccount,
                            // );
                            isAddMenuOpen.toggle();
                          },
                        ),
                      ],
                    )
                  : const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [Text('Add Goal Reservation')],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
