import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/emergency_fund/empty_emergency_fund_view.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/emergency_fund/filled_emergency_fund_view.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/financial_score_disclaimer_section.dart';

class EmergencyFundDetails extends GetView<FinancialProfileController> {
  final FinancialRatio ratio;
  const EmergencyFundDetails({super.key, required this.ratio});
  @override
  Widget build(BuildContext context) {
    final isAssessed = controller.canAssessEmergencyFund;
    const spacing = 20.0;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),

          if (isAssessed)
            FilledEmergencyFundView(controller: controller)
          else
            EmptyEmergencyFundView(controller: controller),

          SizedBox(height: spacing),

          LearningSection(
            state: LearningSectionState.available,
            subtitle: 'Build a better understanding of lifestyle coverage.',
            contents: [
              LearnThumbnail(
                title: 'What is lifestyle coverage and why does it matter?',
              ),
              LearnThumbnail(
                title: 'How long could your net worth support your lifestyle?',
              ),
              LearnThumbnail(title: 'How to improve your lifestyle coverage'),
            ],
          ),
          SizedBox(height: spacing),

          FinancialScoreDisclaimerSection(),

          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final score = controller.emergencyFund.scoreBand;
  //   final ratio = controller.emergencyFundRatio;
  //   final available = controller.emergencyFundAvailable;
  //   final colorScheme = context.colors;
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         SizedBox(height: 12),
  //         //Score Summary
  //         AppSection(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('${score.category} ', style: AppTextStyle.headlineL),
  //               SizedBox(height: 12),

  //               Text(score.interpretation, style: AppTextStyle.bodyM),
  //             ],
  //           ),
  //         ),

  //         SizedBox(height: 20),
  //         AppSection(
  //           // sectionTitle: 'Debt Load Scale',
  //           child: AppSectionBody(
  //             child: Column(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(8),
  //                   child: Column(
  //                     children: [
  //                       Row(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Expanded(
  //                             child: Text(
  //                               'Ideal Emergency Fund',
  //                               style: AppTextStyle.titleM,
  //                             ),
  //                           ),
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.end,
  //                             children: [
  //                               Text(
  //                                 controller.annualBudget.toCurrency(),
  //                                 style: AppTextStyle.amountM,
  //                               ),
  //                               Text(
  //                                 '${(controller.annualBudget / 2).toCurrency()} - ${(controller.annualBudget).toCurrency()}',
  //                                 style: AppTextStyle.bodyS.copyWith(
  //                                   color: colorScheme.appTextMuted,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                       RatioScale(
  //                         value: controller.emergencyFundRatio ?? 0,
  //                         bands: emergencyFundBands,
  //                         minValue: 0,
  //                         maxValue: 100,
  //                         labelBuilder: controller.emergencyFundScaleLabel,
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(
  //                             'No Fund',
  //                             style: AppTextStyle.bodyS.copyWith(
  //                               color: colorScheme.appTextMuted,
  //                             ),
  //                           ),
  //                           Text(
  //                             'Optimal Fund',
  //                             style: AppTextStyle.bodyS.copyWith(
  //                               color: colorScheme.appTextMuted,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 20),
  //         if (controller.isOpportunityFundEnabled)
  //           AppSection(
  //             // sectionTitle: 'Debt Load Scale',
  //             child: AppSectionBody(
  //               child: Column(
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8),
  //                     child: Column(
  //                       children: [
  //                         Row(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Expanded(
  //                               child: Text(
  //                                 'Opportunity Fund',
  //                                 style: AppTextStyle.titleM,
  //                               ),
  //                             ),
  //                             Column(
  //                               crossAxisAlignment: CrossAxisAlignment.end,
  //                               children: [
  //                                 Text(
  //                                   available == null
  //                                       ? 'Not Assessed'
  //                                       : available.toCurrency(),
  //                                   style: AppTextStyle.amountM,
  //                                 ),
  //                                 Text(
  //                                   'Amount in excess emergency fund',
  //                                   style: AppTextStyle.bodyS.copyWith(
  //                                     color: colorScheme.appTextMuted,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                         RatioScale(
  //                           value: controller.emergencyFundRatio ?? 100,
  //                           bands: opportunityFundBands,
  //                           minValue: 100,
  //                           maxValue: 142.86,
  //                           labelBuilder: controller.opportunityFundScaleLabel,
  //                         ),

  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text(
  //                               'Enhanced Fund',
  //                               style: AppTextStyle.bodyS.copyWith(
  //                                 color: colorScheme.appTextMuted,
  //                               ),
  //                             ),
  //                             Text(
  //                               'Wealth-Secured Fund',
  //                               style: AppTextStyle.bodyS.copyWith(
  //                                 color: colorScheme.appTextMuted,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         SizedBox(height: 20),
  //         AppSection(
  //           sectionTitle: 'Your Available Funds',
  //           child: AppSectionBody(
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Column(
  //                 children: [
  //                   _MetricRow(
  //                     label: 'Liquid funds',
  //                     value:
  //                         controller.emergencyFundAvailable?.toCurrency() ??
  //                         'Not Assessed',
  //                   ),
  //                   const SizedBox(height: 8),
  //                   _MetricRow(
  //                     label: 'Annual budget',
  //                     value: controller.annualBudget.toCurrency(),
  //                   ),

  //                   const SizedBox(height: 16),
  //                   Container(
  //                     width: double.infinity,
  //                     padding: const EdgeInsets.symmetric(
  //                       horizontal: 16,
  //                       vertical: 12,
  //                     ),
  //                     decoration: BoxDecoration(
  //                       color: context.colors.appInfoSoft,
  //                       borderRadius: BorderRadius.circular(12),
  //                     ),
  //                     child: Column(
  //                       children: [
  //                         FittedBox(
  //                           fit: BoxFit.scaleDown,
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               Text(
  //                                 'Net Worth ÷ Budget =',
  //                                 style: AppTextStyle.bodyM,
  //                               ),
  //                               const SizedBox(width: 8),
  //                               Text(
  //                                 ratio == null
  //                                     ? 'N/A'
  //                                     : '${ratio.toStringAsFixed(2)}%',
  //                                 style: AppTextStyle.amountL,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         SizedBox(height: 8),
  //                         FittedBox(
  //                           fit: BoxFit.scaleDown,
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               Text(
  //                                 controller.emergencyFundDuration == null
  //                                     ? 'Not assessed'
  //                                     : 'Approximately ${controller.emergencyFundDuration}',
  //                                 style: AppTextStyle.bodyM,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 20),

  //         LearningSection(
  //           state: LearningSectionState.available,
  //           subtitle: 'Build a better understanding of your liquid funds.',
  //           contents: [
  //             LearnThumbnail(title: 'What is a Liquid Fund?'),
  //             LearnThumbnail(title: 'How to Quickly Build Emergency Fund'),
  //             LearnThumbnail(title: 'What is Opportunity Fund?'),
  //           ],
  //         ),
  //         SizedBox(height: 20),
  //         FinancialScoreDisclaimerSection(),
  //         SizedBox(height: 40),
  //         //Score Explanation
  //         //Insights
  //         //Score General
  //       ],
  //     ),
  //   );
  // }
}
