import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_benefit/views/add_policy_benefit_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_draft.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/policy_benefit_card.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';

import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateInsuranceProductSheet extends GetView<InsurancePolicyController> {
  const CreateInsuranceProductSheet({super.key, required this.insurer});
  final InsuranceCompany insurer;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Add ${insurer.displayName} Product',
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  AppSection(
                    child: AppGradientCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Prepare your policy details',
                            style: AppTextStyle.titleL.copyWith(
                              color: colorScheme.appInversedtext,
                            ),
                          ),
                          Text(
                            'Have your insurance policy document handy to quickly enter your policy number, benefits, coverage amounts, and premium details.',
                            style: AppTextStyle.bodyM.copyWith(
                              color: colorScheme.appInversedtext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSection(
                    child: Column(
                      spacing: 12,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppTextField(
                          label: 'Product Name',
                          focusNode: controller.productNameFocusNode,
                          controller: controller.productNameTextController,
                        ),
                      ],
                    ),
                  ),

                  Obx(() {
                    final editingIndex = controller.editingBenefitIndex.value;

                    return AppSection(
                      sectionTitle: 'Benefits',
                      trailingWidget: controller.benefitDrafts.isNotEmpty
                          ? AdaptivePressable(
                              onTap: controller.startAddingBenefit,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 12,
                                ),
                                child: Text('Add Benefit'),
                              ),
                            )
                          : null,
                      trailingType: controller.benefitDrafts.isNotEmpty
                          ? SectionTrailingType.custom
                          : null,
                      child: Column(
                        spacing: 16,
                        children: [
                          if (controller.benefitDrafts.isEmpty &&
                              !controller.isAddingBenefit.value)
                            const Text('No benefits added yet.')
                          else
                            Column(
                              spacing: 12,
                              children: controller.benefitDrafts
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                    final index = entry.key;
                                    final benefit = entry.value;

                                    return editingIndex == index
                                        ? AddPolicyBenefitForm(
                                            key: ValueKey(
                                              'edit-benefit-$index',
                                            ),
                                            isEditing: true,
                                            initialType: benefit.benefitType,
                                            initialName: benefit.name,
                                            initialAmount:
                                                benefit.coverageAmount,
                                            onCancel:
                                                controller.cancelEditingBenefit,
                                            onSave:
                                                ({
                                                  required type,
                                                  required name,
                                                  required amount,
                                                }) {
                                                  controller.updateBenefitDraft(
                                                    index,
                                                    type: type,
                                                    name: name,
                                                    amount: amount,
                                                  );
                                                },
                                          )
                                        : PolicyBenefitCard(
                                            type: benefit.benefitType,
                                            name: benefit.name,
                                            amount: benefit.coverageAmount,
                                            onTap: () => controller
                                                .startEditingBenefit(index),
                                            onAmountChanged: (amount) {
                                              controller.updateBenefitAmount(
                                                index,
                                                amount,
                                              );
                                            },
                                          );
                                  })
                                  .toList(),
                            ),

                          if (controller.isAddingBenefit.value)
                            AddPolicyBenefitForm(
                              key: const ValueKey('add-benefit'),
                              onCancel: controller.cancelAddingBenefit,
                              onSave:
                                  ({
                                    required type,
                                    required name,
                                    required amount,
                                  }) {
                                    controller.addBenefitDraft(
                                      PolicyBenefitDraft(
                                        benefitType: type,
                                        name: name,
                                        coverageAmount: amount,
                                      ),
                                    );
                                  },
                            )
                          else if (controller.benefitDrafts.isEmpty)
                            AppButton(
                              text: 'Add Benefit',
                              onTap: controller.startAddingBenefit,
                              size: ButtonSize.medium,
                              leadingIcon: PhosphorIconsRegular.plus,
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          Obx(() {
            if (controller.benefitDrafts.isNotEmpty) {
              return Column(
                children: [
                  SizedBox(height: 8),
                  AppSection(
                    child: AppButton(
                      text: 'Save product details',
                      onTap: controller.saveInsuranceProduct,
                    ),
                  ),
                  SizedBox(height: context.bottomPaddingSub),
                ],
              );
            }

            return SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
