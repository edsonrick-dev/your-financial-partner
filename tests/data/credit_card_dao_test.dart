import 'package:drift/drift.dart' as d;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/data/tables/credit_card_billings_table.dart';
import 'package:getx_drift_app/data/tables/credit_card_statements_table.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });
  Future<int> createAccount() {
    return database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Test Credit Card',
        icon: 'credit_card',
        accountType: AccountType.creditCard.name,
      ),
    );
  }

  tearDown(() async {
    await database.close();
  });

  group('creditCardDao', () {
    Future<int> createAccount() {
      return database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Test Credit Card',
          icon: 'credit_card',
          accountType: 'creditCard',
          creditLimit: const d.Value(500.0),
        ),
      );
    }

    test('inserts and retrieves credit card billing details', () async {
      final accountId = await createAccount();

      await database.creditCardDao.insert(
        CreditCardDetailsTableCompanion.insert(
          accountId: d.Value(accountId),
          statementDay: 23,
          paymentDueDay: 24,
          nextStatementDate: DateTime(2026, 9, 23),
          nextPaymentDueDate: DateTime(2026, 9, 24),
        ),
      );

      final result = await database.creditCardDao.getByAccountId(accountId);

      expect(result, isNotNull);
      expect(result!.accountId, accountId);
      expect(result.statementDay, 23);
      expect(result.paymentDueDay, 24);
      expect(result.nextStatementDate, DateTime(2026, 9, 23));
      expect(result.nextPaymentDueDate, DateTime(2026, 9, 24));
    });

    test('advances a credit card by one billing cycle', () async {
      final accountId = await createAccount();

      await database.creditCardDao.insert(
        CreditCardDetailsTableCompanion.insert(
          accountId: d.Value(accountId),
          statementDay: 23,
          paymentDueDay: 24,
          nextStatementDate: DateTime(2026, 9, 23),
          nextPaymentDueDate: DateTime(2026, 9, 24),
        ),
      );

      final result = await database.creditCardDao.advanceBillingCycle(
        accountId,
      );

      expect(result, isNotNull);

      expect(result!.nextStatementDate, DateTime(2026, 10, 23));

      expect(result.nextPaymentDueDate, DateTime(2026, 10, 24));

      // Recurring billing rules remain unchanged.
      expect(result.statementDay, 23);
      expect(result.paymentDueDay, 24);
    });

    test('returns null when credit card does not exist', () async {
      final result = await database.creditCardDao.advanceBillingCycle(999);

      expect(result, isNull);
    });
  });
  test('advances December into January', () async {
    final accountId = await createAccount();

    await database.creditCardDao.insert(
      CreditCardDetailsTableCompanion.insert(
        accountId: d.Value(accountId),
        statementDay: 23,
        paymentDueDay: 24,
        nextStatementDate: DateTime(2026, 12, 23),
        nextPaymentDueDate: DateTime(2026, 12, 24),
      ),
    );

    final result = await database.creditCardDao.advanceBillingCycle(accountId);

    expect(result, isNotNull);
    expect(result!.nextStatementDate, DateTime(2027, 1, 23));
    expect(result.nextPaymentDueDate, DateTime(2027, 1, 24));

    // Recurring billing rules must remain unchanged.
    expect(result.statementDay, 23);
    expect(result.paymentDueDay, 24);
  });
  test('clamps statement day when next month is shorter', () async {
    final accountId = await createAccount();

    await database.creditCardDao.insert(
      CreditCardDetailsTableCompanion.insert(
        accountId: d.Value(accountId),
        statementDay: 31,
        paymentDueDay: 5,
        nextStatementDate: DateTime(2026, 1, 31),
        nextPaymentDueDate: DateTime(2026, 2, 5),
      ),
    );

    final result = await database.creditCardDao.advanceBillingCycle(accountId);

    expect(result, isNotNull);
    expect(result!.nextStatementDate, DateTime(2026, 2, 28));
    expect(result.nextPaymentDueDate, DateTime(2026, 3, 5));

    expect(result.statementDay, 31);
    expect(result.paymentDueDay, 5);
  });

  test('creditCardDao - Statement Balance spend increases balance', () async {
    final accountId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Credit Card',
        icon: 'credit-card',
        accountType: AccountType.creditCard.name,
        currentValue: const d.Value(0),
        creditLimit: const d.Value(50000),
      ),
    );

    final billingPeriodId = await database
        .into(database.creditCardBillingPeriodsTable)
        .insert(
          CreditCardBillingPeriodsTableCompanion.insert(
            accountId: accountId,
            startDate: DateTime(2026, 9, 1),
            endDate: DateTime(2026, 9, 15),
            status: CreditCardBillingPeriodStatus.open.name,
          ),
        );

    await database
        .into(database.transactionsTable)
        .insert(
          TransactionsTableCompanion.insert(
            amount: 3000,
            date: DateTime(2026, 9, 5),
            transactionType: TransactionType.spend.name,
            accountId: d.Value(accountId),
          ),
        );

    final balance = await database.creditCardDao.calculateStatementBalance(
      accountId: accountId,
      billingPeriodId: billingPeriodId,
    );

    expect(balance, 3000);
  });

  test('creditCardDao - Statement Balance transfer reduces balance', () async {
    final creditCardId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Credit Card',
        icon: 'credit-card',
        accountType: AccountType.creditCard.name,
        currentValue: const d.Value(5000),
        creditLimit: const d.Value(50000),
      ),
    );

    final bankAccountId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Bank',
        icon: 'bank',
        accountType: AccountType.checkingAccount.name,
        currentValue: const d.Value(10000),
      ),
    );

    final billingPeriodId = await database
        .into(database.creditCardBillingPeriodsTable)
        .insert(
          CreditCardBillingPeriodsTableCompanion.insert(
            accountId: creditCardId,
            startDate: DateTime(2026, 9, 1),
            endDate: DateTime(2026, 9, 15),
            status: CreditCardBillingPeriodStatus.open.name,
          ),
        );

    // Original credit card purchase.
    await database
        .into(database.transactionsTable)
        .insert(
          TransactionsTableCompanion.insert(
            amount: 5000,
            date: DateTime(2026, 9, 5),
            transactionType: TransactionType.spend.name,
            accountId: d.Value(creditCardId),
          ),
        );

    // Payment from bank → credit card.
    await database
        .into(database.transactionsTable)
        .insert(
          TransactionsTableCompanion.insert(
            amount: 2000,
            date: DateTime(2026, 9, 10),
            transactionType: TransactionType.transfer.name,
            accountId: d.Value(bankAccountId),
            linkedAccountId: d.Value(creditCardId),
          ),
        );

    final balance = await database.creditCardDao.calculateStatementBalance(
      accountId: creditCardId,
      billingPeriodId: billingPeriodId,
    );

    expect(balance, 3000);
  });
  test(
    'creditCardDao - Statement Balance calculates purchases minus payments',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
          currentValue: const d.Value(6000),
          creditLimit: const d.Value(50000),
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
          currentValue: const d.Value(10000),
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 1),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // ₱3,000 purchase.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 3000,
              date: DateTime(2026, 9, 5),
              transactionType: TransactionType.spend.name,
              accountId: d.Value(creditCardId),
            ),
          );

      // ₱5,000 purchase.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 5000,
              date: DateTime(2026, 9, 8),
              transactionType: TransactionType.spend.name,
              accountId: d.Value(creditCardId),
            ),
          );

      // ₱2,000 payment.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 12),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final balance = await database.creditCardDao.calculateStatementBalance(
        accountId: creditCardId,
        billingPeriodId: billingPeriodId,
      );

      expect(balance, 6000);
    },
  );
  test(
    'creditCardDao - closes billing period and creates next period',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
          currentValue: const d.Value(6000),
          creditLimit: const d.Value(50000),
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
          currentValue: const d.Value(10000),
        ),
      );

      await database.creditCardDao.insert(
        CreditCardDetailsTableCompanion.insert(
          accountId: d.Value(creditCardId),
          statementDay: 15,
          paymentDueDay: 30,
          nextStatementDate: DateTime(2026, 9, 15),
          nextPaymentDueDate: DateTime(2026, 9, 30),
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // ₱8,000 purchases.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 8000,
              date: DateTime(2026, 9, 5),
              transactionType: TransactionType.spend.name,
              accountId: d.Value(creditCardId),
            ),
          );

      // ₱2,000 payment.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 10),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final statement = await database.creditCardDao.closeBillingPeriod(
        accountId: creditCardId,
      );

      expect(statement, isNotNull);
      expect(statement!.billingPeriodId, billingPeriodId);
      expect(statement.statementBalance, 6000);
      expect(statement.paymentDueDate, DateTime(2026, 9, 30));
      expect(statement.status, CreditCardStatementStatus.unpaid.name);

      final closedPeriod = await (database.select(
        database.creditCardBillingPeriodsTable,
      )..where((tbl) => tbl.id.equals(billingPeriodId))).getSingle();

      expect(closedPeriod.status, CreditCardBillingPeriodStatus.closed.name);

      final periods = await database.creditCardDao.getBillingPeriodsForAccount(
        creditCardId,
      );

      expect(periods.length, 2);

      final nextPeriod = periods.last;

      expect(nextPeriod.status, CreditCardBillingPeriodStatus.open.name);
      expect(nextPeriod.startDate, DateTime(2026, 9, 16));
      expect(nextPeriod.endDate, DateTime(2026, 10, 15));
    },
  );
  test('creditCardDao - gets latest unpaid statement', () async {
    final creditCardId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Credit Card',
        icon: 'credit-card',
        accountType: AccountType.creditCard.name,
        currentValue: const d.Value(0),
        creditLimit: const d.Value(50000),
      ),
    );

    // Older billing period.
    final olderPeriodId = await database
        .into(database.creditCardBillingPeriodsTable)
        .insert(
          CreditCardBillingPeriodsTableCompanion.insert(
            accountId: creditCardId,
            startDate: DateTime(2026, 7, 16),
            endDate: DateTime(2026, 8, 15),
            status: CreditCardBillingPeriodStatus.closed.name,
          ),
        );

    // Newer billing period.
    final newerPeriodId = await database
        .into(database.creditCardBillingPeriodsTable)
        .insert(
          CreditCardBillingPeriodsTableCompanion.insert(
            accountId: creditCardId,
            startDate: DateTime(2026, 8, 16),
            endDate: DateTime(2026, 9, 15),
            status: CreditCardBillingPeriodStatus.closed.name,
          ),
        );

    // Older statement is unpaid.
    await database
        .into(database.creditCardStatementsTable)
        .insert(
          CreditCardStatementsTableCompanion.insert(
            billingPeriodId: olderPeriodId,
            statementBalance: 3000,
            paymentDueDate: DateTime(2026, 8, 30),
            status: CreditCardStatementStatus.unpaid.name,
          ),
        );

    // Newer statement is also unpaid.
    await database
        .into(database.creditCardStatementsTable)
        .insert(
          CreditCardStatementsTableCompanion.insert(
            billingPeriodId: newerPeriodId,
            statementBalance: 6000,
            paymentDueDate: DateTime(2026, 9, 30),
            status: CreditCardStatementStatus.unpaid.name,
          ),
        );

    final statement = await database.creditCardDao.getLatestUnpaidStatement(
      creditCardId,
    );

    expect(statement, isNotNull);
    expect(statement!.billingPeriodId, newerPeriodId);
    expect(statement.statementBalance, 6000);
    expect(statement.status, CreditCardStatementStatus.unpaid.name);
  });
  test(
    'creditCardDao - returns older unpaid statement when latest statement is paid',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
          currentValue: const d.Value(0),
          creditLimit: const d.Value(50000),
        ),
      );

      // Older billing period.
      final olderPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 7, 16),
              endDate: DateTime(2026, 8, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      // Newer billing period.
      final newerPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      // Older statement is unpaid.
      await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: olderPeriodId,
              statementBalance: 3000,
              paymentDueDate: DateTime(2026, 8, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // Latest statement has already been paid.
      await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: newerPeriodId,
              statementBalance: 6000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.paid.name,
            ),
          );

      final statement = await database.creditCardDao.getLatestUnpaidStatement(
        creditCardId,
      );

      expect(statement, isNotNull);

      // It must skip the newer paid statement.
      expect(statement!.billingPeriodId, olderPeriodId);
      expect(statement.statementBalance, 3000);
      expect(statement.status, CreditCardStatementStatus.unpaid.name);
    },
  );

  test(
    'creditCardDao - returns null when there are no unpaid statements',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
          currentValue: const d.Value(0),
          creditLimit: const d.Value(50000),
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      // The only statement is already paid.
      await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: billingPeriodId,
              statementBalance: 6000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.paid.name,
            ),
          );

      final statement = await database.creditCardDao.getLatestUnpaidStatement(
        creditCardId,
      );

      expect(statement, isNull);
    },
  );

  test(
    'creditCardDao - calculates payments from transfers to credit card',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
          currentValue: const d.Value(6000),
          creditLimit: const d.Value(50000),
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
          currentValue: const d.Value(10000),
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 1),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // ₱2,000 payment.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 5),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      // ₱1,500 payment.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 1500,
              date: DateTime(2026, 9, 10),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final payments = await database.creditCardDao.calculateStatementPayments(
        accountId: creditCardId,
        billingPeriodId: billingPeriodId,
      );

      expect(payments, 3500);
    },
  );

  test(
    'creditCardDao - ignores transfers that are not payments to credit card',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      final otherAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Other Account',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 1),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // Valid credit card payment.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 5),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      // Transfer from credit card to another account.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 3000,
              date: DateTime(2026, 9, 6),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(creditCardId),
              linkedAccountId: d.Value(otherAccountId),
            ),
          );

      final payments = await database.creditCardDao.calculateStatementPayments(
        accountId: creditCardId,
        billingPeriodId: billingPeriodId,
      );

      expect(payments, 2000);
    },
  );
  test(
    'creditCardDao - ignores spend transactions when calculating payments',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 1),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // Credit card purchase.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 5000,
              date: DateTime(2026, 9, 5),
              transactionType: TransactionType.spend.name,
              accountId: d.Value(creditCardId),
            ),
          );

      // Actual payment.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 10),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final payments = await database.creditCardDao.calculateStatementPayments(
        accountId: creditCardId,
        billingPeriodId: billingPeriodId,
      );

      expect(payments, 2000);
    },
  );
  test('creditCardDao - returns zero when statement has no payments', () async {
    final creditCardId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Credit Card',
        icon: 'credit-card',
        accountType: AccountType.creditCard.name,
        currentValue: const d.Value(5000),
        creditLimit: const d.Value(50000),
      ),
    );

    final billingPeriodId = await database
        .into(database.creditCardBillingPeriodsTable)
        .insert(
          CreditCardBillingPeriodsTableCompanion.insert(
            accountId: creditCardId,
            startDate: DateTime(2026, 9, 1),
            endDate: DateTime(2026, 9, 15),
            status: CreditCardBillingPeriodStatus.open.name,
          ),
        );

    final payment = await database.creditCardDao.calculateStatementPayments(
      accountId: creditCardId,
      billingPeriodId: billingPeriodId,
    );

    expect(payment, 0);
  });

  test('creditCardDao - calculates partial payment', () async {
    final creditCardId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Credit Card',
        icon: 'credit-card',
        accountType: AccountType.creditCard.name,
        currentValue: const d.Value(5000),
        creditLimit: const d.Value(50000),
      ),
    );

    final bankAccountId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Bank',
        icon: 'bank',
        accountType: AccountType.checkingAccount.name,
        currentValue: const d.Value(10000),
      ),
    );

    final billingPeriodId = await database
        .into(database.creditCardBillingPeriodsTable)
        .insert(
          CreditCardBillingPeriodsTableCompanion.insert(
            accountId: creditCardId,
            startDate: DateTime(2026, 9, 1),
            endDate: DateTime(2026, 9, 15),
            status: CreditCardBillingPeriodStatus.open.name,
          ),
        );

    // Partial payment made during the billing period.
    await database
        .into(database.transactionsTable)
        .insert(
          TransactionsTableCompanion.insert(
            amount: 2000,
            date: DateTime(2026, 9, 10),
            transactionType: TransactionType.transfer.name,
            accountId: d.Value(bankAccountId),
            linkedAccountId: d.Value(creditCardId),
          ),
        );

    final payment = await database.creditCardDao.calculateStatementPayments(
      accountId: creditCardId,
      billingPeriodId: billingPeriodId,
    );

    expect(payment, 2000);
  });

  test(
    'creditCardDao - calculates full payment during billing period',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
          currentValue: const d.Value(5000),
          creditLimit: const d.Value(50000),
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
          currentValue: const d.Value(10000),
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 1),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // Full payment made during the billing period.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 5000,
              date: DateTime(2026, 9, 10),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final payment = await database.creditCardDao.calculateStatementPayments(
        accountId: creditCardId,
        billingPeriodId: billingPeriodId,
      );

      expect(payment, 5000);
    },
  );

  test(
    'creditCardDao - sums multiple payments during the billing period',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
          currentValue: const d.Value(5000),
          creditLimit: const d.Value(50000),
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
          currentValue: const d.Value(10000),
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 1),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // First payment.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 5),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      // Second payment.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 1500,
              date: DateTime(2026, 9, 10),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final payment = await database.creditCardDao.calculateStatementPayments(
        accountId: creditCardId,
        billingPeriodId: billingPeriodId,
      );

      expect(payment, 3500);
    },
  );
  test(
    'creditCardDao - includes payment on billing period start date',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 1),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 1),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final payment = await database.creditCardDao.calculateStatementPayments(
        accountId: creditCardId,
        billingPeriodId: billingPeriodId,
      );

      expect(payment, 2000);
    },
  );
  test('creditCardDao - includes payment on billing period end date', () async {
    final creditCardId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Credit Card',
        icon: 'credit-card',
        accountType: AccountType.creditCard.name,
      ),
    );

    final bankAccountId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Bank',
        icon: 'bank',
        accountType: AccountType.checkingAccount.name,
      ),
    );

    final billingPeriodId = await database
        .into(database.creditCardBillingPeriodsTable)
        .insert(
          CreditCardBillingPeriodsTableCompanion.insert(
            accountId: creditCardId,
            startDate: DateTime(2026, 9, 1),
            endDate: DateTime(2026, 9, 15),
            status: CreditCardBillingPeriodStatus.open.name,
          ),
        );

    await database
        .into(database.transactionsTable)
        .insert(
          TransactionsTableCompanion.insert(
            amount: 2000,
            date: DateTime(2026, 9, 15),
            transactionType: TransactionType.transfer.name,
            accountId: d.Value(bankAccountId),
            linkedAccountId: d.Value(creditCardId),
          ),
        );

    final payment = await database.creditCardDao.calculateStatementPayments(
      accountId: creditCardId,
      billingPeriodId: billingPeriodId,
    );

    expect(payment, 2000);
  });
  test('creditCardDao - ignores payment before billing period', () async {
    final creditCardId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Credit Card',
        icon: 'credit-card',
        accountType: AccountType.creditCard.name,
      ),
    );

    final bankAccountId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Bank',
        icon: 'bank',
        accountType: AccountType.checkingAccount.name,
      ),
    );

    final billingPeriodId = await database
        .into(database.creditCardBillingPeriodsTable)
        .insert(
          CreditCardBillingPeriodsTableCompanion.insert(
            accountId: creditCardId,
            startDate: DateTime(2026, 9, 1),
            endDate: DateTime(2026, 9, 15),
            status: CreditCardBillingPeriodStatus.open.name,
          ),
        );

    await database
        .into(database.transactionsTable)
        .insert(
          TransactionsTableCompanion.insert(
            amount: 2000,
            date: DateTime(2026, 8, 31),
            transactionType: TransactionType.transfer.name,
            accountId: d.Value(bankAccountId),
            linkedAccountId: d.Value(creditCardId),
          ),
        );

    final payment = await database.creditCardDao.calculateStatementPayments(
      accountId: creditCardId,
      billingPeriodId: billingPeriodId,
    );

    expect(payment, 0);
  });
  test('creditCardDao - ignores payment after billing period', () async {
    final creditCardId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Credit Card',
        icon: 'credit-card',
        accountType: AccountType.creditCard.name,
      ),
    );

    final bankAccountId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Bank',
        icon: 'bank',
        accountType: AccountType.checkingAccount.name,
      ),
    );

    final billingPeriodId = await database
        .into(database.creditCardBillingPeriodsTable)
        .insert(
          CreditCardBillingPeriodsTableCompanion.insert(
            accountId: creditCardId,
            startDate: DateTime(2026, 9, 1),
            endDate: DateTime(2026, 9, 15),
            status: CreditCardBillingPeriodStatus.open.name,
          ),
        );

    await database
        .into(database.transactionsTable)
        .insert(
          TransactionsTableCompanion.insert(
            amount: 2000,
            date: DateTime(2026, 9, 16),
            transactionType: TransactionType.transfer.name,
            accountId: d.Value(bankAccountId),
            linkedAccountId: d.Value(creditCardId),
          ),
        );

    final payment = await database.creditCardDao.calculateStatementPayments(
      accountId: creditCardId,
      billingPeriodId: billingPeriodId,
    );

    expect(payment, 0);
  });
  test('creditCardDao - closes billing period with zero balance', () async {
    final creditCardId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Credit Card',
        icon: 'credit-card',
        accountType: AccountType.creditCard.name,
        currentValue: const d.Value(0),
        creditLimit: const d.Value(50000),
      ),
    );

    await database.creditCardDao.insert(
      CreditCardDetailsTableCompanion.insert(
        accountId: d.Value(creditCardId),
        statementDay: 15,
        paymentDueDay: 30,
        nextStatementDate: DateTime(2026, 9, 15),
        nextPaymentDueDate: DateTime(2026, 9, 30),
      ),
    );

    final billingPeriodId = await database
        .into(database.creditCardBillingPeriodsTable)
        .insert(
          CreditCardBillingPeriodsTableCompanion.insert(
            accountId: creditCardId,
            startDate: DateTime(2026, 8, 16),
            endDate: DateTime(2026, 9, 15),
            status: CreditCardBillingPeriodStatus.open.name,
          ),
        );

    final statement = await database.creditCardDao.closeBillingPeriod(
      accountId: creditCardId,
    );

    expect(statement, isNotNull);
    expect(statement!.billingPeriodId, billingPeriodId);
    expect(statement.statementBalance, 0);
    expect(statement.paymentDueDate, DateTime(2026, 9, 30));
    expect(statement.status, CreditCardStatementStatus.unpaid.name);
  });
  test(
    'creditCardDao - does not close billing period when no open period exists',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
          currentValue: const d.Value(0),
          creditLimit: const d.Value(50000),
        ),
      );

      final result = await database.creditCardDao.closeBillingPeriod(
        accountId: creditCardId,
      );

      expect(result, isNull);
    },
  );

  ///#26
  test('creditCardDao - carries forward unpaid statement balance', () async {
    final creditCardId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Credit Card',
        icon: 'credit-card',
        accountType: AccountType.creditCard.name,
        currentValue: const d.Value(5000),
        creditLimit: const d.Value(50000),
      ),
    );

    final bankAccountId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Bank',
        icon: 'bank',
        accountType: AccountType.checkingAccount.name,
        currentValue: const d.Value(10000),
      ),
    );

    // Previous billing period.
    final previousPeriodId = await database
        .into(database.creditCardBillingPeriodsTable)
        .insert(
          CreditCardBillingPeriodsTableCompanion.insert(
            accountId: creditCardId,
            startDate: DateTime(2026, 8, 16),
            endDate: DateTime(2026, 9, 15),
            status: CreditCardBillingPeriodStatus.closed.name,
          ),
        );

    // Previous statement: ₱5,000 unpaid.
    await database
        .into(database.creditCardStatementsTable)
        .insert(
          CreditCardStatementsTableCompanion.insert(
            billingPeriodId: previousPeriodId,
            statementBalance: 5000,
            paymentDueDate: DateTime(2026, 9, 30),
            status: CreditCardStatementStatus.unpaid.name,
          ),
        );

    // Current billing period.
    final currentPeriodId = await database
        .into(database.creditCardBillingPeriodsTable)
        .insert(
          CreditCardBillingPeriodsTableCompanion.insert(
            accountId: creditCardId,
            startDate: DateTime(2026, 9, 16),
            endDate: DateTime(2026, 10, 15),
            status: CreditCardBillingPeriodStatus.open.name,
          ),
        );

    // ₱3,000 new purchase.
    await database
        .into(database.transactionsTable)
        .insert(
          TransactionsTableCompanion.insert(
            amount: 3000,
            date: DateTime(2026, 9, 20),
            transactionType: TransactionType.spend.name,
            accountId: d.Value(creditCardId),
          ),
        );

    // ₱1,000 payment during current billing period.
    await database
        .into(database.transactionsTable)
        .insert(
          TransactionsTableCompanion.insert(
            amount: 1000,
            date: DateTime(2026, 9, 25),
            transactionType: TransactionType.transfer.name,
            accountId: d.Value(bankAccountId),
            linkedAccountId: d.Value(creditCardId),
          ),
        );

    final balance = await database.creditCardDao.calculateStatementBalance(
      accountId: creditCardId,
      billingPeriodId: currentPeriodId,
    );

    // ₱5,000 carried forward
    // + ₱3,000 current purchases
    // - ₱1,000 current payments
    // = ₱7,000
    expect(balance, 7000);
  });

  ///#27
  test(
    'creditCardDao - remaining balance decreases from payment after statement closes',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementId = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: billingPeriodId,
              statementBalance: 6000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final remaining = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementId);

      expect(remaining, 4000);
    },
  );

  ///#28
  test(
    'creditCardDao - later payment does not incorrectly reduce older statement',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      // ------------------------------------------------------------
      // Statement A
      // Aug 16 → Sep 15
      // ------------------------------------------------------------

      final statementAPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementAId = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: statementAPeriodId,
              statementBalance: 6000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // ------------------------------------------------------------
      // ₱2,000 payment after Statement A closes.
      // This should reduce Statement A.
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      // ------------------------------------------------------------
      // Statement B
      // Sep 16 → Oct 15
      // ------------------------------------------------------------

      final statementBPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 16),
              endDate: DateTime(2026, 10, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: statementBPeriodId,
              statementBalance: 10000,
              paymentDueDate: DateTime(2026, 10, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // ------------------------------------------------------------
      // ₱3,000 payment after Statement B closes.
      //
      // This payment should belong to Statement B,
      // NOT Statement A.
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 3000,
              date: DateTime(2026, 10, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      // ------------------------------------------------------------
      // Statement A should only have received ₱2,000.
      //
      // ₱6,000 - ₱2,000 = ₱4,000
      // ------------------------------------------------------------

      final remainingA = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementAId);

      expect(remainingA, 4000);
    },
  );

  ///#29
  test(
    'creditCardDao - payments are applied to the correct consecutive statements',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      // ------------------------------------------------------------
      // Statement A
      // Aug 16 → Sep 15
      // ------------------------------------------------------------

      final statementAPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementAId = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: statementAPeriodId,
              statementBalance: 6000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // ------------------------------------------------------------
      // Payment for Statement A
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      // ------------------------------------------------------------
      // Statement B
      // Sep 16 → Oct 15
      // ------------------------------------------------------------

      final statementBPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 16),
              endDate: DateTime(2026, 10, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementBId = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: statementBPeriodId,
              statementBalance: 10000,
              paymentDueDate: DateTime(2026, 10, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // ------------------------------------------------------------
      // Payment for Statement B
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 3000,
              date: DateTime(2026, 10, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      // ------------------------------------------------------------
      // Statement C
      // Oct 16 → Nov 15
      // ------------------------------------------------------------

      final statementCPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 10, 16),
              endDate: DateTime(2026, 11, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementCId = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: statementCPeriodId,
              statementBalance: 8000,
              paymentDueDate: DateTime(2026, 11, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // ------------------------------------------------------------
      // Payment for Statement C
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 1500,
              date: DateTime(2026, 11, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      // ------------------------------------------------------------
      // Verify Statement A
      //
      // ₱6,000 - ₱2,000 = ₱4,000
      //
      // The ₱3,000 and ₱1,500 payments must NOT affect A.
      // ------------------------------------------------------------

      final remainingA = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementAId);

      expect(remainingA, 4000);

      // ------------------------------------------------------------
      // Verify Statement B
      //
      // ₱10,000 - ₱3,000 = ₱7,000
      //
      // The ₱2,000 and ₱1,500 payments must NOT affect B.
      // ------------------------------------------------------------

      final remainingB = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementBId);

      expect(remainingB, 7000);

      // ------------------------------------------------------------
      // Verify Statement C
      //
      // ₱8,000 - ₱1,500 = ₱6,500
      //
      // Earlier payments must NOT affect C.
      // ------------------------------------------------------------

      final remainingC = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementCId);

      expect(remainingC, 6500);
    },
  );

  ///#30
  test(
    'creditCardDao - multiple payments are summed for the same statement',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      // ------------------------------------------------------------
      // Statement A
      // Aug 16 → Sep 15
      // ------------------------------------------------------------

      final statementAPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementAId = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: statementAPeriodId,
              statementBalance: 6000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // ------------------------------------------------------------
      // First payment
      // ₱1,000
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 1000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      // ------------------------------------------------------------
      // Second payment
      // ₱2,000
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 25),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      // ------------------------------------------------------------
      // Third payment
      // ₱500
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 500,
              date: DateTime(2026, 9, 29),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      // ------------------------------------------------------------
      // Expected:
      //
      // Statement balance = ₱6,000
      //
      // Payments:
      // ₱1,000
      // ₱2,000
      // ₱500
      // -------
      // ₱3,500 total payments
      //
      // ₱6,000 - ₱3,500 = ₱2,500
      // ------------------------------------------------------------

      final remainingA = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementAId);

      expect(remainingA, 2500);
    },
  );

  ///#31
  test(
    'creditCardDao - partial payment leaves correct remaining balance',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementId = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: billingPeriodId,
              statementBalance: 5000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // ₱2,000 partial payment.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final remaining = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementId);

      expect(remaining, 3000);
    },
  );

  ///#32
  test('creditCardDao - full payment leaves zero remaining balance', () async {
    final creditCardId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Credit Card',
        icon: 'credit-card',
        accountType: AccountType.creditCard.name,
      ),
    );

    final bankAccountId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: 'Bank',
        icon: 'bank',
        accountType: AccountType.checkingAccount.name,
      ),
    );

    final billingPeriodId = await database
        .into(database.creditCardBillingPeriodsTable)
        .insert(
          CreditCardBillingPeriodsTableCompanion.insert(
            accountId: creditCardId,
            startDate: DateTime(2026, 8, 16),
            endDate: DateTime(2026, 9, 15),
            status: CreditCardBillingPeriodStatus.closed.name,
          ),
        );

    final statementId = await database
        .into(database.creditCardStatementsTable)
        .insert(
          CreditCardStatementsTableCompanion.insert(
            billingPeriodId: billingPeriodId,
            statementBalance: 5000,
            paymentDueDate: DateTime(2026, 9, 30),
            status: CreditCardStatementStatus.unpaid.name,
          ),
        );

    // Full ₱5,000 payment.
    await database
        .into(database.transactionsTable)
        .insert(
          TransactionsTableCompanion.insert(
            amount: 5000,
            date: DateTime(2026, 9, 20),
            transactionType: TransactionType.transfer.name,
            accountId: d.Value(bankAccountId),
            linkedAccountId: d.Value(creditCardId),
          ),
        );

    final remaining = await database.creditCardDao
        .calculateStatementRemainingBalance(statementId: statementId);

    expect(remaining, 0);
  });

  ///#33
  test(
    'creditCardDao - multiple payments progressively reduce statement balance',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementId = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: billingPeriodId,
              statementBalance: 5000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // First payment: ₱2,000.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      var remaining = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementId);

      expect(remaining, 3000);

      // Second payment: ₱3,000.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 3000,
              date: DateTime(2026, 9, 25),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      remaining = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementId);

      expect(remaining, 0);
    },
  );

  ///#34
  test(
    'creditCardDao - overpayment does not produce negative remaining balance',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementId = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: billingPeriodId,
              statementBalance: 5000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // Pay ₱6,000 against a ₱5,000 statement.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 6000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final remaining = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementId);

      expect(remaining, 0);
    },
  );

  ///#35
  test(
    '35 | creditCardDao - payment before statement closes does not reduce statement',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementId = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: billingPeriodId,
              statementBalance: 5000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // Payment occurs BEFORE the statement closes.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 10),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final remaining = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementId);

      expect(remaining, 5000);
    },
  );

  ///#36
  test(
    '36 | creditCardDao - payment reduces only the latest cumulative statement',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      Future<int> createStatement({
        required DateTime startDate,
        required DateTime endDate,
        required double balance,
        required String status,
      }) async {
        final periodId = await database
            .into(database.creditCardBillingPeriodsTable)
            .insert(
              CreditCardBillingPeriodsTableCompanion.insert(
                accountId: creditCardId,
                startDate: startDate,
                endDate: endDate,
                status: CreditCardBillingPeriodStatus.closed.name,
              ),
            );

        return database
            .into(database.creditCardStatementsTable)
            .insert(
              CreditCardStatementsTableCompanion.insert(
                billingPeriodId: periodId,
                statementBalance: balance,
                paymentDueDate: endDate.add(const Duration(days: 15)),
                status: status,
              ),
            );
      }

      final statementA = await createStatement(
        startDate: DateTime(2026, 6, 16),
        endDate: DateTime(2026, 7, 15),
        balance: 5000,
        status: CreditCardStatementStatus.carriedForward.name,
      );

      final statementB = await createStatement(
        startDate: DateTime(2026, 7, 16),
        endDate: DateTime(2026, 8, 15),
        balance: 7000,
        status: CreditCardStatementStatus.carriedForward.name,
      );

      final statementC = await createStatement(
        startDate: DateTime(2026, 8, 16),
        endDate: DateTime(2026, 9, 15),
        balance: 4000,
        status: CreditCardStatementStatus.unpaid.name,
      );

      // Payment occurs after C closes.
      //
      // C is the only current payable statement.
      //
      // Payment = ₱4,000
      // C remaining = ₱0
      //
      // A and B are historical carried-forward statements.

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 4000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final remainingC = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementC);

      expect(remainingC, 0);

      final remainingA = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementA);

      final remainingB = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementB);

      // Historical statements have no independently payable balance.
      expect(remainingA, 0);
      expect(remainingB, 0);
    },
  );

  ///#37
  test(
    '37 | creditCardDao - unpaid balance carries forward after partial payment',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      final periodA = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementA = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: periodA,
              statementBalance: 5000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // Pay ₱2,000 against statement A.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      // A still has ₱3,000 outstanding.
      final remainingA = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementA);

      expect(remainingA, 3000);

      // ------------------------------------------------------------
      // New billing period.
      // ------------------------------------------------------------

      final periodB = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 16),
              endDate: DateTime(2026, 10, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      // B carries forward A's remaining ₱3,000.
      final statementB = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: periodB,
              statementBalance: 3000,
              paymentDueDate: DateTime(2026, 10, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      final remainingB = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementB);

      expect(remainingB, 3000);

      // ------------------------------------------------------------
      // A is now explicitly historical.
      // ------------------------------------------------------------

      await (database.update(
        database.creditCardStatementsTable,
      )..where((tbl) => tbl.id.equals(statementA))).write(
        CreditCardStatementsTableCompanion(
          status: d.Value(CreditCardStatementStatus.carriedForward.name),
        ),
      );

      final historicalA = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementA);

      expect(historicalA, 0);
    },
  );

  ///#38
  test(
    '38 | creditCardDao - carried-forward balance combines with new spending',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      // ------------------------------------------------------------
      // Statement A
      // ------------------------------------------------------------

      final periodA = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementA = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: periodA,
              statementBalance: 5000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // Pay ₱2,000.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final remainingA = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementA);

      expect(remainingA, 3000);

      // ------------------------------------------------------------
      // Statement B
      // ------------------------------------------------------------

      final periodB = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 16),
              endDate: DateTime(2026, 10, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      // New spending during B = ₱4,000.
      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 4000,
              date: DateTime(2026, 10, 1),
              transactionType: TransactionType.spend.name,
              accountId: d.Value(creditCardId),
            ),
          );

      // B cumulative statement:
      //
      // ₱3,000 carried forward
      // + ₱4,000 new spending
      // = ₱7,000

      final statementB = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: periodB,
              statementBalance: 7000,
              paymentDueDate: DateTime(2026, 10, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      final remainingB = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementB);

      expect(remainingB, 7000);

      // A becomes historical.
      await (database.update(
        database.creditCardStatementsTable,
      )..where((tbl) => tbl.id.equals(statementA))).write(
        CreditCardStatementsTableCompanion(
          status: d.Value(CreditCardStatementStatus.carriedForward.name),
        ),
      );

      final historicalA = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementA);

      expect(historicalA, 0);
    },
  );

  ///#39
  test(
    '39 | creditCardDao - closeBillingPeriod carries forward unpaid balance',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      // ------------------------------------------------------------
      // Credit card configuration.
      // ------------------------------------------------------------

      await database.creditCardDao.insert(
        CreditCardDetailsTableCompanion.insert(
          accountId: d.Value(creditCardId),
          statementDay: 15,
          paymentDueDay: 30,
          nextStatementDate: DateTime(2026, 9, 15),
          nextPaymentDueDate: DateTime(2026, 9, 30),
        ),
      );

      // ------------------------------------------------------------
      // Current open billing period.
      //
      // Aug 16 → Sep 15
      // ------------------------------------------------------------

      final periodA = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // ------------------------------------------------------------
      // ₱5,000 spending during the billing period.
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 5000,
              date: DateTime(2026, 9, 1),
              transactionType: TransactionType.spend.name,
              accountId: d.Value(creditCardId),
            ),
          );

      // ------------------------------------------------------------
      // ₱2,000 payment during the billing period.
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 10),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      // ------------------------------------------------------------
      // Close the billing period.
      //
      // Expected statement:
      //
      // ₱5,000 spending
      // - ₱2,000 payment
      // = ₱3,000 statement balance
      // ------------------------------------------------------------

      final statement = await database.creditCardDao.closeBillingPeriod(
        accountId: creditCardId,
      );

      expect(statement, isNotNull);
      expect(statement!.statementBalance, 3000);
      expect(statement.status, CreditCardStatementStatus.unpaid.name);

      // ------------------------------------------------------------
      // The old billing period should now be closed.
      // ------------------------------------------------------------

      final closedPeriod = await (database.select(
        database.creditCardBillingPeriodsTable,
      )..where((tbl) => tbl.id.equals(periodA))).getSingle();

      expect(closedPeriod.status, CreditCardBillingPeriodStatus.closed.name);

      // ------------------------------------------------------------
      // A new billing period should have been created.
      // ------------------------------------------------------------

      final openPeriod = await database.creditCardDao.getOpenBillingPeriod(
        creditCardId,
      );

      expect(openPeriod, isNotNull);
      expect(openPeriod!.startDate, DateTime(2026, 9, 16));
      expect(openPeriod.endDate, DateTime(2026, 10, 15));

      // ------------------------------------------------------------
      // Now make a partial payment against the statement.
      //
      // ₱3,000 statement
      // - ₱1,000 payment
      // = ₱2,000 remaining
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 1000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final remainingBeforeNextClose = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statement.id);

      expect(remainingBeforeNextClose, 2000);

      // ------------------------------------------------------------
      // Close the next billing period.
      //
      // The ₱2,000 unpaid balance should be carried forward.
      // ------------------------------------------------------------

      final secondStatement = await database.creditCardDao.closeBillingPeriod(
        accountId: creditCardId,
      );

      expect(secondStatement, isNotNull);
      expect(secondStatement!.statementBalance, 2000);

      // ------------------------------------------------------------
      // Old statement must now be historical.
      // ------------------------------------------------------------

      final oldStatement = await (database.select(
        database.creditCardStatementsTable,
      )..where((tbl) => tbl.id.equals(statement.id))).getSingle();

      expect(
        oldStatement.status,
        CreditCardStatementStatus.carriedForward.name,
      );

      final historicalRemaining = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statement.id);

      expect(historicalRemaining, 0);

      // ------------------------------------------------------------
      // New cumulative statement remains payable.
      // ------------------------------------------------------------

      final currentRemaining = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: secondStatement.id);

      expect(currentRemaining, 2000);
    },
  );

  ///#40
  test(
    '40 | creditCardDao - closeBillingPeriod combines carried-forward balance with new spending',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      await database.creditCardDao.insert(
        CreditCardDetailsTableCompanion.insert(
          accountId: d.Value(creditCardId),
          statementDay: 15,
          paymentDueDay: 30,
          nextStatementDate: DateTime(2026, 10, 15),
          nextPaymentDueDate: DateTime(2026, 10, 30),
        ),
      );

      // ------------------------------------------------------------
      // Previous billing period
      // ------------------------------------------------------------

      final periodA = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementA = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: periodA,
              statementBalance: 5000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // ------------------------------------------------------------
      // Partial payment against previous statement.
      //
      // Previous statement:
      // ₱5,000 - ₱2,000 payment = ₱3,000 outstanding
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final remainingA = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementA);

      expect(remainingA, 3000);

      // ------------------------------------------------------------
      // Current OPEN billing period.
      // ------------------------------------------------------------

      final periodB = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 16),
              endDate: DateTime(2026, 10, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // ------------------------------------------------------------
      // New spending during current period.
      //
      // ₱3,000 carried forward
      // + ₱4,000 new spending
      // = ₱7,000
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 4000,
              date: DateTime(2026, 10, 1),
              transactionType: TransactionType.spend.name,
              accountId: d.Value(creditCardId),
            ),
          );

      // ------------------------------------------------------------
      // Close current billing period.
      // ------------------------------------------------------------

      final statementB = await database.creditCardDao.closeBillingPeriod(
        accountId: creditCardId,
      );

      expect(statementB, isNotNull);

      // ------------------------------------------------------------
      // New statement contains:
      //
      // ₱3,000 carried forward
      // + ₱4,000 new spending
      // = ₱7,000
      // ------------------------------------------------------------

      expect(statementB!.statementBalance, 7000);

      // ------------------------------------------------------------
      // Previous statement becomes historical.
      // ------------------------------------------------------------

      final historicalA = await (database.select(
        database.creditCardStatementsTable,
      )..where((tbl) => tbl.id.equals(statementA))).getSingle();

      expect(historicalA.status, CreditCardStatementStatus.carriedForward.name);

      // ------------------------------------------------------------
      // New statement remains unpaid.
      // ------------------------------------------------------------

      expect(statementB.status, CreditCardStatementStatus.unpaid.name);

      // ------------------------------------------------------------
      // Current period is now closed.
      // ------------------------------------------------------------

      final closedPeriod = await (database.select(
        database.creditCardBillingPeriodsTable,
      )..where((tbl) => tbl.id.equals(periodB))).getSingle();

      expect(closedPeriod.status, CreditCardBillingPeriodStatus.closed.name);
    },
  );

  ///#41
  test(
    '41 | creditCardDao - closeBillingPeriod creates next open billing period',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      await database.creditCardDao.insert(
        CreditCardDetailsTableCompanion.insert(
          accountId: d.Value(creditCardId),
          statementDay: 15,
          paymentDueDay: 30,
          nextStatementDate: DateTime(2026, 10, 15),
          nextPaymentDueDate: DateTime(2026, 10, 30),
        ),
      );

      // ------------------------------------------------------------
      // Current OPEN billing period.
      // ------------------------------------------------------------

      final periodA = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 16),
              endDate: DateTime(2026, 10, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // ------------------------------------------------------------
      // Close the current billing period.
      // ------------------------------------------------------------

      final statement = await database.creditCardDao.closeBillingPeriod(
        accountId: creditCardId,
      );

      expect(statement, isNotNull);

      // ------------------------------------------------------------
      // Current period should now be CLOSED.
      // ------------------------------------------------------------

      final closedPeriod = await (database.select(
        database.creditCardBillingPeriodsTable,
      )..where((tbl) => tbl.id.equals(periodA))).getSingle();

      expect(closedPeriod.status, CreditCardBillingPeriodStatus.closed.name);

      // ------------------------------------------------------------
      // The next billing period should exist and be OPEN.
      // ------------------------------------------------------------

      final nextPeriod = await database.creditCardDao.getOpenBillingPeriod(
        creditCardId,
      );

      expect(nextPeriod, isNotNull);

      // ------------------------------------------------------------
      // Next period starts the day after the previous period ends.
      // ------------------------------------------------------------

      expect(nextPeriod!.startDate, DateTime(2026, 10, 16));

      // ------------------------------------------------------------
      // Statement day is 15.
      //
      // Therefore the next statement closes on Nov 15.
      // ------------------------------------------------------------

      expect(nextPeriod.endDate, DateTime(2026, 11, 15));

      // ------------------------------------------------------------
      // Next period must remain OPEN.
      // ------------------------------------------------------------

      expect(nextPeriod.status, CreditCardBillingPeriodStatus.open.name);
    },
  );

  ///#42
  test(
    '42 | creditCardDao - closeBillingPeriod advances December into January',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      await database.creditCardDao.insert(
        CreditCardDetailsTableCompanion.insert(
          accountId: d.Value(creditCardId),
          statementDay: 15,
          paymentDueDay: 30,
          nextStatementDate: DateTime(2027, 1, 15),
          nextPaymentDueDate: DateTime(2027, 1, 30),
        ),
      );

      // ------------------------------------------------------------
      // Current OPEN billing period.
      //
      // December statement closes on Dec 15.
      // ------------------------------------------------------------

      final periodA = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 11, 16),
              endDate: DateTime(2026, 12, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // ------------------------------------------------------------
      // Close December billing period.
      // ------------------------------------------------------------

      final statement = await database.creditCardDao.closeBillingPeriod(
        accountId: creditCardId,
      );

      expect(statement, isNotNull);

      // ------------------------------------------------------------
      // December period should now be CLOSED.
      // ------------------------------------------------------------

      final closedPeriod = await (database.select(
        database.creditCardBillingPeriodsTable,
      )..where((tbl) => tbl.id.equals(periodA))).getSingle();

      expect(closedPeriod.status, CreditCardBillingPeriodStatus.closed.name);

      // ------------------------------------------------------------
      // January billing period should now be OPEN.
      // ------------------------------------------------------------

      final nextPeriod = await database.creditCardDao.getOpenBillingPeriod(
        creditCardId,
      );

      expect(nextPeriod, isNotNull);

      // ------------------------------------------------------------
      // December 15 + 1 day = December 16.
      // ------------------------------------------------------------

      expect(nextPeriod!.startDate, DateTime(2026, 12, 16));

      // ------------------------------------------------------------
      // Statement day remains the 15th.
      //
      // December → January must roll over correctly.
      // ------------------------------------------------------------

      expect(nextPeriod.endDate, DateTime(2027, 1, 15));

      expect(nextPeriod.status, CreditCardBillingPeriodStatus.open.name);
    },
  );

  ///#43
  test(
    '43 | creditCardDao - closeBillingPeriod clamps statement day when next month is shorter',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      await database.creditCardDao.insert(
        CreditCardDetailsTableCompanion.insert(
          accountId: d.Value(creditCardId),
          statementDay: 31,
          paymentDueDay: 15,
          nextStatementDate: DateTime(2026, 1, 31),
          nextPaymentDueDate: DateTime(2026, 2, 15),
        ),
      );

      // ------------------------------------------------------------
      // Current billing period.
      //
      // Statement closes January 31.
      // ------------------------------------------------------------

      await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 1, 1),
              endDate: DateTime(2026, 1, 31),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // ------------------------------------------------------------
      // Close current billing period.
      //
      // The configured statement day is 31.
      // February does not have a 31st.
      //
      // Therefore the next billing period should end
      // on February 28, 2026.
      // ------------------------------------------------------------

      final statement = await database.creditCardDao.closeBillingPeriod(
        accountId: creditCardId,
      );

      expect(statement, isNotNull);

      // ------------------------------------------------------------
      // Verify next billing period.
      // ------------------------------------------------------------

      final nextPeriod =
          await (database.select(database.creditCardBillingPeriodsTable)..where(
                (tbl) =>
                    tbl.accountId.equals(creditCardId) &
                    tbl.status.equals(CreditCardBillingPeriodStatus.open.name),
              ))
              .getSingle();

      expect(nextPeriod.startDate, DateTime(2026, 2, 1));
      expect(nextPeriod.endDate, DateTime(2026, 2, 28));
    },
  );

  ///#44
  test(
    '44 | creditCardDao - closeBillingPeriod carries forward unpaid balance with no new spending',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      await database.creditCardDao.insert(
        CreditCardDetailsTableCompanion.insert(
          accountId: d.Value(creditCardId),
          statementDay: 15,
          paymentDueDay: 30,
          nextStatementDate: DateTime(2026, 10, 15),
          nextPaymentDueDate: DateTime(2026, 10, 30),
        ),
      );

      // ------------------------------------------------------------
      // Previous billing period.
      // ------------------------------------------------------------

      final periodA = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementA = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: periodA,
              statementBalance: 5000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // ------------------------------------------------------------
      // Partial payment.
      //
      // ₱5,000 - ₱2,000 = ₱3,000 outstanding.
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final remainingA = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementA);

      expect(remainingA, 3000);

      // ------------------------------------------------------------
      // Current OPEN billing period.
      // ------------------------------------------------------------

      await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 16),
              endDate: DateTime(2026, 10, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // ------------------------------------------------------------
      // NO new spending.
      //
      // The only outstanding balance is:
      //
      // ₱3,000 carried forward.
      // ------------------------------------------------------------

      final statementB = await database.creditCardDao.closeBillingPeriod(
        accountId: creditCardId,
      );

      expect(statementB, isNotNull);

      // The new statement should contain exactly
      // the outstanding carried-forward balance.
      expect(statementB!.statementBalance, 3000);

      // Previous statement becomes historical.
      final historicalA = await (database.select(
        database.creditCardStatementsTable,
      )..where((tbl) => tbl.id.equals(statementA))).getSingle();

      expect(historicalA.status, CreditCardStatementStatus.carriedForward.name);

      // New statement remains unpaid.
      expect(statementB.status, CreditCardStatementStatus.unpaid.name);
    },
  );

  ///#45
  test(
    '45 | creditCardDao - partial payment reduces carried-forward cumulative statement',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      final bankAccountId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Bank',
          icon: 'bank',
          accountType: AccountType.checkingAccount.name,
        ),
      );

      await database.creditCardDao.insert(
        CreditCardDetailsTableCompanion.insert(
          accountId: d.Value(creditCardId),
          statementDay: 15,
          paymentDueDay: 30,
          nextStatementDate: DateTime(2026, 10, 15),
          nextPaymentDueDate: DateTime(2026, 10, 30),
        ),
      );

      // ------------------------------------------------------------
      // Previous billing period.
      // ------------------------------------------------------------

      final periodA = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 8, 16),
              endDate: DateTime(2026, 9, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      final statementA = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: periodA,
              statementBalance: 5000,
              paymentDueDate: DateTime(2026, 9, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // ------------------------------------------------------------
      // Partial payment against statement A.
      //
      // ₱5,000 - ₱2,000 = ₱3,000 outstanding.
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2000,
              date: DateTime(2026, 9, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final remainingA = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementA);

      expect(remainingA, 3000);

      // ------------------------------------------------------------
      // New billing period.
      // ------------------------------------------------------------

      final periodB = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 16),
              endDate: DateTime(2026, 10, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // ------------------------------------------------------------
      // New spending.
      //
      // ₱3,000 carried forward
      // + ₱4,000 new spending
      // = ₱7,000 cumulative balance.
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 4000,
              date: DateTime(2026, 10, 1),
              transactionType: TransactionType.spend.name,
              accountId: d.Value(creditCardId),
            ),
          );

      final statementB = await database.creditCardDao.closeBillingPeriod(
        accountId: creditCardId,
      );

      expect(statementB, isNotNull);
      expect(statementB!.statementBalance, 7000);

      // ------------------------------------------------------------
      // Pay ₱2,500 against the new cumulative statement.
      //
      // ₱7,000 - ₱2,500 = ₱4,500 remaining.
      // ------------------------------------------------------------

      await database
          .into(database.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              amount: 2500,
              date: DateTime(2026, 10, 20),
              transactionType: TransactionType.transfer.name,
              accountId: d.Value(bankAccountId),
              linkedAccountId: d.Value(creditCardId),
            ),
          );

      final remainingB = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementB.id);

      expect(remainingB, 4500);

      // ------------------------------------------------------------
      // The historical statement must remain zero.
      // ------------------------------------------------------------

      final historicalA = await database.creditCardDao
          .calculateStatementRemainingBalance(statementId: statementA);

      expect(historicalA, 0);
    },
  );

  ///#46
  test(
    '46 | AccountsDao - creates a credit card with billing details atomically',
    () async {
      final accountId = await database.accountsDao.createCreditCard(
        account: AccountsTableCompanion.insert(
          name: 'My Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
        statementDay: 15,
        paymentDueDay: 30,
        nextStatementDate: DateTime(2026, 10, 15),
        nextPaymentDueDate: DateTime(2026, 10, 30),
      );

      // ------------------------------------------------------------
      // Account was created.
      // ------------------------------------------------------------

      final account = await (database.select(
        database.accountsTable,
      )..where((tbl) => tbl.id.equals(accountId))).getSingle();

      expect(account.name, 'My Credit Card');
      expect(account.icon, 'credit-card');
      expect(account.accountType, AccountType.creditCard.name);

      // ------------------------------------------------------------
      // Credit card billing details were created.
      // ------------------------------------------------------------

      final details = await (database.select(
        database.creditCardDetailsTable,
      )..where((tbl) => tbl.accountId.equals(accountId))).getSingle();

      expect(details.accountId, accountId);
      expect(details.statementDay, 15);
      expect(details.paymentDueDay, 30);
      expect(details.nextStatementDate, DateTime(2026, 10, 15));
      expect(details.nextPaymentDueDate, DateTime(2026, 10, 30));
    },
  );

  ///#47
  test(
    '47 | AccountsDao - returned credit card ID references the created account',
    () async {
      final accountId = await database.accountsDao.createCreditCard(
        account: AccountsTableCompanion.insert(
          name: 'Visa',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
        statementDay: 20,
        paymentDueDay: 5,
        nextStatementDate: DateTime(2026, 10, 20),
        nextPaymentDueDate: DateTime(2026, 11, 5),
      );

      final account = await (database.select(
        database.accountsTable,
      )..where((tbl) => tbl.id.equals(accountId))).getSingle();

      final details = await (database.select(
        database.creditCardDetailsTable,
      )..where((tbl) => tbl.accountId.equals(accountId))).getSingle();

      expect(account.id, accountId);
      expect(account.accountType, AccountType.creditCard.name);

      expect(details.accountId, accountId);
      expect(details.statementDay, 20);
      expect(details.paymentDueDay, 5);
      expect(details.nextStatementDate, DateTime(2026, 10, 20));
      expect(details.nextPaymentDueDate, DateTime(2026, 11, 5));
    },
  );

  ///#48
  test(
    '48 | CreditCardDetailsTable - deleting account cascades to credit card details',
    () async {
      final accountId = await database.accountsDao.createCreditCard(
        account: AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
        statementDay: 15,
        paymentDueDay: 30,
        nextStatementDate: DateTime(2026, 10, 15),
        nextPaymentDueDate: DateTime(2026, 10, 30),
      );

      // ------------------------------------------------------------
      // Verify credit card details exist.
      // ------------------------------------------------------------

      final beforeDelete = await (database.select(
        database.creditCardDetailsTable,
      )..where((tbl) => tbl.accountId.equals(accountId))).getSingle();

      expect(beforeDelete.accountId, accountId);

      // ------------------------------------------------------------
      // Delete the parent account.
      //
      // CreditCardDetailsTable.accountId uses
      // ON DELETE CASCADE.
      // ------------------------------------------------------------

      await (database.delete(
        database.accountsTable,
      )..where((tbl) => tbl.id.equals(accountId))).go();

      // ------------------------------------------------------------
      // Credit card details should have been deleted automatically.
      // ------------------------------------------------------------

      final afterDelete = await (database.select(
        database.creditCardDetailsTable,
      )..where((tbl) => tbl.accountId.equals(accountId))).get();

      expect(afterDelete, isEmpty);
    },
  );

  ///#49
  test(
    '49 | CreditCardBillingPeriods and Statements - deleting credit card cascades dependent records',
    () async {
      final creditCardId = await database.accountsDao.insertAccount(
        AccountsTableCompanion.insert(
          name: 'Credit Card',
          icon: 'credit-card',
          accountType: AccountType.creditCard.name,
        ),
      );

      // ------------------------------------------------------------
      // Credit card details
      // ------------------------------------------------------------

      await database.creditCardDao.insert(
        CreditCardDetailsTableCompanion.insert(
          accountId: d.Value(creditCardId),
          statementDay: 15,
          paymentDueDay: 30,
          nextStatementDate: DateTime(2026, 10, 15),
          nextPaymentDueDate: DateTime(2026, 10, 30),
        ),
      );

      // ------------------------------------------------------------
      // Billing period
      // ------------------------------------------------------------

      final billingPeriodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: creditCardId,
              startDate: DateTime(2026, 9, 16),
              endDate: DateTime(2026, 10, 15),
              status: CreditCardBillingPeriodStatus.closed.name,
            ),
          );

      // ------------------------------------------------------------
      // Statement belonging to that billing period
      // ------------------------------------------------------------

      final statementId = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: billingPeriodId,
              statementBalance: 5000,
              paymentDueDate: DateTime(2026, 10, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // Verify everything exists before deletion.
      final detailsBefore = await (database.select(
        database.creditCardDetailsTable,
      )..where((tbl) => tbl.accountId.equals(creditCardId))).get();

      final periodsBefore = await (database.select(
        database.creditCardBillingPeriodsTable,
      )..where((tbl) => tbl.accountId.equals(creditCardId))).get();

      final statementsBefore = await (database.select(
        database.creditCardStatementsTable,
      )..where((tbl) => tbl.id.equals(statementId))).get();

      expect(detailsBefore, hasLength(1));
      expect(periodsBefore, hasLength(1));
      expect(statementsBefore, hasLength(1));

      // ------------------------------------------------------------
      // Delete the credit-card account.
      // ------------------------------------------------------------

      await (database.delete(
        database.accountsTable,
      )..where((tbl) => tbl.id.equals(creditCardId))).go();

      // ------------------------------------------------------------
      // All dependent credit-card records should be gone.
      // ------------------------------------------------------------

      final detailsAfter = await (database.select(
        database.creditCardDetailsTable,
      )..where((tbl) => tbl.accountId.equals(creditCardId))).get();

      final periodsAfter = await (database.select(
        database.creditCardBillingPeriodsTable,
      )..where((tbl) => tbl.accountId.equals(creditCardId))).get();

      final statementsAfter = await (database.select(
        database.creditCardStatementsTable,
      )..where((tbl) => tbl.id.equals(statementId))).get();

      expect(detailsAfter, isEmpty);
      expect(periodsAfter, isEmpty);
      expect(statementsAfter, isEmpty);
    },
  );

  ///50
  test(
    '50 | CreditCard cascade - deleting one credit card does not affect another credit card',
    () async {
      final accountId1 = await database.accountsDao.createCreditCard(
        account: AccountsTableCompanion.insert(
          name: 'Credit Card 1',
          accountType: AccountType.creditCard.name,
          currentValue: const d.Value(0),
          icon: 'credit-card',
        ),
        statementDay: 15,
        paymentDueDay: 30,
        nextStatementDate: DateTime(2026, 10, 15),
        nextPaymentDueDate: DateTime(2026, 10, 30),
      );

      final accountId2 = await database.accountsDao.createCreditCard(
        account: AccountsTableCompanion.insert(
          name: 'Credit Card 2',
          accountType: AccountType.creditCard.name,
          currentValue: const d.Value(0),
          icon: 'credit-card',
        ),
        statementDay: 20,
        paymentDueDay: 5,
        nextStatementDate: DateTime(2026, 10, 20),
        nextPaymentDueDate: DateTime(2026, 11, 5),
      );

      // Create dependent records for both cards.
      await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: accountId1,
              startDate: DateTime(2026, 9, 16),
              endDate: DateTime(2026, 10, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: accountId2,
              startDate: DateTime(2026, 9, 21),
              endDate: DateTime(2026, 10, 20),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // Delete only the first account.
      await (database.delete(
        database.accountsTable,
      )..where((tbl) => tbl.id.equals(accountId1))).go();

      // First card and its details are gone.
      final deletedDetails = await (database.select(
        database.creditCardDetailsTable,
      )..where((tbl) => tbl.accountId.equals(accountId1))).get();

      expect(deletedDetails, isEmpty);

      // Second card is completely untouched.
      final remainingAccount = await (database.select(
        database.accountsTable,
      )..where((tbl) => tbl.id.equals(accountId2))).getSingleOrNull();

      expect(remainingAccount, isNotNull);
      expect(remainingAccount!.id, accountId2);

      final remainingDetails = await (database.select(
        database.creditCardDetailsTable,
      )..where((tbl) => tbl.accountId.equals(accountId2))).get();

      expect(remainingDetails, hasLength(1));
      expect(remainingDetails.single.accountId, accountId2);

      final remainingPeriods = await (database.select(
        database.creditCardBillingPeriodsTable,
      )..where((tbl) => tbl.accountId.equals(accountId2))).get();

      expect(remainingPeriods, hasLength(1));
    },
  );

  ///51
  test(
    '51 | CreditCardBillingPeriods cascade - deleting a billing period deletes its statements',
    () async {
      final accountId = await database.accountsDao.createCreditCard(
        account: AccountsTableCompanion.insert(
          name: 'Credit Card',
          accountType: AccountType.creditCard.name,
          currentValue: const d.Value(0),
          icon: 'credit_card',
        ),
        statementDay: 15,
        paymentDueDay: 30,
        nextStatementDate: DateTime(2026, 10, 15),
        nextPaymentDueDate: DateTime(2026, 10, 30),
      );

      // Create billing period.
      final periodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: accountId,
              startDate: DateTime(2026, 9, 16),
              endDate: DateTime(2026, 10, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // Create statement belonging to that billing period.
      final statementId = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: periodId,
              statementBalance: 1000,
              paymentDueDate: DateTime(2026, 10, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // Sanity check: statement exists.
      final beforeDelete = await (database.select(
        database.creditCardStatementsTable,
      )..where((tbl) => tbl.id.equals(statementId))).get();

      expect(beforeDelete, hasLength(1));

      // Delete the billing period.
      await (database.delete(
        database.creditCardBillingPeriodsTable,
      )..where((tbl) => tbl.id.equals(periodId))).go();

      // Statement should be deleted through cascade.
      final remainingStatements = await (database.select(
        database.creditCardStatementsTable,
      )..where((tbl) => tbl.billingPeriodId.equals(periodId))).get();

      expect(remainingStatements, isEmpty);

      // Account itself must remain.
      final remainingAccount = await (database.select(
        database.accountsTable,
      )..where((tbl) => tbl.id.equals(accountId))).getSingleOrNull();

      expect(remainingAccount, isNotNull);
    },
  );

  ///52
  test(
    '52 | CreditCardStatements - deleting a statement does not delete its billing period',
    () async {
      final accountId = await database.accountsDao.createCreditCard(
        account: AccountsTableCompanion.insert(
          name: 'Credit Card',
          accountType: AccountType.creditCard.name,
          currentValue: const d.Value(0),
          icon: 'credit_card',
        ),
        statementDay: 15,
        paymentDueDay: 30,
        nextStatementDate: DateTime(2026, 10, 15),
        nextPaymentDueDate: DateTime(2026, 10, 30),
      );

      // Create billing period.
      final periodId = await database
          .into(database.creditCardBillingPeriodsTable)
          .insert(
            CreditCardBillingPeriodsTableCompanion.insert(
              accountId: accountId,
              startDate: DateTime(2026, 9, 16),
              endDate: DateTime(2026, 10, 15),
              status: CreditCardBillingPeriodStatus.open.name,
            ),
          );

      // Create statement belonging to the billing period.
      final statementId = await database
          .into(database.creditCardStatementsTable)
          .insert(
            CreditCardStatementsTableCompanion.insert(
              billingPeriodId: periodId,
              statementBalance: 1000,
              paymentDueDate: DateTime(2026, 10, 30),
              status: CreditCardStatementStatus.unpaid.name,
            ),
          );

      // Sanity check: both records exist.
      final periodBeforeDelete = await (database.select(
        database.creditCardBillingPeriodsTable,
      )..where((tbl) => tbl.id.equals(periodId))).get();

      final statementBeforeDelete = await (database.select(
        database.creditCardStatementsTable,
      )..where((tbl) => tbl.id.equals(statementId))).get();

      expect(periodBeforeDelete, hasLength(1));
      expect(statementBeforeDelete, hasLength(1));

      // Delete only the statement.
      await (database.delete(
        database.creditCardStatementsTable,
      )..where((tbl) => tbl.id.equals(statementId))).go();

      // Statement should be gone.
      final remainingStatements = await (database.select(
        database.creditCardStatementsTable,
      )..where((tbl) => tbl.id.equals(statementId))).get();

      expect(remainingStatements, isEmpty);

      // Billing period must remain.
      final remainingPeriod = await (database.select(
        database.creditCardBillingPeriodsTable,
      )..where((tbl) => tbl.id.equals(periodId))).get();

      expect(remainingPeriod, hasLength(1));
      expect(remainingPeriod.single.id, periodId);
      expect(remainingPeriod.single.accountId, accountId);
    },
  );
}
