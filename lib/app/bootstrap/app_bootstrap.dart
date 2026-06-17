import 'package:getx_drift_app/app/bootstrap/database_initializer.dart';
import 'package:getx_drift_app/app/bootstrap/seed_initializer.dart';

abstract final class AppBootstrap {
  static Future<void> initialize() async {
    await DatabaseInitializer.initialize();

    await SeedInitializer.initialize();
  }
}
