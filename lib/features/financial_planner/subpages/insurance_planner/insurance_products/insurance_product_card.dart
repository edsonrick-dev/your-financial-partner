import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/models/insurance_product.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class InsuranceProductCard extends StatelessWidget {
  const InsuranceProductCard({
    super.key,
    required this.product,
    required this.company,
  });

  final InsuranceProduct product;
  final InsuranceCompany company;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppCard(
      onTap: () {
        Get.back(result: product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(company.name, style: AppTextStyle.bodyS),
          Row(
            children: [
              Expanded(child: Text(product.name, style: AppTextStyle.titleL)),
              if (product.isUserGenerated)
                Text(
                  'Created by you',
                  style: AppTextStyle.labelM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
            ],
          ),

          if (product.description != null) ...[
            SizedBox(height: 8),
            Text(
              'Ascend Description',
              style: AppTextStyle.labelM.copyWith(
                color: colorScheme.appTextMuted,
              ),
            ),
            Text(
              product.description ?? '',
              style: AppTextStyle.bodyS.copyWith(),
            ),
          ],
        ],
      ),
    );
  }
}
