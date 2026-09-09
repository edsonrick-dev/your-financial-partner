import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: const Color(0xFF141C29)),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Growth pattern
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Image.asset(
                  'assets/icons/ascendyfp_growth_pattern_white.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  children: [
                    const Spacer(),

                    // Brand
                    Image.asset(
                      'assets/icons/ascendyfp_brand_lockup.png',
                      width: 270,
                      fit: BoxFit.contain,
                    ),

                    const Spacer(flex: 2),

                    // CTA
                    AppButton(
                      isInversed: true,
                      text: 'Get started',
                      onTap: () {
                        Get.toNamed(Routes.ONBOARDING_FIRST_QUESTION);
                      },
                    ),

                    SizedBox(height: bottomPadding),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
