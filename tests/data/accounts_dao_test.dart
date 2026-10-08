// // ignore_for_file: unused_local_variable

// import 'package:flutter_test/flutter_test.dart';
// import 'package:getx_drift_app/data/app_database.dart';
// import 'package:getx_drift_app/data/database/daos/accounts_dao/accounts_dao.dart';
// import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
// import 'package:drift/drift.dart' as d;
// import 'package:drift/native.dart';

// void main() {
//   late AppDatabase database;
//   late AccountsDao dao;

//   setUp(() {
//     database = AppDatabase.forTesting(NativeDatabase.memory());

//     dao = database.accountsDao;
//   });

//   tearDown(() async {
//     await database.close();
//   });

//   // ===========================================================================
//   // ACCOUNT CRUD
//   // ===========================================================================

//   group('AccountsDao - Account CRUD', () {
//     test('inserts and retrieves an account', () async {
//       final accountId = await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//           currentValue: const d.Value(1000),
//         ),
//       );

//       final result = await dao.getAccountById(accountId);

//       expect(result, isNotNull);
//       expect(result!.id, accountId);
//       expect(result.name, 'Cash');
//       expect(result.icon, 'wallet');
//       expect(result.accountType, AccountType.cash.name);
//       expect(result.currentValue, 1000);
//     });

//     test('returns null when account does not exist', () async {
//       final result = await dao.getAccountById(999);

//       expect(result, isNull);
//     });

//     test('gets all accounts', () async {
//       await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//           currentValue: const d.Value(1000),
//         ),
//       );

//       await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Savings',
//           icon: 'bank',
//           accountType: AccountType.savingsAccount.name,
//           currentValue: const d.Value(5000),
//         ),
//       );

//       final accounts = await dao.getAllAccounts();

//       expect(accounts.length, 2);
//       expect(accounts.map((e) => e.name), containsAll(['Cash', 'Savings']));
//     });

//     test('updates an account', () async {
//       final accountId = await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//           currentValue: const d.Value(1000),
//         ),
//       );

//       await dao.updateAccount(
//         accountId,
//         const AccountsTableCompanion(
//           name: d.Value('Main Cash'),
//           currentValue: d.Value(2500),
//         ),
//       );

//       final result = await dao.getAccountById(accountId);

//       expect(result, isNotNull);
//       expect(result!.name, 'Main Cash');
//       expect(result.currentValue, 2500);
//     });

//     test('deletes an account', () async {
//       final accountId = await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//         ),
//       );

//       await dao.deleteAccount(accountId);

//       final result = await dao.getAccountById(accountId);

//       expect(result, isNull);
//     });
//   });

//   // ===========================================================================
//   // ACCOUNT NAME
//   // ===========================================================================

//   group('AccountsDao - Account Name', () {
//     test('detects an existing account name', () async {
//       await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Main Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//         ),
//       );

//       expect(await dao.accountNameExists('Main Cash'), isTrue);
//     });

//     test('returns false for a non-existing account name', () async {
//       expect(await dao.accountNameExists('Does Not Exist'), isFalse);
//     });

//     test('trims account name before checking', () async {
//       await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Main Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//         ),
//       );

//       expect(await dao.accountNameExists('  Main Cash  '), isTrue);
//     });
//   });

//   // ===========================================================================
//   // CREDIT CARDS
//   // ===========================================================================

//   group('AccountsDao - Credit Cards', () {
//     test('creates a credit card account with billing details', () async {
//       final accountId = await dao.createCreditCard(
//         account: AccountsTableCompanion.insert(
//           name: 'BPI Credit Card',
//           icon: 'credit_card',
//           accountType: AccountType.creditCard.name,
//           currentValue: const d.Value(0),
//           creditLimit: const d.Value(100000),
//         ),
//         statementDay: 23,
//         paymentDueDay: 24,
//         nextStatementDate: DateTime(2026, 9, 23),
//         nextPaymentDueDate: DateTime(2026, 9, 24),
//       );

//       final account = await dao.getAccountById(accountId);

//       expect(account, isNotNull);
//       expect(account!.name, 'BPI Credit Card');
//       expect(account.accountType, AccountType.creditCard.name);
//       expect(account.creditLimit, 100000);

//       final details = await database.creditCardDao.getByAccountId(accountId);

//       expect(details, isNotNull);
//       expect(details!.accountId, accountId);
//       expect(details.statementDay, 23);
//       expect(details.paymentDueDay, 24);
//       expect(details.nextStatementDate, DateTime(2026, 9, 23));
//       expect(details.nextPaymentDueDate, DateTime(2026, 9, 24));
//     });

//     test('watchCreditCards returns only credit cards', () async {
//       await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//         ),
//       );

//       await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'BPI Credit Card',
//           icon: 'credit_card',
//           accountType: AccountType.creditCard.name,
//           creditLimit: const d.Value(50000),
//         ),
//       );

//       final cards = await dao.watchCreditCards().first;

//       expect(cards.length, 1);
//       expect(cards.first.name, 'BPI Credit Card');
//       expect(cards.first.accountType, AccountType.creditCard.name);
//     });
//   });

//   // ===========================================================================
//   // BALANCE PROJECTION
//   // ===========================================================================

//   group('AccountsDao - Balance Projection', () {
//     test('updates account balance directly', () async {
//       final accountId = await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//           currentValue: const d.Value(1000),
//         ),
//       );

//       await dao.updateAccountBalance(accountId, 2500);

//       final account = await dao.getAccountById(accountId);

//       expect(account, isNotNull);
//       expect(account!.currentValue, 2500);
//     });

//     test('adjusts account balance by a delta', () async {
//       final accountId = await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//           currentValue: const d.Value(1000),
//         ),
//       );

//       await dao.adjustAccountBalance(accountId, 500);

//       var account = await dao.getAccountById(accountId);

//       expect(account!.currentValue, 1500);

//       await dao.adjustAccountBalance(accountId, -300);

//       account = await dao.getAccountById(accountId);

//       expect(account!.currentValue, 1200);
//     });
//   });

//   // ===========================================================================
//   // PORTFOLIO METRICS
//   // ===========================================================================

//   group('AccountsDao - Portfolio Metrics', () {
//     test('calculates available funds from cash and bank accounts', () async {
//       await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//           currentValue: const d.Value(1000),
//         ),
//       );

//       await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Savings',
//           icon: 'bank',
//           accountType: AccountType.savingsAccount.name,
//           currentValue: const d.Value(5000),
//         ),
//       );

//       await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Checking',
//           icon: 'chart',
//           accountType: AccountType.checkingAccount.name,
//           currentValue: const d.Value(10000),
//         ),
//       );

//       final availableFunds = await dao.watchAvailableFunds().first;

//       expect(availableFunds, 16000);
//     });
//   });

//   // ===========================================================================
//   // ACCOUNT BALANCE ENGINE
//   // ===========================================================================

//   group('AccountsDao - Balance Engine', () {
//     test('calculates account balance', () async {
//       final accountId = await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//         ),
//       );

//       // Add transactions here once the TransactionsDao transaction
//       // creation API is finalized.

//       // The expected balance should be verified against
//       // dao.calculateAccountBalance(accountId).
//     });

//     test('verifies account balance projection', () async {
//       final accountId = await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//           currentValue: const d.Value(1000),
//         ),
//       );

//       // No transactions means calculated balance = 0.
//       expect(await dao.verifyAccountBalance(accountId), isFalse);
//     });

//     test('returns balance difference', () async {
//       final accountId = await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//           currentValue: const d.Value(1000),
//         ),
//       );

//       final difference = await dao.balanceDifference(accountId);

//       expect(difference, -1000);
//     });

//     test('rebuilds account balance from transactions', () async {
//       final accountId = await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//           currentValue: const d.Value(1000),
//         ),
//       );

//       await dao.rebuildAccountBalance(accountId);

//       final account = await dao.getAccountById(accountId);

//       expect(account, isNotNull);
//       expect(account!.currentValue, 0);
//     });
//   });

//   // ===========================================================================
//   // STREAMS
//   // ===========================================================================

//   group('AccountsDao - Streams', () {
//     test('watchAccount emits the account', () async {
//       final accountId = await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//         ),
//       );

//       final account = await dao.watchAccount(accountId).first;

//       expect(account, isNotNull);
//       expect(account!.id, accountId);
//       expect(account.name, 'Cash');
//     });

//     test('watchAccounts emits all accounts', () async {
//       await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Cash',
//           icon: 'wallet',
//           accountType: AccountType.cash.name,
//         ),
//       );

//       await dao.insertAccount(
//         AccountsTableCompanion.insert(
//           name: 'Savings',
//           icon: 'bank',
//           accountType: AccountType.savingsAccount.name,
//         ),
//       );

//       final accounts = await dao.watchAccounts().first;

//       expect(accounts.length, 2);
//     });
//   });
// }
