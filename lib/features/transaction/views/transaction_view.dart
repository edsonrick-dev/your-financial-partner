import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/transaction_card_shell.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
  double calculateGroupTotal(List<TransactionWithDetails> transactions) {
    return transactions.fold<double>(0, (total, item) {
      switch (item.transaction.type) {
        case TransactionType.earn:
        case TransactionType.receive:
          return total + item.transaction.amount;

        case TransactionType.spend:
        case TransactionType.give:
        case TransactionType.debtRepayment:
        case TransactionType.balanceUpdate:
          return total - item.transaction.amount;

        case TransactionType.transfer:
          // Transfers are between your own accounts,
          // so they have no effect on net cash flow.
          return total;
      }
    });
  }

  String formatGroupTotal(double total) {
    if (total == 0) return '';

    final amount = total.abs().toCurrency();

    // if (total > 0) {
    //   return '+$amount';
    // }

    return amount;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final cardsSpacing = 12.0;
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Transactions', style: AppTextStyle.headlineL),
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TransactionFilterPicker(),

          Expanded(
            child: Obx(() {
              final filter = controller.selectedTransactionFilter.value;

              return StreamBuilder<Map<String, List<TransactionWithDetails>>>(
                stream: database.transactionsDao.watchGroupedTransactions(
                  filter: filter,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    debugPrint(snapshot.error.toString());

                    if (snapshot.stackTrace != null) {
                      debugPrint(snapshot.stackTrace.toString());
                    }

                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final groupedTransactions =
                      <String, List<TransactionWithDetails>>{};

                  for (final entry in snapshot.data!.entries) {
                    final filtered = entry.value
                        .where(
                          (item) =>
                              item.transaction.type !=
                              TransactionType.balanceUpdate,
                        )
                        .toList();

                    if (filtered.isNotEmpty) {
                      groupedTransactions[entry.key] = filtered;
                    }
                  }

                  if (groupedTransactions.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              PhosphorIconsRegular.listHeart,
                              size: 48,
                              color: colorScheme.appAccent,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No transactions yet',
                              style: AppTextStyle.headlineM,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Track your actual cashflow—Record your income, '
                              'expenses, transfers, and money you lend or borrow.',
                              style: AppTextStyle.bodyM.copyWith(
                                color: colorScheme.appTextMuted,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap + to record your first transaction.',
                              style: AppTextStyle.bodyM.copyWith(
                                color: colorScheme.appTextMuted,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.only(bottom: 24),
                    children: groupedTransactions.entries.map((entry) {
                      final sectionTitle = entry.key;
                      final transactions = entry.value;
                      final groupTotal = calculateGroupTotal(transactions);

                      return Column(
                        spacing: cardsSpacing,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSection(
                            sectionTitle: sectionTitle,
                            trailingType: SectionTrailingType.custom,
                            trailingWidget: groupTotal == 0
                                ? const SizedBox.shrink()
                                : Text(
                                    formatGroupTotal(groupTotal),
                                    style: AppTextStyle.amountL.copyWith(
                                      color: groupTotal >= 0
                                          ? colorScheme.appInflow
                                          : colorScheme.appOutflow,
                                    ),
                                  ),
                            child: AppSectionBody(
                              child: Column(
                                spacing: cardsSpacing,
                                children: transactions
                                    .map((item) => TransactionCard(item: item))
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class AppPageShifter extends StatelessWidget {
  const AppPageShifter({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.ease,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.pageShifterFillSelected
              : colorScheme.pageShifterFillUnselected,
          borderRadius: BorderRadius.circular(999),
          boxShadow: AppShadows.pill(colorScheme.text),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          style: TextStyle(
            color: isSelected
                ? colorScheme.pageShifterTextSelected
                : colorScheme.pageShifterTextUnselected,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
          child: Text(title),
        ),
      ),
    );
  }
}

class TransactionFilterPicker extends GetView<TransactionController> {
  const TransactionFilterPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: database.transactionsDao.watchVisibleTransactionCount(),
      builder: (context, transactionCountSnapshot) {
        if (!transactionCountSnapshot.hasData) {
          return const SizedBox.shrink();
        }

        final transactionCount = transactionCountSnapshot.data!;

        // One transaction or fewer:
        // there is no meaningful reason to show a filter.
        if (transactionCount <= 1) {
          return const SizedBox.shrink();
        }

        return StreamBuilder<List<CashflowCategoriesTableData>>(
          stream: database.transactionsDao.watchCategoriesWithTransactions(),
          builder: (context, categorySnapshot) {
            if (!categorySnapshot.hasData) {
              return const SizedBox.shrink();
            }

            return StreamBuilder<List<AccountsTableData>>(
              stream: database.transactionsDao.watchLoansWithDebtRepayments(),
              builder: (context, loanSnapshot) {
                if (!loanSnapshot.hasData) {
                  return const SizedBox.shrink();
                }

                return StreamBuilder<List<EntitiesTableData>>(
                  stream: database.transactionsDao
                      .watchPeopleWithTransactions(),
                  builder: (context, peopleSnapshot) {
                    if (!peopleSnapshot.hasData) {
                      return const SizedBox.shrink();
                    }

                    final categories = categorySnapshot.data!;
                    final loans = loanSnapshot.data!;
                    final people = peopleSnapshot.data!;

                    final filterCount =
                        categories.length + loans.length + people.length;

                    // Only one possible filter:
                    // All + one option is pointless.
                    if (filterCount <= 1) {
                      return const SizedBox.shrink();
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        spacing: 8,
                        children: [
                          const SizedBox(width: 12),

                          // ALL
                          Obx(() {
                            final selected =
                                controller.selectedTransactionFilter.value;

                            return AppPageShifter(
                              title: 'All',
                              isSelected: selected is AllTransactionFilter,
                              onTap: () {
                                controller.selectTransactionFilter(
                                  const AllTransactionFilter(),
                                );
                              },
                            );
                          }),

                          // CATEGORIES
                          ...categories.map((category) {
                            return Obx(() {
                              final selected =
                                  controller.selectedTransactionFilter.value;

                              return AppPageShifter(
                                title: category.name,
                                isSelected:
                                    selected is CategoryTransactionFilter &&
                                    selected.category.id == category.id,
                                onTap: () {
                                  controller.selectTransactionFilter(
                                    CategoryTransactionFilter(category),
                                  );
                                },
                              );
                            });
                          }),

                          // LOANS
                          ...loans.map((loan) {
                            return Obx(() {
                              final selected =
                                  controller.selectedTransactionFilter.value;

                              return AppPageShifter(
                                title: loan.name,
                                isSelected:
                                    selected is LoanTransactionFilter &&
                                    selected.account.id == loan.id,
                                onTap: () {
                                  controller.selectTransactionFilter(
                                    LoanTransactionFilter(loan),
                                  );
                                },
                              );
                            });
                          }),

                          // PEOPLE
                          ...people.map((person) {
                            return Obx(() {
                              final selected =
                                  controller.selectedTransactionFilter.value;

                              return AppPageShifter(
                                title: person.name,
                                isSelected:
                                    selected is PersonTransactionFilter &&
                                    selected.entity.id == person.id,
                                onTap: () {
                                  controller.selectTransactionFilter(
                                    PersonTransactionFilter(person),
                                  );
                                },
                              );
                            });
                          }),

                          const SizedBox(width: 12),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

sealed class TransactionFilter {
  const TransactionFilter();
}

class AllTransactionFilter extends TransactionFilter {
  const AllTransactionFilter();
}

class CategoryTransactionFilter extends TransactionFilter {
  const CategoryTransactionFilter(this.category);

  final CashflowCategoriesTableData category;
}

class LoanTransactionFilter extends TransactionFilter {
  const LoanTransactionFilter(this.account);

  final AccountsTableData account;
}

class PersonTransactionFilter extends TransactionFilter {
  const PersonTransactionFilter(this.entity);

  final EntitiesTableData entity;
}
