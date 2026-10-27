import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/show_add_policy_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/insurance_policy_list_item.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/cards/user_insurance_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePoliciesView extends GetView<InsurancePolicyController> {
  const InsurancePoliciesView({super.key});

  Future<void> _confirmDeletePolicy(
    BuildContext context,
    InsurancePolicyListItem policy,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete insurance policy?'),
        content: Text(
          'Delete ${policy.productName}${policy.policyNumber.isEmpty ? '' : ' (${policy.policyNumber})'}? '
          'Its premium bill and coverage details will also be deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await controller.deletePolicy(policy.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Insurance Policies', style: AppTextStyle.headlineL),
        actions: const [_AddPolicyButton()],
        actionsPadding: const EdgeInsets.only(right: 16),
      ),
      body: Obx(() {
        final policies = controller.policies;

        if (policies.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    PhosphorIconsRegular.shieldCheck,
                    size: 56,
                    color: colors.appTextMuted,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No insurance policies yet',
                    style: AppTextStyle.titleL,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add your existing insurance policies to keep '
                    'your protection details organized.',
                    style: AppTextStyle.bodyM.copyWith(
                      color: colors.appTextMuted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: showAddPolicyForm,
                    icon: const Icon(PhosphorIconsRegular.plus),
                    label: const Text('Add Policy'),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: context.bottomPaddingSub,
          ),
          itemCount: policies.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final policy = policies[index];

            return InsurancePolicyCard(
              item: policy,
              onTap: () {
                // Your navigation logic.
              },
              onLongPress: () => _confirmDeletePolicy(context, policy),
            );
          },
        );
      }),
    );
  }
}

class _AddPolicyButton extends StatelessWidget {
  const _AddPolicyButton();

  @override
  Widget build(BuildContext context) {
    return AdaptivePressable(
      onTap: showAddPolicyForm,
      child: Icon(PhosphorIconsRegular.plus),
    );
  }
}
