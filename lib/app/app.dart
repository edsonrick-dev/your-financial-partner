// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_pages.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/theme/theme_data.dart';
// import 'package:getx_drift_app/modules/home/screen/my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // database = AppDatabase();
  await database.seedDefaultCategories();
  await database.seedDefaultPaymentAccounts();
  await database.seedDefaultEntities();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ascend YFP',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.MAINVIEW,
      getPages: AppPages.pages,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      // initialBinding: AppBinding(),
    );
  }
}
