import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/adaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/design_system/shifters/segment_shifter/app_segmented_selector.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/transaction_card_shell.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:intl/intl.dart';
import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});

  Map<String, List<TransactionWithDetails>> _groupTransactions(
    List<TransactionWithDetails> transactions,
    int grouping,
  ) {
    final grouped = <DateTime, List<TransactionWithDetails>>{};

    for (final item in transactions) {
      final date = item.transaction.date;
      final day = DateTime(date.year, date.month, date.day);
      final groupDate = switch (grouping) {
        1 => DateTime(day.year, day.month, ((day.day - 1) ~/ 7) * 7 + 1),
        2 => DateTime(day.year, day.month),
        _ => day,
      };
      grouped.putIfAbsent(groupDate, () => []).add(item);
    }

    final entries = grouped.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));
    final result = <String, List<TransactionWithDetails>>{};

    for (final entry in entries) {
      final weekEnd = DateTime(
        entry.key.year,
        entry.key.month,
        entry.key.day + 6,
      );
      final lastDayOfMonth = DateTime(entry.key.year, entry.key.month + 1, 0);
      final displayedWeekEnd = weekEnd.isAfter(lastDayOfMonth)
          ? lastDayOfMonth
          : weekEnd;
      final label = switch (grouping) {
        1 =>
          'Week ${((entry.key.day - 1) ~/ 7) + 1} · '
              '${DateFormat('MMM d').format(entry.key)} - '
              '${DateFormat('MMM d').format(displayedWeekEnd)}',
        2 => DateFormat('MMMM yyyy').format(entry.key),
        _ => database.transactionsDao.groupLabel(entry.key),
      };
      result[label] = entry.value;
    }

    return result;
  }

  String _dayLabel(DateTime day) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (day == today) return 'Today';
    if (day == yesterday) return 'Yesterday';
    return DateFormat('EEEE, MMM d, yyyy').format(day);
  }

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
        case TransactionType.cardPayment:
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              width: 132,
              child: Obx(
                () => AppSegmentedSelector(
                  items: const ['D', 'W', 'M'],
                  selectedIndex: controller.selectedTransactionGrouping.value,
                  onChanged: (index) =>
                      controller.selectedTransactionGrouping.value = index,
                  style: AppTextStyle.labelS,
                ),
              ),
            ),
          ),
        ],
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TransactionFilterPicker(),

          Expanded(
            child: Obx(() {
              final filter = controller.selectedTransactionFilter.value;
              final grouping = controller.selectedTransactionGrouping.value;

              return StreamBuilder<Map<String, List<TransactionWithDetails>>>(
                stream: database.transactionsDao.watchGroupedTransactions(
                  filter: filter,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final transactions = snapshot.data!.values
                      .expand((items) => items)
                      .where(
                        (item) =>
                            item.transaction.type !=
                            TransactionType.balanceUpdate,
                      )
                      .toList();
                  final groupedTransactions = _groupTransactions(
                    transactions,
                    grouping,
                  );

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
                    padding: EdgeInsets.only(bottom: context.bottomPadding),
                    children: groupedTransactions.entries.map((entry) {
                      final sectionTitle = entry.key;
                      final transactions = entry.value;
                      final groupTotal = calculateGroupTotal(transactions);
                      final transactionsByDay =
                          <DateTime, List<TransactionWithDetails>>{};
                      for (final transaction in transactions) {
                        final date = transaction.transaction.date;
                        final day = DateTime(date.year, date.month, date.day);
                        transactionsByDay
                            .putIfAbsent(day, () => [])
                            .add(transaction);
                      }
                      final days = transactionsByDay.keys.toList()
                        ..sort((a, b) => b.compareTo(a));

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
                                children: grouping == 0
                                    ? transactions
                                          .map(
                                            (item) =>
                                                TransactionCard(item: item),
                                          )
                                          .toList()
                                    : days.map((day) {
                                        final dayTransactions =
                                            transactionsByDay[day]!;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: cardsSpacing,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                top: 8,
                                              ),
                                              child: Text(
                                                _dayLabel(day),
                                                style: AppTextStyle.labelS
                                                    .copyWith(
                                                      color: colorScheme
                                                          .appTextMuted,
                                                    ),
                                              ),
                                            ),
                                            ...dayTransactions.map(
                                              (item) =>
                                                  TransactionCard(item: item),
                                            ),
                                          ],
                                        );
                                      }).toList(),
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
