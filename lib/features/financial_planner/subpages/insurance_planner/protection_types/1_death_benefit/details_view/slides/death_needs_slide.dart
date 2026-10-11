import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_fund_details_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/benefits/expense_continuity/expense_continuity_fund_details.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/shared_widgets/protection_need_card.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class DeathNeedsSlide extends GetView<InsurancePlannerController> {
  const DeathNeedsSlide({super.key});
  static const familyExpenseContinuityFund = 4726072.34;
  static const funeralAndFinalExpense = 150000.34;
  static const debtsAndObligations = 150000.34;
  static const estateSettlementFund = 0.0;
  static const educationFunding = 150000.0;

  static const double totalDeathBenefitNeed =
      familyExpenseContinuityFund +
      funeralAndFinalExpense +
      debtsAndObligations +
      estateSettlementFund +
      educationFunding;

  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.colors;
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: context.bottomPaddingSub,
        right: 16,
        left: 16,
      ),
      child: Column(
        spacing: 20,
        children: [
          ProtectionNeedCard(
            icon: PhosphorIconsRegular.heartBreak,
            title: 'Funeral & Final Expense',
            description:
                'Covers estimated funeral costs and other end-of-life expenses',
            amount: funeralAndFinalExpense,
            onTap: () {},
          ),
          Obx(() {
            final familyExpenseContinuityFund =
                controller.familyExpenseContinuityFund.value;

            return ProtectionNeedCard(
              icon: PhosphorIconsRegular.users,
              title: 'Expense Continuity Fund',
              description:
                  "Supports your family's living expenses throughout the selected protection horizon",
              amount: familyExpenseContinuityFund,
              onTap: () {
                final result = controller.deathBenefitResult.value;

                if (result == null) {
                  return;
                }

                Get.bottomSheet(
                  ExpenseContinuityFundDetailsSheet(
                    data: result.expenseContinuityDetails,
                  ),
                  isScrollControlled: true,
                );
              },
            );
          }),

          ProtectionNeedCard(
            icon: PhosphorIconsRegular.graduationCap,
            title: 'Education Funding',
            description:
                'Provides for the future education expenses included in your plans',
            amount: educationFunding,
            count: 3,
            countLabel: 'Plans',
            onTap: () {},
          ),
          ProtectionNeedCard(
            icon: PhosphorIconsRegular.bank,
            title: 'Debts & Obligations',
            description:
                'Accounts for outstanding liabilities your family may need to settle',
            amount: debtsAndObligations,
            onTap: () {},
          ),
          ProtectionNeedCard(
            icon: PhosphorIconsRegular.houseLine,
            title: 'Estate Settlement Fund',
            description:
                'Provides for estimated costs associated with settling your estate',
            amount: estateSettlementFund,
            onTap: () {},
          ),
        ],
      ),
    );
    // const InsuranceUnderConstructionView(
    //   title: 'Needs are coming soon',
    //   description: 'We’re still building this part of your protection plan.',
    // );
  }
}
