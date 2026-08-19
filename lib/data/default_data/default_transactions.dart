// import 'package:getx_drift_app/data/enums/transaction_type.dart';

// class DefaultTransaction {
//   final String description;
//   final TransactionType type;
//   final double amount;

//   final String accountName;
//   final String? linkedAccountName;
//   final String? categoryName;
//   final String? entityName;

//   final bool isDebt;
//   final bool isDebtRepayment;

//   final DateTime date;

//   const DefaultTransaction({
//     required this.description,
//     required this.type,
//     required this.amount,
//     required this.accountName,
//     this.linkedAccountName,
//     this.categoryName,
//     this.entityName,
//     this.isDebt = false,
//     this.isDebtRepayment = false,
//     required this.date,
//   });
// }

// class DefaultTransactions {
//   static final earnings = [
//     DefaultTransaction(
//       description: 'Salary',
//       type: TransactionType.earn,
//       amount: 50000.00,
//       accountName: 'BPI Savings Account',
//       categoryName: 'Salary',
//       date: DateTime(2026, 8, 1),
//     ),
//   ];

//   static final spend = [
//     DefaultTransaction(
//       description: 'Grocery shopping',
//       type: TransactionType.spend,
//       amount: 1500.00,
//       accountName: 'BPI Savings Account',
//       categoryName: 'Groceries',
//       date: DateTime(2026, 8, 3),
//     ),
//   ];

//   static final transfer = [
//     DefaultTransaction(
//       description: 'Transfer to GCash',
//       type: TransactionType.transfer,
//       amount: 5000.00,
//       accountName: 'BPI Savings Account',
//       linkedAccountName: 'GCash',
//       date: DateTime(2026, 8, 5),
//     ),
//   ];

//   static final give = [
//     // Normal give
//     DefaultTransaction(
//       description: 'Gave money to Juan',
//       type: TransactionType.give,
//       amount: 500.00,
//       accountName: 'Cash Wallet',
//       entityName: 'Juan',
//       date: DateTime(2026, 8, 11),
//     ),

//     // Give as debt
//     DefaultTransaction(
//       description: 'Lent money to Juan',
//       type: TransactionType.give,
//       amount: 2000.00,
//       accountName: 'Cash Wallet',
//       entityName: 'Juan',
//       isDebt: true,
//       date: DateTime(2026, 8, 12),
//     ),

//     // Give as debt repayment
//     DefaultTransaction(
//       description: 'Juan repaid part of his debt',
//       type: TransactionType.give,
//       amount: 1000.00,
//       accountName: 'Cash Wallet',
//       entityName: 'Juan',
//       isDebt: true,
//       isDebtRepayment: true,
//       date: DateTime(2026, 8, 16),
//     ),
//   ];

//   static final receive = [
//     // Normal receive
//     DefaultTransaction(
//       description: 'Received money from Maria',
//       type: TransactionType.receive,
//       amount: 1000.00,
//       accountName: 'BPI Savings Account',
//       entityName: 'Maria',
//       date: DateTime(2026, 8, 13),
//     ),

//     // Receive as debt
//     DefaultTransaction(
//       description: 'Borrowed money from Maria',
//       type: TransactionType.receive,
//       amount: 5000.00,
//       accountName: 'BPI Savings Account',
//       entityName: 'Maria',
//       isDebt: true,
//       date: DateTime(2026, 8, 14),
//     ),

//     // Receive as debt repayment
//     DefaultTransaction(
//       description: 'Repaid part of debt to Maria',
//       type: TransactionType.receive,
//       amount: 1000.00,
//       accountName: 'BPI Savings Account',
//       entityName: 'Maria',
//       isDebt: true,
//       isDebtRepayment: true,
//       date: DateTime(2026, 8, 17),
//     ),
//   ];

//   static final all = [...earnings, ...spend, ...transfer, ...give, ...receive];
// }
