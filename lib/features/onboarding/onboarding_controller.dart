import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

class OnboardingController extends GetxController {
  static const _userNameKey = 'user_name';
  final FinancialProfileController financialProfileController =
      Get.find<FinancialProfileController>();
  @override
  void onClose() {
    plannerScrollController.dispose();
    introPageController.dispose();
    pageController.dispose();
    nameController.dispose();
    nameFocusNode.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();

    nameController.addListener(() {
      name.value = nameController.text.trim();
    });
  }

  Future<void> completeAssessment() async {
    await financialProfileController.markAssessmentCompleted();
    final storage = GetStorage();

    await storage.write(_userNameKey, name.value);
    Get.offAllNamed(Routes.MAINVIEW, arguments: {'initialTab': 3});
  }

  bool get canContinue {
    switch (currentPage.value) {
      case 0:
        return name.value.isNotEmpty;

      case 1:
        return selectedImprovementAreas.isNotEmpty;

      case 2:
        return selectedConfidence.value != null;

      case 3:
        return currentManagement.value != null;

      default:
        return false;
    }
  }

  final PageController pageController = PageController();

  final currentPage = 0.obs;

  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();
  final name = ''.obs;
  final selectedGoals = <String>{}.obs;
  final selectedConfidence = Rxn<String>();
  final selectedManagementStyle = Rxn<String>();

  final totalPages = 4;

  bool get isFirstPage => currentPage.value == 0;
  bool get isLastPage => currentPage.value == totalPages - 1;

  void nextPage() {
    if (isLastPage) {
      submitAssessment();
      return;
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void previousPage() {
    if (isFirstPage) {
      Get.back();
      return;
    }

    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void submitAssessment() {
    Get.toNamed(Routes.ASSESSMENT_SUMMARY);
  }

  // final currentPage = 0.obs;
  final financialFocus = <String>[].obs;
  final learningSource = <String>[].obs;
  static const noLearningSource = "I don't really learn about it";
  void selectHeardUs(String source) {
    selectedHeardSource.value = source;
  }

  final selectedHeardSource = RxnString();
  final heardUs = [
    'YouTube',
    'Reddit',
    'Facebook',
    'Books',
    'Formal Education',
    'Friends or Family',
    'Financial Professionals',
  ];
  final contentSource = [
    'YouTube',
    'Reddit',
    'Facebook',
    'Books',
    'Formal Education',
    'Friends or Family',
    'Financial Professionals',
    noLearningSource,
  ];

  void toggleLearningSource(String value) {
    const noLearning = noLearningSource;

    if (value == noLearning) {
      // If tapping it again, deselect it.
      if (learningSource.contains(value)) {
        learningSource.remove(value);
      } else {
        // Select only this option.
        learningSource
          ..clear()
          ..add(value);
      }

      return;
    }

    // If selecting any normal option,
    // remove "I don't really learn about it".
    learningSource.remove(noLearning);

    if (learningSource.contains(value)) {
      learningSource.remove(value);
    } else {
      learningSource.add(value);
    }
  }

  void toggleFinancialFocus(String value) {
    if (financialFocus.contains(value)) {
      financialFocus.remove(value);
    } else {
      financialFocus.add(value);
    }
  }

  bool isFocusSelected(String value) {
    return financialFocus.contains(value);
  }

  bool isLearningSourceSelected(String value) {
    return learningSource.contains(value);
  }

  final ScrollController plannerScrollController = ScrollController();
  final cashFlowKey = GlobalKey();
  final netWorthKey = GlobalKey();
  final insuranceKey = GlobalKey();
  final savingsInvestmentKey = GlobalKey();
  void scrollToPlanner(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final targetContext = key.currentContext;

      if (targetContext == null) return;

      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        alignment: 0.05,
      );
    });
  }

  final RxnString expandedPlanner = RxnString();

  void togglePlanner(String planner) {
    if (expandedPlanner.value == planner) {
      expandedPlanner.value = null;
    } else {
      expandedPlanner.value = planner;
    }
  }

  final PageController introPageController = PageController();
  final PageController learnIntroPageController = PageController();
  final introPageIndex = 0.obs;
  final learnIntroPageIndex = 0.obs;

  void onLearnIntroPageChanged(int index) {
    learnIntroPageIndex.value = index;
  }

  void onIntroPageChanged(int index) {
    introPageIndex.value = index;
  }

  void nextLearnIntroPage() {
    if (learnIntroPageIndex.value < 1) {
      learnIntroPageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      Get.toNamed(Routes.PAYWALL);
      // Go to Q5
      // Get.toNamed('/onboarding-question-5');
    }
  }

  void nextIntroPage() {
    if (introPageIndex.value < 2) {
      introPageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      Get.toNamed(Routes.ONBOARDING_BUILD_FINANCIAL_FOUNDATION);
      // Go to Q5
      // Get.toNamed('/onboarding-question-5');
    }
  }

  final RxnString currentManagement = RxnString();

  void selectCurrentManagement(String value) {
    currentManagement.value = value;
  }

  final selectedImprovementAreas = <String>{}.obs;

  final selectedFinancialGoals = <String>{}.obs;

  void toggleImprovementArea(String value) {
    if (selectedImprovementAreas.contains(value)) {
      selectedImprovementAreas.remove(value);
    } else {
      selectedImprovementAreas.add(value);
    }
  }

  bool isImprovementAreaSelected(String value) {
    return selectedImprovementAreas.contains(value);
  }

  void toggleFinancialGoal(String value) {
    if (selectedFinancialGoals.contains(value)) {
      selectedFinancialGoals.remove(value);
    } else {
      selectedFinancialGoals.add(value);
    }
  }

  bool isSelectedGoal(String value) {
    return selectedFinancialGoals.contains(value);
  }

  // final selectedGoals = <String>{}.obs;
  // final selectedConfidence = RxnString();
  void toggleGoal(String goal) {
    if (selectedGoals.contains(goal)) {
      selectedGoals.remove(goal);
    } else {
      selectedGoals.add(goal);
    }
  }

  void selectConfidence(String confidence) {
    selectedConfidence.value = confidence;
  }

  bool isSelected(String goal) {
    return selectedGoals.contains(goal);
  }
}
