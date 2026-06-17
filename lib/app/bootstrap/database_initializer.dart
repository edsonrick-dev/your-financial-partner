import 'package:getx_drift_app/app/globals/app_globals.dart';

import '../../data/app_database.dart';

abstract final class DatabaseInitializer {
  static Future<void> initialize() async {
    database = AppDatabase();
  }
}
