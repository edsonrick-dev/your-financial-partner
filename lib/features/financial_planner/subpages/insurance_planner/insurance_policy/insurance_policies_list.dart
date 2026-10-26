import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/cards/insurance_policy_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_types.dart';

class InsuranceSourcesList extends GetView<InsurancePlannerController> {
  const InsuranceSourcesList({super.key, required this.type});

  final ProtectionType type;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<InsuranceSource>>(
      stream: database.userInsurancePolicyDao.watchInsuranceSourcesByType(
        type.benefitType,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Unable to load your insurance sources.');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final sources = snapshot.data ?? [];

        if (sources.isEmpty) {
          return const Text(
            'You have no insurance coverage for this protection type.',
          );
        }

        // final totalCoverage = sources.fold<double>(
        //   0,
        //   (total, source) => total + source.amount,
        // );

        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   if (type == ProtectionType.criticalIllness) {
        //     controller.criticalIllnessCovered.value = totalCoverage;
        //   }
        // });

        return Column(
          spacing: 20,
          children: sources.map((source) {
            return InsuranceSourceCard(
              policyId: source.policyId,
              policyNumber: source.policyNumber,
              type: type,
              amount: source.amount,
              issuer: source.issuer,
              name: source.name,
            );
          }).toList(),
        );
      },
    );
  }
}
