import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_benefit/views/add_policy_benefit_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_draft.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/policy_benefit_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class BenefitsDetailsSection extends GetView<InsurancePolicyController> {
  const BenefitsDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final product = controller.selectedProduct.value;
      final isUserGenerated = product?.isUserGenerated ?? false;
      final editingIndex = controller.editingBenefitIndex.value;

      return AppSection(
        sectionTitle: 'Benefits',
        subtitle: 'Review the coverage amount for each benefit.',
        trailingType: isUserGenerated ? SectionTrailingType.custom : null,
        trailingWidget: isUserGenerated
            ? SizedBox(
                height: 44,
                child: AdaptivePressable(
                  onTap: controller.startAddingBenefit,
                  child: const Center(child: Text('Add Benefit')),
                ),
              )
            : null,
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

                  final benefitDefinition = controller.productBenefits
                      .firstWhereOrNull(
                        (item) => item.id == benefit.insuranceBenefitId,
                      );

                  final isRequired = benefitDefinition?.isRequired ?? false;

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
                            isRequired: isRequired,
                            onTap: isUserGenerated
                                ? () => controller.startEditingBenefit(index)
                                : null,
                            onAmountChanged: (amount) {
                              controller.updateBenefitAmount(index, amount);
                            },
                          ),
                  );
                }).toList(),
              ),

            if (isUserGenerated && controller.isAddingBenefit.value)
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
