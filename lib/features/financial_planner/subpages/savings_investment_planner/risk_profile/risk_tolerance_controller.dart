import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/views/savings_planner_screen.dart';

class RiskToleranceController extends GetxController {
  final savingsPlannerController = Get.find<SavingsPlannerController>();

  // ----------------------------------------------------------
  // NAVIGATION
  // ----------------------------------------------------------

  final riskTolerancePage = RiskTolerancePage.investmentHorizon.obs;

  final pageHistory = <RiskTolerancePage>[].obs;

  bool get canGoBack => pageHistory.isNotEmpty;

  void previousPage() {
    if (pageHistory.isEmpty) {
      return;
    }

    riskTolerancePage.value = pageHistory.removeLast();
  }

  void nextPage() {
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
