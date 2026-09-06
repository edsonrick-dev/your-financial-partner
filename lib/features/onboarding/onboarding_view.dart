import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final colorScheme = context.colors;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF141C29),
            borderRadius: BorderRadius.circular(48),
          ),
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

                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () {
                        // Sign in will go here later.
                      },
                      child: Text(
                        'Already have an account? Sign In',
                        style: TextStyle(
                          color: colorScheme.appAccent,
                          fontSize: 16,
                        ),
                      ),
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

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  static const backgroundColor = Color(0xFF141C29);
  static const accentColor = Color(0xFFF2A936);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: Stack(
        children: [
          // Decorative graphic
          Positioned(
            left: -40,
            right: -40,
            bottom: -20,
            height: 330,
            child: CustomPaint(
              painter: WelcomeGraphicPainter(color: accentColor),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Logo
                Image.asset(
                  'assets/icons/ascendYFP_icon_foreground.png',
                  width: 250,
                  fit: BoxFit.contain,
                ),

                const Spacer(flex: 5),

                // CTA
                AppButton(
                  text: 'Get started',
                  onTap: () {
                    // We'll implement this later.
                  },
                ),

                const SizedBox(height: 18),

                Text(
                  'Already have an account? Sign In',
                  style: AppTextStyle.bodyL.copyWith(color: Colors.white),
                ),

                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeGraphicPainter extends CustomPainter {
  const WelcomeGraphicPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Large upward arrow / mountain shape
    path.moveTo(size.width * 0.08, size.height);
    path.lineTo(size.width * 0.35, size.height * 0.28);
    path.lineTo(size.width * 0.50, size.height * 0.58);
    path.lineTo(size.width * 0.65, size.height * 0.25);
    path.lineTo(size.width * 0.76, size.height * 0.45);
    path.lineTo(size.width * 0.98, size.height * 0.05);
    path.lineTo(size.width * 0.90, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Small center peak
    final secondPath = Path();

    secondPath.moveTo(size.width * 0.35, size.height);
    secondPath.lineTo(size.width * 0.51, size.height * 0.62);
    secondPath.lineTo(size.width * 0.64, size.height);
    secondPath.close();

    canvas.drawPath(secondPath, paint);
  }

  @override
  bool shouldRepaint(covariant WelcomeGraphicPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
