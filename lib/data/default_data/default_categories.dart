import 'package:getx_drift_app/data/enums/transaction_type.dart';

class DefaultCategory {
  final String name;
  final String iconKey;
  final String type;

  const DefaultCategory({
    required this.name,
    required this.iconKey,
    required this.type,
  });
}

class DefaultCategories {
  static var income = [
    DefaultCategory(
      name: 'Salary',
      iconKey: 'suitCase',
      type: TransactionType.earn.name,
    ),
    DefaultCategory(
      name: 'Allowance',
      iconKey: 'money',
      type: TransactionType.earn.name,
    ),
    DefaultCategory(
      name: 'Business',
      iconKey: 'business',
      type: TransactionType.earn.name,
    ),
    DefaultCategory(
      name: 'Renting',
      iconKey: 'houseLine',
      type: TransactionType.earn.name,
    ),
    DefaultCategory(
      name: 'Gifts',
      iconKey: 'gift',
      type: TransactionType.earn.name,
    ),
  ];

  static var expense = [
    DefaultCategory(
      name: 'General',
      iconKey: 'default',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Groceries',
      iconKey: 'basket',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Kids Stuff',
      iconKey: 'babyCarriage',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Rent',
      iconKey: 'houseLine',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'House',
      iconKey: 'house',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Insurances',
      iconKey: 'shieldPlus',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Health',
      iconKey: 'heartbeat',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Travel',
      iconKey: 'airplaneInFlight',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Leisure',
      iconKey: 'island',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Pets',
      iconKey: 'pawPrint',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Books',
      iconKey: 'books',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Fuel',
      iconKey: 'gasPump',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Car',
      iconKey: 'car',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Education',
      iconKey: 'graduationCap',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Sports',
      iconKey: 'dribbbleLogo',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Music',
      iconKey: 'musicNotes',
      type: TransactionType.spend.name,
    ),
    DefaultCategory(
      name: 'Friends',
      iconKey: 'usersThree',
      type: TransactionType.spend.name,
    ),
  ];

  static var all = [...income, ...expense];
}
