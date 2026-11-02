import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/domain/app_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/details_sheet/beneficiary_slide.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/details_sheet/controller/insurance_policy_detail_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/details_sheet/insurance_policy_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePolicyDetailSheet
    extends GetView<InsurancePolicyDetailController> {
  const InsurancePolicyDetailSheet({super.key, required this.policyId});

  final int policyId;

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Insurance Policy',
      child: Padding(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: Column(
          children: [
            Obx(
              () => AppSection(
                child: InsurancePolicySummarySection(
                  content: InsurancePolicySummaryContent(
                    insurerName: controller.insurerName.value,
                    productName: controller.productName.value,
                    policyNumber: controller.policyNumber.value ?? '',
                    nextDue: controller.nextDueDate.value,
                    paymentFrequency: controller.paymentFrequency.value,
                  ),
                ),
              ),
            ),
            AppDetailsPageActionSection(
              selectedIndex: controller.selectedIndex,
              actions: const ['Benefits', 'Beneficiaries', 'Payment History'],
              icon: PhosphorIconsRegular.shieldCheck,
            ),
            Expanded(
              child: Obx(
                () => IndexedStack(
                  index: controller.selectedIndex.value,
                  children: [
                    const BenefitSlide(),
                    BeneficiarySlide(faceValue: controller.faceValue.value),
                    const Center(child: Text('Payment History')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BenefitSlide extends GetView<InsurancePolicyDetailController> {
  const BenefitSlide({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (controller.errorMessage.value != null) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Text(
                controller.errorMessage.value!,
                style: AppTextStyle.bodyM.copyWith(color: colors.appTextMuted),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final benefits = controller.policyBenefits;
        if (benefits.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Text(
                'No benefits have been saved for this policy.',
                style: AppTextStyle.bodyM.copyWith(color: colors.appTextMuted),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return AppSection(
          child: Column(
            spacing: 12,
            children: benefits.map((row) {
              final policyBenefit = row.readTable(
                database.userInsuranceBenefitsTable,
              );
              final definition = row.readTable(database.insuranceBenefitsTable);
              final benefitType = BenefitType.values.firstWhere(
                (type) => type.name == definition.benefitType,
                orElse: () => BenefitType.others,
              );
              final name = definition.name?.trim();

              return UserPolicyBenefitCard(
                name: name,
                benefitType: benefitType,
                policyBenefit: policyBenefit,
                definition: definition,
                onAmountChanged: (amount) =>
                    controller.updatePolicyBenefitAmount(
                      userBenefitId: policyBenefit.id,
                      amount: amount,
                    ),
              );
            }).toList(),
          ),
        );
      }),
    );
  }
}

class UserPolicyBenefitCard extends StatelessWidget {
  const UserPolicyBenefitCard({
    super.key,
    required this.name,
    required this.benefitType,

    required this.policyBenefit,
    required this.definition,
    required this.onAmountChanged,
  });

  final String? name;
  final BenefitType benefitType;

  final UserInsuranceBenefit policyBenefit;
  final InsuranceBenefitsTableData definition;
  final Future<void> Function(double amount) onAmountChanged;

  Future<void> _openCalculator(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final calculatorController = Get.find<AppCalculatorController>();
    calculatorController.initialize(policyBenefit.amount);

    final result = await Get.bottomSheet<double>(
      AppCalculator(
        title: name?.isNotEmpty == true ? name! : benefitType.label,
      ),
      isScrollControlled: true,
    );

    if (result != null) await onAmountChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppCard(
      onTap: () => _openCalculator(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name?.isNotEmpty == true ? name! : benefitType.label,
                      style: AppTextStyle.bodyL,
                    ),
                    if (name?.isNotEmpty == true) ...[
                      const SizedBox(height: 4),
                      Text(
                        benefitType.label,
                        style: AppTextStyle.bodyS.copyWith(
                          color: colors.appTextMuted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                policyBenefit.amount.toCurrency(),
                style: AppTextStyle.amountL,
              ),
            ],
          ),
          if (definition.description?.trim().isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Text(
              definition.description!,
              style: AppTextStyle.bodyS.copyWith(color: colors.appTextMuted),
            ),
          ],
        ],
      ),
    );
  }
}

// class AdvisorOnAction extends StatelessWidget {
//   const AdvisorOnAction({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppSheet(
//       adaptiveHeight: true,
//       title: 'Contact Advisor',
//       child: SingleChildScrollView(
//         padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
//         child: AppSection(
//           child: Column(
//             spacing: 16,
//             children: [
//               AppCard(
//                 child: Row(
//                   spacing: 12,
//                   children: [
//                     Icon(PhosphorIconsRegular.phone),
//                     Text('Call phone', style: AppTextStyle.titleL),
//                   ],
//                 ),
//               ),
//               AppCard(
//                 child: Row(
//                   spacing: 12,
//                   children: [
//                     Icon(PhosphorIconsRegular.chat),
//                     Text('Send SMS', style: AppTextStyle.titleL),
//                   ],
//                 ),
//               ),
//               AppCard(
//                 child: Row(
//                   spacing: 12,
//                   children: [
//                     Icon(PhosphorIconsRegular.envelope),
//                     Text('Send email', style: AppTextStyle.titleL),
//                   ],
//                 ),
//               ),
//               AppCard(
//                 child: Row(
//                   spacing: 12,
//                   children: [
//                     Icon(PhosphorIconsRegular.calendar),
//                     Text('Add calendar meeting', style: AppTextStyle.titleL),
//                   ],
//                 ),
//               ),
//               AppCard(
//                 child: Row(
//                   spacing: 12,
//                   children: [
//                     Icon(PhosphorIconsRegular.pencil),
//                     Text('Update advisor info', style: AppTextStyle.titleL),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
