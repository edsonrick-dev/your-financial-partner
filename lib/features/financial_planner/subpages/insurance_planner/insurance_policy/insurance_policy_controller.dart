import 'package:get/get.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/select_insurance_policy_sheet.dart';

class InsurancePolicyController extends GetxController {
  final selectedInsurer = Rxn<InsuranceCompany>();
  final selectedPolicy = Rxn<InsuranceProduct>();
  final issueDate = Rxn<DateTime>();

  final nextPaymentDate = Rxn<DateTime>();
  final selectedFrequency = BillsFrequency.monthly.obs;
  final premiumAmount = 0.0.obs;

  static const List<BillsFrequency> mvpBillFrequencies = [
    BillsFrequency.monthly,
    BillsFrequency.quarterly,
    BillsFrequency.semiAnnual,
    BillsFrequency.annual,
  ];
}
