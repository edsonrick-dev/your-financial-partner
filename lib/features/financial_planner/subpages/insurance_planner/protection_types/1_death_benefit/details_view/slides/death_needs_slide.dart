import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_card_builder.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

class DeathNeedsSlide extends GetView<InsurancePlannerController> {
  const DeathNeedsSlide({super.key, required this.type});
  final ProtectionType type;
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
        children: ProtectionNeedCardBuilder.build(
          type: type,
          onTapResolver: (needType) {
            return null;
          },
        ),
      ),
    );
  }
}

      // Column(
      //   spacing: 20,
      //   children: [
      //     ProtectionNeedCard(
      //       needType: ProtectionNeedType.funeralAndFinalExpense,

      //       amount: funeralAndFinalExpense,
      //       onTap: () {},
      //     ),

      // Obx(() {
      //   final familyExpenseContinuityFund =
      //       controller.deathExpenseContinuityFund.value;
      //   return ProtectionNeedCard(
      //     needType: ProtectionNeedType.expenseContinuity,
      //     amount: familyExpenseContinuityFund,
      //     onTap: () async {
      //       final scenarios = await database.protectionDao
      //           .getProtectionScenarios();
      //       final deathScenario = scenarios.firstWhereOrNull(
      //         (scenario) =>
      //             scenario.protectionType == ProtectionType.death.name,
      //       );
      //       final result = controller.deathBenefitResult.value;
      //       Get.bottomSheet(
      //         ExpenseContinuityFundDetailsSheet(
      //           type: ProtectionType.death,
      //           data: result?.expenseContinuityDetails,
      //           savedHorizon: deathScenario?.horizon,
      //         ),
      //         isScrollControlled: true,
      //       );
      //     },
      //   );
      // }),

      //     ProtectionNeedCard(
      //       needType: ProtectionNeedType.educationFunding,

      //       amount: educationFunding,

      //       onTap: () {},
      //     ),
      //     ProtectionNeedCard(
      //       needType: ProtectionNeedType.debtsAndObligations,
      //       amount: debtsAndObligations,
      //       onTap: () {},
      //     ),
      //     ProtectionNeedCard(
      //       needType: ProtectionNeedType.estateSettlement,

      //       amount: estateSettlementFund,
      //       onTap: () {},
      //     ),
      //   ],
      // ),// const InsuranceUnderConstructionView(
    //   title: 'Needs are coming soon',
    //   description: 'We’re still building this part of your protection plan.',
    // );