import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/design_system/shifters/segment_shifter/app_segmented_selector.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/select_insurance_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/select_insurance_policy_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/policy_benefit_card.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePolicyForm extends GetView<InsurancePolicyController> {
  const InsurancePolicyForm({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final isPolicyUserGenerated = true;

    return AppSheet(
      height: AppSheetHeight.full,
      title: 'New Insurance Policy',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: Column(
          spacing: 20,
          children: [
            AppSection(
              sectionTitle: 'Policy Details',
              child: Column(
                spacing: 20,
                children: [
                  Obx(
                    () => AppDropdownField(
                      label: 'Insurer',
                      value: controller.selectedInsurer.value?.name ?? '',
                      hint: 'Select insurer',
                      onTap: () async {
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
                      label: 'Policy Name',
                      value: controller.selectedPolicy.value?.name ?? '',
                      hint: 'Select policy',
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

                        final hasProducts = insuranceProducts.any(
                          (product) => product.company.name == insurer.name,
                        );

                        if (!hasProducts) {
                          AppSnackbar.show(
                            title: 'No policies available',
                            message:
                                'There are no insurance products listed for ${insurer.name} yet.',
                            type: AppSnackType.warning,
                          );
                          return;
                        }

                        final product = await Get.bottomSheet<InsuranceProduct>(
                          SelectInsurancePolicySheet(insurer: insurer.name),
                          isScrollControlled: true,
                        );

                        if (product != null) {
                          controller.setInsuranceProduct(product);
                        }
                      },
                    ),
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
                        AppDatePicker.show(
                          context: context,
                          initialDate: date ?? DateTime.now(),
                          onChanged: controller.setIssueDate,
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
            AppSection(
              sectionTitle: 'Benefits',
              trailingWidget: SizedBox(
                height: 44,
                child: AdaptivePressable(
                  onTap: () {},
                  child: Center(child: Text('Add Benefit')),
                ),
              ),
              trailingType: isPolicyUserGenerated
                  ? SectionTrailingType.custom
                  // ignore: dead_code
                  : null,
              child: Column(
                spacing: 20,
                children: [
                  PolicyBenefitCard(
                    isExpanded: true,
                    type: BenefitType.majorCI,
                    name: 'Major Critical Illness',
                    amount: 1000000,
                  ),
                  PolicyBenefitCard(
                    type: BenefitType.minorCI,
                    name: 'Minor Critical Illness',
                    amount: 250000,
                  ),
                ],
              ),
            ),
            AppSection(
              sectionTitle: 'Premium Details',

              child: Column(
                spacing: 20,
                children: [
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
                        AppDatePicker.show(
                          context: context,
                          initialDate: date ?? DateTime.now(),
                          onChanged: controller.setNextPaymentDate,
                        );
                      },
                    );
                  }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Premium Payment Schedule',
                        style: AppTextStyle.titleM,
                      ),
                      SizedBox(height: 8),
                      Obx(
                        () => AppSegmentedSelector(
                          style: AppTextStyle.titleS,
                          items: InsurancePolicyController.mvpBillFrequencies
                              .map((frequency) => frequency.label)
                              .toList(),
                          selectedIndex: InsurancePolicyController
                              .mvpBillFrequencies
                              .indexOf(controller.selectedFrequency.value),
                          onChanged: (index) {
                            controller.selectedFrequency.value =
                                InsurancePolicyController
                                    .mvpBillFrequencies[index];
                          },
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => AppAmountField(
                      label:
                          '${controller.selectedFrequency.value.label} Premium',
                      amount: 0,
                    ),
                  ),
                ],
              ),
            ),
            AppSection(
              child: Column(
                spacing: 8,
                children: [
                  AppButton(text: 'Save policy information', onTap: () {}),
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
                        'Saving this policy creates the bill for this policy',
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
        ),
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

  void setInsuranceProduct(InsuranceProduct product) {
    selectedPolicy.value = product;
  }

  void setInsurer(InsuranceCompany insurer) {
    selectedInsurer.value = insurer;
  }

  void setFrequency(BillsFrequency frequency) {
    selectedFrequency.value = frequency;
  }
}
