import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

// class SelectInsurancePolicySheet extends StatelessWidget {
//   const SelectInsurancePolicySheet({super.key, required this.insurer});
//   final String insurer;
//   @override
//   Widget build(BuildContext context) {
//     final products = insuranceProducts
//         .where((product) => product.company.name == insurer)
//         .toList();
//     return AppSheet(
//       adaptiveHeight: true,
//       title: 'Select Insurance Policy',
//       child: SingleChildScrollView(
//         padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
//         child: AppSection(
//           child: products.isEmpty
//               ? Text('Wala ngani')
//               : Column(
//                   spacing: 20,
//                   children: products.map((product) {
//                     return InsuranceProductCard(product: product);
//                   }).toList(),
//                 ),
//         ),
//       ),
//     );
//   }
// }

class SelectInsurancePolicySheet extends StatelessWidget {
  const SelectInsurancePolicySheet({super.key, required this.insurer});

  final InsuranceCompany insurer;

  @override
  Widget build(BuildContext context) {
    // Fetch policies for insurer.id using your GetX controller.
    // Display the resulting products here.

    return AppSheet(
      adaptiveHeight: true,
      title: 'Select Insurance Policy',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: AppSection(
          child: const Text('Load policies from Supabase here'),
        ),
      ),
    );
  }
}

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
    return AppCard(
      onTap: () {
        Get.back(result: product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(company.name, style: AppTextStyle.bodyS),
          Text(product.name, style: AppTextStyle.titleL),
        ],
      ),
    );
  }
}

class InsuranceProduct {
  final int id;
  final String name;
  final int companyId;

  const InsuranceProduct({
    required this.id,
    required this.name,
    required this.companyId,
  });

  factory InsuranceProduct.fromJson(Map<String, dynamic> json) {
    return InsuranceProduct(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      companyId: (json['insurer_entity_id'] as num).toInt(),
    );
  }
}
// class InsuranceProduct {
//   final int id;
//   final String name;
//   final int companyId;

//   const InsuranceProduct({
//     required this.id,
//     required this.name,
//     required this.companyId,
//   });
// }

// const aiaProducts = [
//   InsuranceProduct(
//     name: 'AIA Critical Protect 100',
//     company: InsuranceCompany(name: 'AIA Philippines'),
//   ),
//   InsuranceProduct(
//     name: 'AIA Health Invest Plus',
//     company: InsuranceCompany(name: 'AIA Philippines'),
//   ),
// ];
