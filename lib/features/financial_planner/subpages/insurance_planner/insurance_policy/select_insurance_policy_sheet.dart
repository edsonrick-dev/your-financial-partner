import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/buttons/add_insurance_policy_button/add_insurance_product_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/insurance_product_card.dart';

import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class SelectInsuranceProductSheet extends GetView<InsurancePolicyController> {
  const SelectInsuranceProductSheet({super.key, required this.insurer});

  final InsuranceCompany insurer;

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      adaptiveHeight: true,
      title: 'Select Insurance Product',
      child: Obx(() {
        if (controller.isLoadingProducts.value) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        //Check if Online
        // final error = controller.productErrorMessage.value;

        // if (error != null) {
        //   return Padding(padding: const EdgeInsets.all(16), child: Text(error));
        // }

        final products = controller.availableProducts;

        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
          child: AppSection(
            child: Column(
              spacing: 20,
              children: [
                if (products.isEmpty &&
                    controller.createProductButtonState.value ==
                        AddButtonState.collapsed) ...[
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'No insurance products available for this insurer.',
                    ),
                  ),
                ] else ...[
                  Column(
                    spacing: 16,
                    children: products.map((product) {
                      return InsuranceProductCard(
                        product: product,
                        company: insurer,
                      );
                    }).toList(),
                  ),
                ],

                AddInsuranceProductButton(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
