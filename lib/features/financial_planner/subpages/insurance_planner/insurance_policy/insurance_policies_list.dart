import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/cards/insurance_policy_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_types.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsuranceSourcesList extends GetView<InsurancePlannerController> {
  const InsuranceSourcesList({super.key, required this.type});

  final ProtectionType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

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
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  PhosphorIconsRegular.shieldPlus,
                  size: 48,
                  color: colors.appAccent,
                ),
                const SizedBox(height: 16),
                Text(
                  'No ${type.shortLabel.toLowerCase()} coverage yet',
                  style: AppTextStyle.headlineM,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Add an insurance policy with ${type.shortLabel.toLowerCase()} '
                  'benefits to see your coverage here.',
                  style: AppTextStyle.bodyM.copyWith(
                    color: colors.appTextMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
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
