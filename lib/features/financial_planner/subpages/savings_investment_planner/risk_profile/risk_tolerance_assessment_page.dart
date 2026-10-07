import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/risk_tolerance_pages.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/risk_tolerance_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/investment_experience/investment_experience_questionnaire_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/investment_horizon/investment_horizon_questionnaire_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/investment_knowledge/investment_knowledge_questionnaire_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/market_loss_reaction/market_loss_reaction_questionnaire_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/risk_return_preference/risk_return_preference_questionnaire_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/risk_willingness/risk_willingness_questionnaire_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/withdrawal_horizon/withdrawal_horizon_questionnaire_page.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class RiskToleranceAssessmentPage extends GetView<RiskToleranceController> {
  const RiskToleranceAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Risk Tolerance Assessment', style: AppTextStyle.headlineL),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: controller.previousPage,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(child: const _CurrentQuestionPage()),
          ),

          const SizedBox(height: 8),

          AppSection(
            child: AppButton(text: 'Continue', onTap: controller.nextPage),
          ),

          SizedBox(height: context.bottomPaddingSub),
        ],
      ),
    );
  }
}

class _CurrentQuestionPage extends GetView<RiskToleranceController> {
  const _CurrentQuestionPage();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.riskTolerancePage.value) {
        case RiskTolerancePage.investmentHorizon:
          return const InvestmentHorizonQuestionnairePage();

        case RiskTolerancePage.withdrawalHorizon:
          return const WithdrawalHorizonQuestionnairePage();

        case RiskTolerancePage.investmentKnowledge:
          return const InvestmentKnowledgeQuestionnairePage();

        case RiskTolerancePage.riskWillingness:
          return const RiskWillingnessQuestionnairePage();

        case RiskTolerancePage.investmentExperience:
          return const InvestmentExperienceQuestionnairePage();

        case RiskTolerancePage.marketLossReaction:
          return const MarketLossReactionQuestionnairePage();

        case RiskTolerancePage.riskReturnPreference:
          return const RiskReturnPreferenceQuestionnairePage();
      }
    });
  }
}
