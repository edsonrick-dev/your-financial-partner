// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx_drift_app/core/constants/sheet_height.dart';
// import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
// import 'package:getx_drift_app/data/enums/frequency_type_enum.dart';
// import 'package:getx_drift_app/data/enums/split_mode_enum.dart';
// import 'package:getx_drift_app/domain/enums/cashflow_plan_enum.dart';
// import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/charts/preview_monthly_projection_chart.dart';
// import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
// import 'package:getx_drift_app/features/sheets/transaction_sheets/earn_transaction_sheet.dart';
// import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
// import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
// import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
// import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
// import 'package:getx_drift_app/data/enums/transaction_type.dart';
// import 'package:getx_drift_app/core/num_extension.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';

// class CreateCashFlowPlanSheet extends GetView<FinancialPlannerController> {
//   const CreateCashFlowPlanSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final columnSpacing = 12.0;
//     final colorScheme = context.colors;
//     return FractionallySizedBox(
//       heightFactor: AppSheetHeight.full,
//       child: GestureDetector(
//         behavior: HitTestBehavior.translucent,
//         onTap: () {
//           FocusManager.instance.primaryFocus?.unfocus();
//         },
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(38)),
//             color: colorScheme.surface,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ///Header
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(38),
//                     bottom: Radius.circular(20),
//                   ),
//                   // color: colorScheme.primary,
//                 ),
//                 child: Column(
//                   children: [
//                     ///Grabber
//                     AppGrabber(),

//                     ///Toolbar
//                     AppToolbar(
//                       title: 'Create Cash Flow Plan',
//                       trailingOnPressed: () {},
//                       leadingOnPressed: () {
//                         Get.back();
//                       },
//                     ),
//                   ],
//                 ),
//               ),

//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0,
//                       vertical: 16,
//                     ),
//                     child: Column(
//                       spacing: columnSpacing,
//                       children: [
//                         //PLAN TYPE PICKER
//                         Obx(
//                           () => AppDropdownField(
//                             label: 'Plan Type',
//                             value: controller
//                                 .selectedCashflowPlanType
//                                 .value
//                                 ?.label,
//                             iconKey: 'caretDown',
//                             hint: 'Select type',
//                             onTap: () {
//                               controller.selectCashflowPlanType();
//                             },
//                           ),
//                         ),

//                         _SelectCashflowCategory(controller: controller),

//                         Obx(() {
//                           final frequency = controller.selectedFrequency.value;
//                           final category = controller.selectedCategory.value;

//                           if (category == null) {
//                             return const SizedBox.shrink();
//                           }
//                           return Column(
//                             spacing: columnSpacing,
//                             children: [
//                               AppDropdownField(
//                                 label: 'Frequency',
//                                 iconKey: 'caretDown',
//                                 hint: 'Select frequency',
//                                 value:
//                                     controller.selectedFrequency.value?.label,
//                                 onTap: controller.selectFrequency,
//                               ),

//                               if (frequency != null &&
//                                   frequency.requiresMonthPattern)
//                                 AppDropdownField(
//                                   label: frequency.patternLabel,
//                                   iconKey: 'caretDown',
//                                   value:
//                                       frequency == FrequencyType.annual ||
//                                           frequency == FrequencyType.semiAnnual
//                                       ? controller.selectedMonthPattern.value
//                                             ?.fullLabel()
//                                       : controller
//                                             .selectedMonthPattern
//                                             .value
//                                             ?.label,
//                                   onTap: controller.selectMonthPattern,
//                                 ),
//                             ],
//                           );
//                         }),

//                         _BudgetDistribution(controller: controller),

//                         _MakeRecurringBill(
//                           colorScheme: colorScheme,
//                           controller: controller,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _MakeRecurringBill extends StatelessWidget {
//   const _MakeRecurringBill({
//     required this.colorScheme,
//     required this.controller,
//   });

//   final ColorScheme colorScheme;
//   final FinancialPlannerController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final frequency = controller.selectedFrequency.value;
//       final pattern = controller.selectedMonthPattern.value;
//       final canBeBill =
//           frequency != null &&
//           frequency.canBeBill &&
//           (!frequency.requiresMonthPattern || pattern != null);
//       if (!canBeBill) {
//         return const SizedBox.shrink();
//       }
//       return AnimatedContainer(
//         duration: Duration(milliseconds: 180),
//         width: double.infinity,
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: colorScheme.appInfoSoft,
//           border: Border.all(color: colorScheme.appInfo),
//           borderRadius: BorderRadius.circular(
//             controller.isBill.value == true ? 24 : 12,
//           ),
//         ),
//         child: Column(
//           spacing: 12,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         spacing: 4,
//                         children: [
//                           Icon(
//                             PhosphorIconsRegular.receipt,
//                             color: colorScheme.appInfo,
//                           ),
//                           Text(
//                             'Make Recurring Bill',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: colorScheme.appInfo,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 CupertinoSwitch(
//                   value: controller.isBill.value,
//                   onChanged: (value) {
//                     controller.isBill.value = value;
//                   },
//                 ),
//               ],
//             ),

//             if (controller.isBill.value)
//               Column(
//                 spacing: 12,
//                 children: [
//                   Obx(
//                     () => AppDropdownField(
//                       label: 'Due Date',

//                       iconKey: 'calendar',

//                       value: controller.formattedDueDay,

//                       hint: 'Select date',

//                       onTap: controller.selectDayOfMonth,
//                     ),
//                   ),
//                   Obx(
//                     () => AppDropdownField(
//                       label: 'Billing Date (optional)',

//                       iconKey: 'calendar',

//                       value: controller.formattedDate,

//                       hint: 'Select date',

//                       onTap: () {
//                         AppDatePicker.show(
//                           context: context,

//                           initialDate: controller.selectedDate.value,

//                           onChanged: controller.setDate,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       );
//     });
//   }
// }

// class _BudgetDistribution extends StatelessWidget {
//   const _BudgetDistribution({required this.controller});

//   final FinancialPlannerController controller;

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = context.colors;
//     return Obx(() {
//       final frequency = controller.selectedFrequency.value;
//       final pattern = controller.selectedMonthPattern.value;
//       final canConfigureBudget =
//           frequency != null &&
//           (!frequency.requiresMonthPattern || pattern != null);
//       if (!canConfigureBudget) {
//         return const SizedBox.shrink();
//       }
//       return GestureDetector(
//         behavior: HitTestBehavior.translucent,
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: colorScheme.appInfoSoft,
//             border: Border.all(color: colorScheme.appInfo),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             spacing: 12,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           spacing: 4,
//                           children: [
//                             Icon(
//                               PhosphorIconsRegular.arrowsSplit,
//                               color: colorScheme.appInfo,
//                             ),
//                             Text(
//                               'Budget Distribution',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color: colorScheme.appInfo,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               if (frequency.isCustomizable)
//                 Row(
//                   spacing: 2,
//                   children: [
//                     BudgetDistributionPicker(
//                       label: 'Equal',
//                       type: SplitMode.equal,
//                     ),
//                     BudgetDistributionPicker(
//                       label: 'Custom',
//                       type: SplitMode.custom,
//                     ),
//                   ],
//                 ),
//               Obx(() {
//                 if (controller.selectedSplitMode.value != SplitMode.custom) {
//                   return AppTextField(
//                     label:
//                         '${controller.selectedFrequency.value?.label} Budget',
//                     hintText: 0.toCurrency(),
//                     focusNode: controller.amountFocusNode,
//                     controller: controller.amountController,
//                   );
//                 }
//                 switch (frequency) {
//                   case FrequencyType.daily:
//                     return DailyDistributionFields();
//                   case FrequencyType.monthly:
//                     return MonthlyDistributionFields();

//                   case FrequencyType.quarterly:
//                   case FrequencyType.semiAnnual:
//                     if (pattern == null) {
//                       return const SizedBox.shrink();
//                     }
//                     return CustomDistributionFields(pattern: pattern);
//                   default:
//                     return const SizedBox.shrink();
//                 }
//               }),

//               PreviewMonthlyProjectionChart(),
//               Obx(() {
//                 return Column(
//                   children: [
//                     Row(
//                       children: [
//                         const Text('Monthly Average'),
//                         const Spacer(),

//                         Expanded(
//                           child: FittedBox(
//                             fit: BoxFit.scaleDown,
//                             alignment: Alignment.centerRight,
//                             child: Text(
//                               (controller.previewAnnualAmount / 12)
//                                   .toCurrency(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Text(
//                           'Annual Total',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         const Spacer(),
//                         Expanded(
//                           child: FittedBox(
//                             fit: BoxFit.scaleDown,
//                             alignment: Alignment.centerRight,
//                             child: Text(
//                               controller.previewAnnualAmount.toCurrency(),
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               }),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

// class _SelectCashflowCategory extends StatelessWidget {
//   const _SelectCashflowCategory({required this.controller});

//   final FinancialPlannerController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final planType = controller.selectedCashflowPlanType.value;

//       final showCategory =
//           planType == CashflowPlanType.income ||
//           planType == CashflowPlanType.expense;

//       if (!showCategory) {
//         return const SizedBox.shrink();
//       }

//       return AppDropdownField(
//         label: 'Category',
//         iconKey: controller.selectedCategory.value?.icon ?? 'category',
//         value: controller.selectedCategory.value?.name,
//         hint: 'Select category',
//         onTap: () {
//           if (planType == null) return;

//           controller.selectCategory(
//             planType == CashflowPlanType.income
//                 ? TransactionType.earn
//                 : TransactionType.spend,
//           );
//         },
//       );
//     });
//   }
// }

// class BudgetDistributionPicker extends GetView<FinancialPlannerController> {
//   const BudgetDistributionPicker({
//     super.key,
//     required this.type,
//     required this.label,
//   });

//   final SplitMode type;
//   final String label;

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = context.colors;
//     return Expanded(
//       child: Obx(() {
//         final isSelected = controller.selectedSplitMode.value == type;
//         return GestureDetector(
//           onTap: () {
//             controller.selectedSplitMode.value = type;
//           },
//           child: Container(
//             height: 38,
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? colorScheme.primary
//                   : colorScheme.inversePrimary,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               spacing: 12,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     color: isSelected
//                         ? colorScheme.inversePrimary
//                         : colorScheme.primary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
