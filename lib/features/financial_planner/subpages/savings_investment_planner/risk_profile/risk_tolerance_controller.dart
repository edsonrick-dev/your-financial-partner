import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/controller/savings_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/investor_profile/investor_profile_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/investor_profile/investory_profile_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/risk_tolerance_pages.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/investment_experience/investment_experience_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/investment_horizon/investment_horizon_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/investment_knowledge/investment_knowledge_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/market_loss_reaction/market_loss_reaction_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/risk_return_preference/risk_return_preference_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/risk_willingness/risk_willingness_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/withdrawal_horizon/withdrawal_horizon_model.dart';
import 'dart:convert';

class RiskToleranceController extends GetxController {
  late final Future<void> initialization;
  final savingsPlannerController = Get.find<SavingsPlannerController>();

  Future<void> saveAssessment() async {
    await database.investorProfileDao.saveProfile(
      investmentHorizon: investmentHorizon.value?.name,
      withdrawalHorizon: withdrawalHorizon.value?.name,
      investmentKnowledge: investmentKnowledge.value?.name,
      riskWillingness: riskWillingness.value?.name,
      investmentExperience: investmentExperienceJson,
      marketLossReaction: marketLossReaction.value?.name,
      riskReturnPreference: riskReturnPreference.value?.name,
      totalScore: totalScore,
      investorProfile: investorProfile.value?.name,
      assessedAt: DateTime.now(),
    );
  }

  @override
  void onInit() {
    super.onInit();
    initialization = _loadAssessment();
  }

  T? _enumFromName<T extends Enum>(Iterable<T> values, String? name) {
    if (name == null) {
      return null;
    }

    for (final value in values) {
      if (value.name == name) {
        return value;
      }
    }

    return null;
  }

  Future<void> _loadAssessment() async {
    final data = await database.investorProfileDao.getProfile();

    if (data == null) {
      return;
    }

    investmentHorizon.value = _enumFromName(
      InvestmentHorizon.values,
      data.investmentHorizon,
    );

    withdrawalHorizon.value = _enumFromName(
      WithdrawalHorizon.values,
      data.withdrawalHorizon,
    );

    investmentKnowledge.value = _enumFromName(
      InvestmentKnowledge.values,
      data.investmentKnowledge,
    );

    riskWillingness.value = _enumFromName(
      RiskWillingness.values,
      data.riskWillingness,
    );

    investmentExperience.assignAll(
      _investmentExperienceFromJson(data.investmentExperience),
    );

    marketLossReaction.value = _enumFromName(
      MarketLossReaction.values,
      data.marketLossReaction,
    );

    riskReturnPreference.value = _enumFromName(
      RiskReturnPreference.values,
      data.riskReturnPreference,
    );

    investorProfile.value = _enumFromName(
      InvestorProfile.values,
      data.investorProfile,
    );
  }

  Set<InvestmentExperience> _investmentExperienceFromJson(String? value) {
    if (value == null || value.isEmpty) {
      return {};
    }

    final decoded = jsonDecode(value);

    if (decoded is! List) {
      return {};
    }

    return decoded
        .whereType<String>()
        .map((name) => _enumFromName(InvestmentExperience.values, name))
        .whereType<InvestmentExperience>()
        .toSet();
  }

  String get investmentExperienceJson {
    return jsonEncode(
      investmentExperience.map((experience) => experience.name).toList(),
    );
  }
  // ----------------------------------------------------------
  // NAVIGATION
  // ----------------------------------------------------------

  final riskTolerancePage = RiskTolerancePage.investmentHorizon.obs;

  final pageHistory = <RiskTolerancePage>[].obs;

  bool get canGoBack => pageHistory.isNotEmpty;

  void previousPage() {
    if (pageHistory.isEmpty) {
      Get.back();
      return;
    }

    riskTolerancePage.value = pageHistory.removeLast();
  }

  Future<void> nextPage() async {
    if (!canContinue) {
      return;
    }

    final currentPage = riskTolerancePage.value;

    late RiskTolerancePage nextPage;

    switch (currentPage) {
      case RiskTolerancePage.investmentHorizon:
        nextPage = RiskTolerancePage.withdrawalHorizon;
        break;

      case RiskTolerancePage.withdrawalHorizon:
        nextPage = RiskTolerancePage.investmentKnowledge;
        break;

      case RiskTolerancePage.investmentKnowledge:
        nextPage = RiskTolerancePage.riskWillingness;
        break;

      case RiskTolerancePage.riskWillingness:
        nextPage = RiskTolerancePage.investmentExperience;
        break;

      case RiskTolerancePage.investmentExperience:
        nextPage = RiskTolerancePage.marketLossReaction;
        break;

      case RiskTolerancePage.marketLossReaction:
        nextPage = RiskTolerancePage.riskReturnPreference;
        break;

      case RiskTolerancePage.riskReturnPreference:
        calculateInvestorProfile();

        final profile = investorProfile.value;

        if (profile == null) {
          return;
        }

        await saveAssessment();

        savingsPlannerController.completeRiskToleranceAssessment(profile);

        Get.back();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.bottomSheet(
            InvestorProfileSheet(profile: profile),
            isScrollControlled: true,
          );
        });

        return;
    }

    pageHistory.add(currentPage);
    riskTolerancePage.value = nextPage;
  }

  bool get canContinue {
    return switch (riskTolerancePage.value) {
      RiskTolerancePage.investmentHorizon => isInvestmentHorizonAnswered,

      RiskTolerancePage.withdrawalHorizon => isWithdrawalHorizonAnswered,

      RiskTolerancePage.investmentKnowledge => isInvestmentKnowledgeAnswered,

      RiskTolerancePage.riskWillingness => isRiskWillingnessAnswered,

      RiskTolerancePage.investmentExperience => isInvestmentExperienceAnswered,

      RiskTolerancePage.marketLossReaction => isMarketLossReactionAnswered,

      RiskTolerancePage.riskReturnPreference => isRiskReturnPreferenceAnswered,
    };
  }

  // ----------------------------------------------------------
  // ANSWERS
  // ----------------------------------------------------------

  final investmentHorizon = Rxn<InvestmentHorizon>();

  final withdrawalHorizon = Rxn<WithdrawalHorizon>();

  final investmentKnowledge = Rxn<InvestmentKnowledge>();

  final riskWillingness = Rxn<RiskWillingness>();

  final investmentExperience = <InvestmentExperience>{}.obs;

  final marketLossReaction = Rxn<MarketLossReaction>();

  final riskReturnPreference = Rxn<RiskReturnPreference>();

  // ----------------------------------------------------------
  // SETTERS
  // ----------------------------------------------------------

  void setInvestmentHorizon(InvestmentHorizon value) {
    investmentHorizon.value = value;
  }

  void setWithdrawalHorizon(WithdrawalHorizon value) {
    withdrawalHorizon.value = value;
  }

  void setInvestmentKnowledge(InvestmentKnowledge value) {
    investmentKnowledge.value = value;
  }

  void setRiskWillingness(RiskWillingness value) {
    riskWillingness.value = value;
  }

  void toggleInvestmentExperience(InvestmentExperience value) {
    if (investmentExperience.contains(value)) {
      investmentExperience.remove(value);
    } else {
      investmentExperience.add(value);
    }
  }

  void setMarketLossReaction(MarketLossReaction value) {
    marketLossReaction.value = value;
  }

  void setRiskReturnPreference(RiskReturnPreference value) {
    riskReturnPreference.value = value;
  }

  // ----------------------------------------------------------
  // VALIDATION
  // ----------------------------------------------------------

  bool get isInvestmentHorizonAnswered => investmentHorizon.value != null;

  bool get isWithdrawalHorizonAnswered => withdrawalHorizon.value != null;

  bool get isInvestmentKnowledgeAnswered => investmentKnowledge.value != null;

  bool get isRiskWillingnessAnswered => riskWillingness.value != null;

  bool get isInvestmentExperienceAnswered => investmentExperience.isNotEmpty;

  bool get isMarketLossReactionAnswered => marketLossReaction.value != null;

  bool get isRiskReturnPreferenceAnswered => riskReturnPreference.value != null;

  bool get isComplete =>
      isInvestmentHorizonAnswered &&
      isWithdrawalHorizonAnswered &&
      isInvestmentKnowledgeAnswered &&
      isRiskWillingnessAnswered &&
      isInvestmentExperienceAnswered &&
      isMarketLossReactionAnswered &&
      isRiskReturnPreferenceAnswered;

  // ----------------------------------------------------------
  // SCORES
  // ----------------------------------------------------------

  int get investmentHorizonScore => investmentHorizon.value?.score ?? 0;

  int get withdrawalHorizonScore => withdrawalHorizon.value?.score ?? 0;

  int get investmentKnowledgeScore => investmentKnowledge.value?.score ?? 0;

  int get riskWillingnessScore => riskWillingness.value?.score ?? 0;

  int get investmentExperienceScore {
    if (investmentExperience.isEmpty) {
      return 0;
    }

    return investmentExperience
        .map((experience) => experience.score)
        .reduce((a, b) => a > b ? a : b);
  }

  int get marketLossReactionScore => marketLossReaction.value?.score ?? 0;

  int get riskReturnPreferenceScore => riskReturnPreference.value?.score ?? 0;

  int get totalScore {
    return investmentHorizonScore +
        withdrawalHorizonScore +
        investmentKnowledgeScore +
        riskWillingnessScore +
        investmentExperienceScore +
        marketLossReactionScore +
        riskReturnPreferenceScore;
  }

  // ----------------------------------------------------------
  // CALCULATE PROFILE
  // ----------------------------------------------------------
  final investorProfile = Rxn<InvestorProfile>();
  void calculateInvestorProfile() {
    if (!isComplete) {
      return;
    }

    final score = totalScore;

    investorProfile.value = switch (score) {
      <= 10 => InvestorProfile.capitalPreserver,
      <= 17 => InvestorProfile.cautiousBuilder,
      <= 25 => InvestorProfile.balancedInvestor,
      <= 32 => InvestorProfile.growthSeeker,
      _ => InvestorProfile.aggressiveVisionary,
    };

    debugPrint('Total score: $score');
    debugPrint('Investor profile: ${investorProfile.value}');
  }
}
