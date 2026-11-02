import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/adaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_benefit/views/sheets/select_benefit_type_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';

class AddPolicyBenefitForm extends StatefulWidget {
  const AddPolicyBenefitForm({
    super.key,
    required this.onSave,
    required this.onCancel,
    this.initialType,
    this.initialName,
    this.initialAmount = 0,
    this.isEditing = false,
  });

  final void Function({
    required BenefitType type,
    required String? name,
    required double amount,
  })
  onSave;

  final VoidCallback onCancel;
  final BenefitType? initialType;
  final String? initialName;
  final double initialAmount;
  final bool isEditing;

  @override
  State<AddPolicyBenefitForm> createState() => _AddPolicyBenefitFormState();
}

class _AddPolicyBenefitFormState extends State<AddPolicyBenefitForm> {
  @override
  void didUpdateWidget(covariant AddPolicyBenefitForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialType != widget.initialType) {
      selectedType = widget.initialType;
    }

    if (oldWidget.initialName != widget.initialName) {
      nameController.text = widget.initialName ?? '';
    }

    if (oldWidget.initialAmount != widget.initialAmount) {
      amount = widget.initialAmount;
    }
  }

  @override
  void initState() {
    super.initState();

    selectedType = widget.initialType;
    nameController.text = widget.initialName ?? '';
    amount = widget.initialAmount;
  }

  BenefitType? selectedType;
  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();

  // Connect this to AppAmountField's actual input API.
  double amount = 0;

  @override
  void dispose() {
    nameController.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  void save() {
    final type = selectedType;

    if (type == null) {
      AppSnackbar.show(
        title: 'Missing benefit type',
        message: 'Select a benefit type.',
      );

      return;
    }

    final name = nameController.text.trim();

    if (type == BenefitType.others && name.isEmpty) {
      AppSnackbar.show(
        title: 'Missing benefit name',
        message: 'Select a benefit name.',
      );

      return;
    }

    if (amount <= 0) {
      AppSnackbar.show(
        title: 'Invalid coverage amount',
        message: 'Enter an amount greater than zero.',
      );

      return;
    }

    widget.onSave(type: type, name: name.isEmpty ? null : name, amount: amount);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.appBorder),
      ),
      child: Column(
        spacing: 12,
        children: [
          AppDropdownField(
            label: 'Benefit Type',
            value: selectedType?.label ?? '',
            hint: 'Select type',
            showIcon: false,
            onTap: () {
              Get.bottomSheet(
                SelectBenefitTypeSheet(
                  onSelected: (type) {
                    setState(() => selectedType = type);
                  },
                ),
                isScrollControlled: true,
              );
            },
          ),

          // Wire amount changes using AppAmountField's actual API.
          AppAmountField(
            label: 'Amount Covered',
            amount: amount,
            onChanged: (value) {
              setState(() => amount = value);
            },
          ),
          AppTextField(
            optional: selectedType != BenefitType.others,
            label: 'Benefit Name',
            hintText: 'Type benefit name',
            controller: nameController,
            focusNode: nameFocusNode,
          ),

          Row(
            spacing: 8,
            children: [
              AdaptivePressable(
                onTap: widget.onCancel,
                child: Container(
                  height: ButtonSize.medium.height,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.appText),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text('Cancel', style: ButtonSize.medium.textStyle),
                ),
              ),
              Expanded(
                child: AdaptivePressable(
                  onTap: save,
                  child: Container(
                    height: ButtonSize.medium.height,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: colors.buttonBackground,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.isEditing ? 'Save Changes' : 'Add Benefit',
                      style: ButtonSize.medium.textStyle.copyWith(
                        color: colors.surface,
                      ),
                    ),
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
