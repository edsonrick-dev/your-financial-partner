import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_pages.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/theme/app_appearance.dart';
import 'package:getx_drift_app/core/theme/theme_data.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_preference.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isOnboardingCompleted = OnboardingPreference.isCompleted;
    return GetMaterialApp(
      title: 'Ascend YFP',
      debugShowCheckedModeBanner: false,
      initialRoute: isOnboardingCompleted ? Routes.MAINVIEW : Routes.ONBOARDING,
      getPages: AppPages.pages,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: AppAppearance.themeMode.value,
      // initialBinding: AppBinding(),
    );
  }
}
