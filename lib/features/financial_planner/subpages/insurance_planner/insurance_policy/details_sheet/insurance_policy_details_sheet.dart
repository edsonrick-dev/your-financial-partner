import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/details_sheet/beneficiary_slide.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/details_sheet/controller/insurance_policy_detail_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/details_sheet/insurance_policy_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/policy_benefit_card.dart';
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
                  issuer: controller.insurerName.value,
                  name: controller.productName.value,
                  faceValue: controller.faceValue.value,
                  paymentTerm: controller.paymentTerm.value,
                  nextDueDate: controller.nextDueDate.value,
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

class BenefitSlide extends StatelessWidget {
  const BenefitSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
      child: Column(
        spacing: 20,
        children: [
          AppSection(
            sectionTitle: 'Principal Benefit',
            child: Column(
              spacing: 20,
              children: [
                PolicyBenefitCard(type: BenefitType.majorCI, amount: 1000000),
              ],
            ),
          ),
          AppSection(
            sectionTitle: 'Rider Benefits',
            child: Column(
              spacing: 20,
              children: [
                PolicyBenefitCard(type: BenefitType.minorCI, amount: 250000),
                PolicyBenefitCard(
                  type: BenefitType.genderSpecific,
                  amount: 50000,
                ),
              ],
            ),
          ),
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
