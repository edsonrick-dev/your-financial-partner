import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OnboardingAscendIntroView extends GetView<OnboardingController> {
  const OnboardingAscendIntroView({super.key});

  static const _slides = [
    _IntroSlideData(
      title: 'See your full financial picture',
      description:
          'Your money decisions connect. Get a clearer view of where you are today.',
      artwork: _IntroArtwork.connectedPicture,
    ),
    _IntroSlideData(
      title: 'Make today’s money easier to manage',
      description:
          'Track income and spending, plan a budget, and stay ahead of bills.',
      artwork: _IntroArtwork.cashFlow,
    ),
    _IntroSlideData(
      title: 'Plan what you’re building toward',
      description:
          'See what you own and owe, and make a plan for savings and retirement.',
      artwork: _IntroArtwork.netWorth,
    ),
    _IntroSlideData(
      title: 'Protect the life you’re building',
      description:
          'Plan protection around your lifestyle and the people who depend on you.',
      artwork: _IntroArtwork.protection,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
              child: Row(
                children: [
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/ascendyfp_logo_light.png',
                        width: 28,
                        height: 28,
                      ),
                      // const SizedBox(width: 6),
                      // Text('Ascend', style: AppTextStyle.headlineL),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: controller.skipIntro,
                    child: Text(
                      'Skip',
                      style: AppTextStyle.titleM.copyWith(
                        color: colors.appTextMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.introPageController,
                onPageChanged: controller.onIntroPageChanged,
                itemCount: _slides.length,
                itemBuilder: (context, index) =>
                    _IntroSlide(data: _slides[index], index: index),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: Column(
                children: [
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_slides.length, (index) {
                        final isActive =
                            controller.introPageIndex.value == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 22 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isActive
                                ? colors.appInflow
                                : colors.appBorder,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => AppButton(
                      text:
                          controller.introPageIndex.value == _slides.length - 1
                          ? 'Get started'
                          : 'Next',
                      trailingIcon:
                          controller.introPageIndex.value == _slides.length - 1
                          ? PhosphorIconsRegular.arrowRight
                          : null,
                      onTap: controller.nextIntroPage,
                      size: ButtonSize.xLarge,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _IntroArtwork { connectedPicture, cashFlow, netWorth, protection }

class _IntroSlideData {
  const _IntroSlideData({
    required this.title,
    required this.description,
    required this.artwork,
  });

  final String title;
  final String description;
  final _IntroArtwork artwork;
}

class _IntroSlide extends StatelessWidget {
  const _IntroSlide({required this.data, required this.index});

  final _IntroSlideData data;
  final int index;

  String? get _previewImage => switch (data.artwork) {
    _IntroArtwork.cashFlow => 'assets/images/onboarding_cash_flow_preview.png',
    _IntroArtwork.netWorth => 'assets/images/onboarding_net_worth_preview.png',
    _IntroArtwork.protection =>
      'assets/images/onboarding_insurance_preview.png',
    _IntroArtwork.connectedPicture => null,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: AppTextStyle.displayM.copyWith(color: colors.appText),
          ),
          const SizedBox(height: 12),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: AppTextStyle.bodyL.copyWith(color: colors.appTextMuted),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _previewImage == null
                ? const _ConnectedPictureIllustration()
                : _PlannerPreview(image: _previewImage!, index: index),
          ),
        ],
      ),
    );
  }
}

class _PlannerPreview extends StatelessWidget {
  const _PlannerPreview({required this.image, required this.index});

  final String image;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 430),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.bgLight,
        border: Border.all(color: colors.appBorder),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colors.color900.withValues(alpha: 0.12),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            errorBuilder: (context, error, stackTrace) => Center(
              child: Icon(
                index == 1
                    ? PhosphorIconsRegular.wallet
                    : index == 2
                    ? PhosphorIconsRegular.chartLineUp
                    : PhosphorIconsRegular.shieldCheck,
                size: 72,
                color: colors.appInflow,
              ),
            ),
          ),
          if (index == 2)
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: colors.bg.withValues(alpha: 0.96),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: colors.color900.withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(PhosphorIconsRegular.target, color: colors.appInflow),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Savings goals and retirement planning',
                        style: AppTextStyle.titleM.copyWith(
                          color: colors.appText,
                        ),
                      ),
                    ),
                    Icon(
                      PhosphorIconsRegular.arrowUpRight,
                      color: colors.appTextMuted,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ConnectedPictureIllustration extends StatelessWidget {
  const _ConnectedPictureIllustration();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final items = [
      (PhosphorIconsRegular.wallet, 'Cash flow', colors.appInflow),
      (PhosphorIconsRegular.handCoins, 'Debt', colors.appInfo),
      (PhosphorIconsRegular.chartLineUp, 'Savings', colors.appAccent),
      (PhosphorIconsRegular.houseLine, 'Assets', colors.appInfo),
      (PhosphorIconsRegular.shieldCheck, 'Protection', colors.appInflow),
    ];

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 430),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.bgLight, colors.appInflow.withValues(alpha: 0.10)],
        ),
        border: Border.all(color: colors.appBorder),
      ),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final item in items)
              Container(
                width: 116,
                height: 102,
                decoration: BoxDecoration(
                  color: colors.bg,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: colors.color900.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.$1, color: item.$3, size: 30),
                    const SizedBox(height: 8),
                    Text(item.$2, style: AppTextStyle.titleS),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
