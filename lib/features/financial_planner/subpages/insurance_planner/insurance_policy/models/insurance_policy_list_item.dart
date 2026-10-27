import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';

class InsurancePolicyListItem {
  final int id;
  final String productName;
  final String insurerName;
  final String policyNumber;
  final BillsFrequency paymentFrequency;
  final DateTime? nextDue;
  final double amountDue;

  const InsurancePolicyListItem({
    required this.id,
    required this.productName,
    required this.insurerName,
    required this.policyNumber,
    required this.paymentFrequency,
    required this.nextDue,
    required this.amountDue,
  });
}
