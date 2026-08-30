import 'package:getx_drift_app/app/globals/app_globals.dart';

abstract final class SeedInitializer {
  static Future<void> initialize() async {
    await database.seedDefaultCategories();
    // await database.seedDefaultPaymentAccounts();
    await database.seedDefaultEntities();
    // await database.seedDefaultTransactions();
  }
}
