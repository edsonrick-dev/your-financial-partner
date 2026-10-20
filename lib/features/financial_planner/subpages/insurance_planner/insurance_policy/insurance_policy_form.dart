import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/design_system/shifters/segment_shifter/app_segmented_selector.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/data/tables/payment_terms_table.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_benefit/views/add_policy_benefit_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/binding/insurance_company_binding.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/select_insurance_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_draft.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/premium_payment_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/select_insurance_policy_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/policy_benefit_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/models/insurance_product.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePolicyForm extends GetView<InsurancePolicyController> {
  const InsurancePolicyForm({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSheet(
      adaptiveHeight: true,
      height: AppSheetHeight.full,
      title: 'New Insurance Policy',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: Obx(() {
          return Column(
            spacing: 20,
            children: [
              _ProductDetails(controller: controller),
              if (controller.selectedProduct.value != null) ...[
                _BenefitsDetails(controller: controller),

                _PolicyDetails(controller: controller),
                _PremiumDetails(controller: controller),
                AppSection(
                  child: Column(
                    spacing: 8,
                    children: [
                      AppButton(
                        text: 'Save policy information',
                        onTap: () {
                          Get.back();
                          AppSnackbar.show(
                            title: 'Insurance policy has been saved',
                            message:
                                'AIA Health Invest Plus has been saved. A bill has also been created for this policy.',
                            type: AppSnackType.success,
                          );
                        },
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4,
                        children: [
                          Icon(
                            PhosphorIconsRegular.floppyDisk,
                            size: 16,
                            color: colorScheme.appTextMuted,
                          ),
                          Text(
                            'Saving this creates a bill for this policy',
                            style: AppTextStyle.labelM.copyWith(
                              color: colorScheme.appTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}

class _PremiumDetails extends StatelessWidget {
  const _PremiumDetails({super.key, required this.controller});

  final InsurancePolicyController controller;

  @override
  Widget build(BuildContext context) {
    return AppSection(
      sectionTitle: 'Premium Details',

      child: Column(
        spacing: 20,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Premium Payment Schedule', style: AppTextStyle.titleM),
              SizedBox(height: 8),
              Obx(
                () => AppSegmentedSelector(
                  style: AppTextStyle.titleS,
                  items: InsurancePolicyController.mvpBillFrequencies
                      .map((frequency) => frequency.label)
                      .toList(),
                  selectedIndex: InsurancePolicyController.mvpBillFrequencies
                      .indexOf(controller.selectedFrequency.value),
                  onChanged: (index) {
                    controller.selectedFrequency.value =
                        InsurancePolicyController.mvpBillFrequencies[index];
                  },
                ),
              ),
            ],
          ),
          Obx(
            () => AppAmountField(
              label: '${controller.selectedFrequency.value.label} Premium',
              amount: controller.premiumAmount.value,
              onChanged: (value) => controller.premiumAmount.value = value,
            ),
          ),
          Obx(() {
            final date = controller.nextPaymentDate.value;

            return AppDropdownField(
              label: 'Next Payment Date',
              iconKey: 'calendar',
              value: date == null
                  ? ''
                  : DateFormat('MMMM d, yyyy').format(date),
              hint: 'Select date',
              onTap: () {
                controller.nextPaymentDate.value = DateTime.now();
                AppDatePicker.show(
                  context: context,
                  initialDate: date ?? DateTime.now(),
                  onChanged: controller.setNextPaymentDate,
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class _PolicyDetails extends StatelessWidget {
  const _PolicyDetails({super.key, required this.controller});

  final InsurancePolicyController controller;

  @override
  Widget build(BuildContext context) {
    return AppSection(
      sectionTitle: 'Policy Details',
      child: Column(
        spacing: 20,
        children: [
          AppTextField(
            label: 'Policy Number',
            focusNode: controller.policyNumberFocusNode,
            controller: controller.policyNumberTextController,
          ),
          Obx(() {
            final date = controller.issueDate.value;

            return AppDropdownField(
              label: 'Issue Date',
              iconKey: 'calendar',
              value: date == null
                  ? ''
                  : DateFormat('MMMM d, yyyy').format(date),
              hint: 'Select date',
              onTap: () {
                controller.issueDate.value = DateTime.now();
                AppDatePicker.show(
                  context: context,
                  initialDate: date ?? DateTime.now(),
                  onChanged: controller.setIssueDate,
                );
              },
            );
          }),
          Obx(
            () => AppDropdownField(
              label: 'Payment Details',
              value: controller.selectedPaymentTerm.value?.label ?? '',
              hint: 'Select payment term',
              showIcon: false,
              onTap: () {
                Get.bottomSheet(
                  isScrollControlled: true,
                  const SelectPaymentDetailsSheet(),
                );
              },
            ),
          ),

          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payment details', style: AppTextStyle.titleM),
                SizedBox(height: 8),
                AppSegmentedSelector(
                  style: AppTextStyle.titleM,
                  items: PremiumPaymentType.values
                      .map((type) => type.label)
                      .toList(),
                  selectedIndex: controller.selectedPremiumPaymentType.value,
                  onChanged: (index) {
                    controller.selectedPremiumPaymentType.value = index;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelectPaymentDetailsSheet extends GetView<InsurancePolicyController> {
  const SelectPaymentDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      adaptiveHeight: true,
      title: 'Select Payment Details',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: AppSection(
          child: Obx(() {
            final terms = controller.availablePaymentTerms;

            if (controller.isLoadingPaymentTerms.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (terms.isEmpty) {
              return const Text('No payment terms available for this product.');
            }

            return Column(
              spacing: 12,
              children: terms.map((term) {
                return PaymentDetailsCard(
                  name: term.label,
                  description: term.description,
                  onTap: () {
                    controller.selectPaymentTerm(term);
                    Get.back();
                  },
                );
              }).toList(),
            );
          }),
        ),
      ),
    );
  }
}

class PaymentDetailsCard extends StatelessWidget {
  const PaymentDetailsCard({
    super.key,
    required this.name,
    this.description,
    this.onTap,
  });
  final String name;
  final String? description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: AppTextStyle.bodyL),
          if (description != null)
            Text(description ?? 'No description', style: AppTextStyle.bodyM),
        ],
      ),
    );
  }
}

class _BenefitsDetails extends StatelessWidget {
  const _BenefitsDetails({required this.controller});

  final InsurancePolicyController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isPolicyUserGenerated =
          controller.selectedProduct.value?.isUserGenerated ?? false;

      final editingIndex = controller.editingBenefitIndex.value;

      return AppSection(
        sectionTitle: 'Benefits',
        trailingWidget: SizedBox(
          height: 44,
          child: AdaptivePressable(
            onTap: controller.startAddingBenefit,
            child: const Center(child: Text('Add Benefit')),
          ),
        ),
        trailingType: isPolicyUserGenerated ? SectionTrailingType.custom : null,
        child: Column(
          spacing: 20,
          children: [
            if (controller.isLoadingBenefits.value &&
                controller.benefitDrafts.isEmpty)
              const Center(child: CircularProgressIndicator())
            else if (controller.benefitDrafts.isEmpty &&
                !controller.isAddingBenefit.value)
              const Text('No benefits available for this product.')
            else
              Column(
                spacing: 16,
                children: controller.benefitDrafts.asMap().entries.map((entry) {
                  final index = entry.key;
                  final benefit = entry.value;

                  // Edit mode: replace the selected card with the form.
                  return _buildAnimatedBenefit(
                    key:
                        'benefit-$index-${editingIndex == index ? 'editing' : 'view'}',
                    child: editingIndex == index
                        ? AddPolicyBenefitForm(
                            key: ValueKey('edit-benefit-$index'),
                            isEditing: true,
                            initialType: benefit.benefitType,
                            initialName: benefit.name,
                            initialAmount: benefit.coverageAmount,
                            onCancel: controller.cancelEditingBenefit,
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
                            onTap: isPolicyUserGenerated
                                ? () => controller.startEditingBenefit(index)
                                : null,
                            onAmountChanged: (amount) {
                              controller.updateBenefitAmount(index, amount);
                            },
                          ),
                  );

                  // View mode: show the benefit card.
                  // return PolicyBenefitCard(
                  //   type: benefit.benefitType,
                  //   name: benefit.name,
                  //   amount: benefit.coverageAmount,
                  //   onTap: isPolicyUserGenerated
                  //       ? () => controller.startEditingBenefit(index)
                  //       : null,
                  //   onAmountChanged: (amount) {
                  //     controller.updateBenefitAmount(index, amount);
                  //   },
                  // );
                }).toList(),
              ),

            // Add mode: show a blank form for user-generated products.
            if (isPolicyUserGenerated && controller.isAddingBenefit.value)
              AddPolicyBenefitForm(
                key: const ValueKey('add-benefit'),
                onCancel: controller.cancelAddingBenefit,
                onSave: ({required type, required name, required amount}) {
                  controller.addBenefitDraft(
                    PolicyBenefitDraft(
                      benefitType: type,
                      name: name,
                      coverageAmount: amount,
                    ),
                  );
                },
              ),
          ],
        ),
      );
    });
  }
}

Widget _buildAnimatedBenefit({required Widget child, required Object key}) {
  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 280),
    reverseDuration: const Duration(milliseconds: 220),
    switchInCurve: Curves.easeOutCubic,
    switchOutCurve: Curves.easeInCubic,
    transitionBuilder: (child, animation) {
      final slideAnimation = Tween<Offset>(
        begin: const Offset(0, 0.04),
        end: Offset.zero,
      ).animate(animation);

      return ClipRect(
        child: SizeTransition(
          sizeFactor: animation,
          axisAlignment: -1,
          child: FadeTransition(
            opacity: animation,
            child: SlideTransition(position: slideAnimation, child: child),
          ),
        ),
      );
    },
    child: KeyedSubtree(key: ValueKey(key), child: child),
  );
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({required this.controller});

  final InsurancePolicyController controller;

  @override
  Widget build(BuildContext context) {
    return AppSection(
      sectionTitle: 'Product Details',
      child: Column(
        spacing: 20,
        children: [
          Obx(
            () => AppDropdownField(
              label: 'Insurer',
              value: controller.selectedInsurer.value?.displayName ?? '',
              hint: 'Select insurer',
              onTap: () async {
                final binding = InsuranceCompanyBinding();
                binding.dependencies();
                final insurer = await Get.bottomSheet<InsuranceCompany>(
                  const SelectInsurerSheet(),
                  isScrollControlled: true,
                );

                if (insurer != null) {
                  controller.setInsurer(insurer);
                }
              },
              showIcon: false,
            ),
          ),
          Obx(
            () => AppDropdownField(
              label: 'Product Name',
              value: controller.selectedProduct.value?.name ?? '',
              hint: 'Select product',
              showIcon: false,

              onTap: () async {
                final insurer = controller.selectedInsurer.value;

                if (insurer == null) {
                  AppSnackbar.show(
                    title: 'Select an insurer first',
                    message:
                        'Choose an insurance company before selecting a policy.',
                    type: AppSnackType.warning,
                  );
                  return;
                }

                // if (controller.availableProducts.isEmpty) {
                //   AppSnackbar.show(
                //     title: 'No policies available',
                //     message:
                //         'No insurance products are currently available for ${insurer.name}.',
                //     type: AppSnackType.warning,
                //   );
                // }

                final product = await Get.bottomSheet<InsuranceProduct>(
                  SelectInsuranceProductSheet(insurer: insurer),
                  isScrollControlled: true,
                );

                if (product != null) {
                  controller.setInsuranceProduct(product);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

extension InsurancePolicyFormControllerX on InsurancePolicyController {
  void setIssueDate(DateTime date) {
    issueDate.value = date;
  }

  void setNextPaymentDate(DateTime date) {
    nextPaymentDate.value = date;
  }

  Future<void> setInsuranceProduct(InsuranceProduct product) async {
    selectedProduct.value = product;

    benefitDrafts.clear();
    isAddingBenefit.value = false;
    productBenefits.clear();
    benefitLoadError.value = null;

    availablePaymentTerms.clear();
    selectedPaymentTerm.value = null;

    var localProductId = product.id;

    if (localProductId == null && product.supabaseId != null) {
      final cachedProduct = await database.insurancePoliciesDao
          .getProductBySupabaseId(product.supabaseId!);

      localProductId = cachedProduct?.id;
    }

    if (localProductId == null) {
      benefitLoadError.value =
          'Save the product locally before loading its benefits.';
      return;
    }

    await loadPaymentTermsForProduct(localProductId);

    await loadBenefitsForProduct(product, localProductId: localProductId);
  }

  void setFrequency(BillsFrequency frequency) {
    selectedFrequency.value = frequency;
  }
}
