import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_setup/financial_setup_criterion.dart';
import 'package:getx_drift_app/features/financial_setup/financial_setup_guide.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FinancialSetupController extends GetxController {
  final financialSetupGuides = [
    FinancialSetupGuide(
      criterion: FinancialSetupCriterion.accounts,
      title: 'Add your first account',
      description:
          'Add your cash, bank, e-wallet, or other accounts to track what you own.',
      icon: PhosphorIconsRegular.creditCard,
      actionLabel: 'Add an account',
      onAction: () {
        Get.toNamed(Routes.NETWORTHDETAILS);
      },
    ),

    FinancialSetupGuide(
      criterion: FinancialSetupCriterion.cashflow,
      title: 'Set up your monthly cashflow',
      description:
          'Plan your income and where your money needs to go each month.',
      icon: PhosphorIconsRegular.calendarDots,
      actionLabel: 'Set up cashflow',
      onAction: () {
        Get.find<CashflowController>().seletectedDetailsTabIndex(1);
        Get.toNamed(Routes.CASHFLOWDETAILS);
      },
    ),
  ];

  final completedCriteria = <FinancialSetupCriterion>{}.obs;

  final incompleteGuides = <FinancialSetupGuide>[].obs;

  final PageController guidePageController = PageController();

  final currentGuideIndex = 0.obs;

  StreamSubscription? _accountsSubscription;
  StreamSubscription? _cashflowSubscription;

  @override
  void onInit() {
    super.onInit();

    _watchAccounts();
    _watchCashflow();

    _updateIncompleteGuides();
  }

  void _watchAccounts() {
    _accountsSubscription = database.accountsDao.watchAccounts().listen((
      accounts,
    ) {
      _setCriterion(FinancialSetupCriterion.accounts, accounts.isNotEmpty);
    });
  }

  void _watchCashflow() {
    _cashflowSubscription = database.cashflowPlanDao
        .watchAllPlansWithDetails()
        .listen((plans) {
          _setCriterion(FinancialSetupCriterion.cashflow, plans.isNotEmpty);
        });
  }

  void _setCriterion(FinancialSetupCriterion criterion, bool isComplete) {
    if (isComplete) {
      completedCriteria.add(criterion);
    } else {
      completedCriteria.remove(criterion);
    }

    _updateIncompleteGuides();
  }

  void _updateIncompleteGuides() {
    final guides = financialSetupGuides
        .where((guide) => !completedCriteria.contains(guide.criterion))
        .toList();

    incompleteGuides.assignAll(guides);

    _validateGuidePage();
  }

  void _validateGuidePage() {
    if (incompleteGuides.isEmpty) {
      currentGuideIndex.value = 0;
      return;
    }

    if (currentGuideIndex.value >= incompleteGuides.length) {
      currentGuideIndex.value = incompleteGuides.length - 1;
    }
  }

  void onGuidePageChanged(int index) {
    currentGuideIndex.value = index;
  }

  bool isComplete(FinancialSetupCriterion criterion) {
    return completedCriteria.contains(criterion);
  }

  FinancialSetupGuide? get recommendedGuide {
    if (incompleteGuides.isEmpty) {
      return null;
    }

    return incompleteGuides.first;
  }

  bool get hasAccounts => isComplete(FinancialSetupCriterion.accounts);

  bool get hasCashflow => isComplete(FinancialSetupCriterion.cashflow);

  bool get hasBills => isComplete(FinancialSetupCriterion.bills);

  @override
  void onClose() {
    _accountsSubscription?.cancel();
    _cashflowSubscription?.cancel();
    guidePageController.dispose();

    super.onClose();
  }
}

class FinancialSetupGuideCarousel extends GetView<FinancialSetupController> {
  const FinancialSetupGuideCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final guides = controller.incompleteGuides;

      if (guides.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        children: [
          SizedBox(
            height: 244,
            child: PageView.builder(
              controller: controller.guidePageController,
              itemCount: guides.length,
              onPageChanged: controller.onGuidePageChanged,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GuideCard(guide: guides[index]),
                );
              },
            ),
          ),

          const SizedBox(height: 12),
          if (guides.length > 1) _GuidePageIndicator(),
        ],
      );
    });
  }
}

class _GuidePageIndicator extends GetView<FinancialSetupController> {
  const _GuidePageIndicator();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Obx(() {
      final count = controller.incompleteGuides.length;
      final current = controller.currentGuideIndex.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (index) {
          final isActive = index == current;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 12 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive ? colorScheme.appText : colorScheme.appTextMuted,
              borderRadius: BorderRadius.circular(999),
            ),
          );
        }),
      );
    });
  }
}
