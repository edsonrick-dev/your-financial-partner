import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/questionnaires/protection_horizon/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/questionnaires/protection_horizon/models/protection_horizon_option.dart';

const deathBenefitHorizonOptions = [
  ProtectionHorizonOption(
    horizon: ProtectionHorizon.zero,
    description: 'Not providing ongoing support for your dependents.',
    whenToChoose:
        'This option is only suitable if you have no financial dependents and your existing assets are entirely sufficient to cover final expenses and outstanding debts.',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.five,
    description: 'A 5-year buffer for your dependents to adjust.',
    whenToChoose:
        'Ideal if your dependents are older teens or adults who are already on a clear path to becoming financially self-sufficient.',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.ten,
    description: 'A 10-year foundation for your dependents’ stability.',
    whenToChoose:
        'Provides a substantial period of financial support while balancing the cost of coverage.',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.fifteen,
    description: 'Long-term security for your dependents’ future.',
    whenToChoose:
        'Suitable when dependents are likely to need financial support for an extended period.',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.twenty,
    description: 'Maximum long-term protection for your dependents.',
    whenToChoose:
        'Provides long-term financial support for dependents who may need assistance well into adulthood.',
  ),
];
