import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/app/app.dart';
import 'app/bootstrap/app_bootstrap.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await AppBootstrap.initialize();

//   runApp(const App());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppBootstrap.initialize();

  runApp(const App());
}
