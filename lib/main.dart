import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/app/app.dart';
import 'app/bootstrap/app_bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppBootstrap.initialize();

  runApp(const App());
}
