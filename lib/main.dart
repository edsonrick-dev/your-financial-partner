import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/app/app.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'app/bootstrap/app_bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppBootstrap.initialize();
  await database.seedDefaultCategories();
  await database.seedDefaultPaymentAccounts();
  await database.seedDefaultEntities();
  runApp(const App());
}
