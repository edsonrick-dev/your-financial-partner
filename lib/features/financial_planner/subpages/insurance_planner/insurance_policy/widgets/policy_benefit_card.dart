import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class PolicyBenefitCard extends StatelessWidget {
  const PolicyBenefitCard({
    super.key,
    required this.type,
    required this.amount,
    this.isExpanded = false,
    this.name,
  });
  final String? name;
  final BenefitType type;
  final double amount;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return isExpanded
        ? AnimatedContainer(
            duration: Duration(milliseconds: 180),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colorScheme.appBorder),
            ),

            child: Column(
              spacing: 12,
              children: [
                AppDropdownField(
                  label: 'Benefit Type',
                  value: '',
                  hint: 'Select type',
                  onTap: () {
                    Get.bottomSheet(
                      SelectBenefitTypeSheet(),
                      isScrollControlled: true,
                    );
                  },
                  showIcon: false,
                ),
                AppTextField(
                  label: 'Benefit Name',
                  hintText: 'Type benefit name',
                  focusNode: FocusNode(),
                  controller: TextEditingController(),
                ),

                AppAmountField(label: 'Amount Covered', amount: 0),
                Row(
                  spacing: 8,
                  children: [
                    ///CANCEL BUTTON
                    // Flexible(flex: 1, child: AppButton(text: 'Cancel')),
                    // Expanded(child: AppButton(text: 'Save account')),
                    AdaptivePressable(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: context.colors.appText),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: ButtonSize.medium.height,
                        child: Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Cancel', style: ButtonSize.medium.textStyle),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: AdaptivePressable(
                        onTap: () async {},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          decoration: BoxDecoration(
                            color: context.colors.buttonBackground,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: ButtonSize.medium.height,
                          child: Row(
                            spacing: 8,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Save Benefit',
                                style: ButtonSize.medium.textStyle.copyWith(
                                  color: context.colors.surface,
                                ),
                              ),
                              // state == AddButtonState.loading
                              //     ? Center(
                              //         child:
                              //             CircularProgressIndicator(
                              //               color: context
                              //                   .colors
                              //                   .surface,
                              //             ),
                              //       )
                              //     :
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : AppCard(
            padding: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        name == null ? type.label : name!,
                        style: AppTextStyle.bodyL,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(amount.toCurrency(), style: AppTextStyle.amountL),
                  ],
                ),
                SizedBox(height: 4),
                if (name != null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          type.label,
                          style: AppTextStyle.bodyS.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
  }
}

class SelectBenefitTypeSheet extends StatelessWidget {
  const SelectBenefitTypeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSheet(
      title: 'Select Benefit Type',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: AppSection(
          child: Column(
            spacing: 20,
            children: BenefitType.values.map((type) {
              return AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(type.label, style: AppTextStyle.titleL),
                    Text(
                      type.description,
                      style: AppTextStyle.bodyM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
