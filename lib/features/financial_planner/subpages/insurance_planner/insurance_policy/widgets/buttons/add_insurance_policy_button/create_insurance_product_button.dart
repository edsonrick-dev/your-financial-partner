import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateInsuranceProductButton extends GetView<InsurancePolicyController> {
  const CreateInsuranceProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(() {
      final state = controller.createProductButtonState.value;
      final isExpanded = state != AddButtonState.collapsed;
      if (isExpanded) {
        return _BuildExpanded(
          isExpanded: isExpanded,
          controller: controller,
          colorScheme: colorScheme,
        );
      }
      return AppButton(
        leadingIcon: PhosphorIconsRegular.plus,
        type: ButtonType.outline,
        text: 'Create insurance product',
        onTap: () {
          controller.createProductButtonState.value = AddButtonState.expanded;
        },
      );
    });
  }
}

class _BuildExpanded extends StatelessWidget {
  const _BuildExpanded({
    required this.isExpanded,
    required this.controller,
    required this.colorScheme,
  });

  final bool isExpanded;
  final InsurancePolicyController controller;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 180),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.appBorder),
      ),
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            label: 'Product Name',
            focusNode: controller.productNameFocusNode,
            controller: controller.productNameTextController,
          ),
          Row(
            spacing: 8,
            children: [
              AdaptivePressable(
                onTap: controller.collapseButton,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.appText),
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
                  onTap: controller.saveInsuranceProduct,
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
                          'Save product',
                          style: ButtonSize.medium.textStyle.copyWith(
                            color: context.colors.surface,
                          ),
                        ),
                      ],
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
