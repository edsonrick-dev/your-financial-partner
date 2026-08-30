import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:intl/intl.dart';

class CreditCardInstallmentForm
    extends GetView<CreditCardInstallmentController> {
  const CreditCardInstallmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: Column(
        spacing: 20,
        children: [
          // =====================================================
          // CREDIT CARD
          // =====================================================
          Obx(
            () => AppDropdownField(
              iconKey: 'credit-card',
              label: 'Credit Card',
              value: controller.selectedCreditCard.value?.name,
              onTap: () async {
                final card = await AppSheets.selection.selectCreditCard();

                if (card == null) return;

                controller.selectCreditCard(card);
              },
            ),
          ),

          // =====================================================
          // CURRENT BALANCE
          // =====================================================
          Obx(() {
            final card = controller.selectedCreditCard.value;

            if (card == null) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Current Balance'),
                Text('₱${card.currentValue.toStringAsFixed(2)}'),
              ],
            );
          }),

          // =====================================================
          // INSTALLMENT AMOUNT
          // =====================================================
          Obx(
            () => AppAmountField(
              label: 'Installment Amount',
              amount: controller.installmentAmount.value,
              onChanged: controller.setInstallmentAmount,
            ),
          ),

          // =====================================================
          // MONTHLY PAYMENT
          // =====================================================
          Obx(
            () => AppAmountField(
              label: 'Monthly Payment',
              amount: controller.monthlyPayment.value,
              onChanged: controller.setMonthlyPayment,
            ),
          ),
          // =====================================================
          // NUMBER OF MONTHS
          // =====================================================
          AppTextField(
            label: 'Payment Term',
            controller: controller.installmentMonthsController,
            keyboardType: TextInputType.number,
            onChanged: controller.setInstallmentMonthsFromText,
            focusNode: controller.installmentMonthsFocusNode,
          ),
          Obx(
            () => AppDropdownField(
              label: 'First Payment Date',
              iconKey: 'calendar',
              value: controller.formattedFirstPaymentDate,
              hint: 'Select date',
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();

                AppDatePicker.show(
                  context: context,
                  initialDate: controller.firstPaymentDate.value,
                  onChanged: controller.selectFirstPaymentDate,
                );
              },
            ),
          ),
          Obx(
            () => Column(
              children: [
                Text('Total Repayment'),
                Text('₱${controller.totalRepayment.toStringAsFixed(2)}'),
                Text('Interest / Finance Charge'),
                Text('₱${controller.interestAmount.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreditCardInstallmentController extends GetxController {
  String? get formattedFirstPaymentDate {
    final date = firstPaymentDate.value;

    if (date == null) return null;

    return DateFormat('MMMM d, yyyy').format(date);
  }

  // ============================================================
  // FORM STATE
  // ============================================================
  final TextEditingController installmentMonthsController =
      TextEditingController();
  final FocusNode installmentMonthsFocusNode = FocusNode();
  void setInstallmentMonthsFromText(String value) {
    final months = int.tryParse(value) ?? 0;
    installmentMonths.value = months;
  }

  @override
  void onClose() {
    installmentMonthsController.dispose();
    super.onClose();
  }

  final selectedCreditCard = Rxn<AccountsTableData>();

  final RxDouble installmentAmount = 0.0.obs;

  final RxInt installmentMonths = 0.obs;

  final RxDouble monthlyPayment = 0.0.obs;

  final Rxn<DateTime> firstPaymentDate = Rxn<DateTime>(DateTime.now());
  double get totalRepayment {
    return monthlyPayment.value * installmentMonths.value;
  }

  double get interestAmount {
    return totalRepayment - installmentAmount.value;
  }
  // ============================================================
  // CREDIT CARD
  // ============================================================

  void selectCreditCard(AccountsTableData card) {
    selectedCreditCard.value = card;

    // The amount belongs to the selected card,
    // so reset it when changing cards.
    installmentAmount.value = card.currentValue;
  }

  double get creditCardBalance {
    return selectedCreditCard.value?.currentValue ?? 0;
  }

  double get maximumInstallmentAmount {
    return creditCardBalance;
  }

  // ============================================================
  // INSTALLMENT AMOUNT
  // ============================================================

  void setInstallmentAmount(double value) {
    installmentAmount.value = value;
  }

  // ============================================================
  // PAYMENT TERM
  // ============================================================

  void setInstallmentMonths(int value) {
    installmentMonths.value = value;
  }

  // ============================================================
  // MONTHLY PAYMENT
  // ============================================================

  void setMonthlyPayment(double value) {
    monthlyPayment.value = value;
  }

  // ============================================================
  // FIRST PAYMENT
  // ============================================================

  void selectFirstPaymentDate(DateTime date) {
    firstPaymentDate.value = date;
  }

  // ============================================================
  // RESET
  // ============================================================

  void resetForm() {
    selectedCreditCard.value = null;
    installmentAmount.value = 0;
    installmentMonths.value = 0;
    monthlyPayment.value = 0;
    firstPaymentDate.value = null;
  }
}

extension CreditCardInstallmentValidationExtension
    on CreditCardInstallmentController {
  bool get hasSelectedCreditCard {
    return selectedCreditCard.value != null;
  }

  bool get hasValidInstallmentAmount {
    return installmentAmount.value > 0 &&
        installmentAmount.value <= maximumInstallmentAmount;
  }

  bool get hasValidInstallmentMonths {
    return installmentMonths.value > 0;
  }

  bool get hasValidMonthlyPayment {
    return monthlyPayment.value > 0;
  }

  bool get hasSelectedFirstPaymentDate {
    return firstPaymentDate.value != null;
  }

  bool get isFormValid {
    return hasSelectedCreditCard &&
        hasValidInstallmentAmount &&
        hasValidInstallmentMonths &&
        hasValidMonthlyPayment &&
        hasSelectedFirstPaymentDate;
  }
}

// Select Credit Card
//         ↓
// Read current card balance
//         ↓
// Maximum installment = card.currentValue
//         ↓
// Enter installment amount
//         ↓
// Select payment term
//         ↓
// Create installment
//         ↓
// Reduce credit-card balance
//         ↓
// Create installment obligation
class CreditCardInstallment {
  final int id;
  final int creditCardAccountId;
  final double principal;
  final int termMonths;
  final double monthlyPayment;
  final double totalRepayment;
  final double interestAmount;
  final DateTime startDate;
  final DateTime firstPaymentDate;

  const CreditCardInstallment({
    required this.id,
    required this.creditCardAccountId,
    required this.principal,
    required this.termMonths,
    required this.monthlyPayment,
    required this.totalRepayment,
    required this.interestAmount,
    required this.startDate,
    required this.firstPaymentDate,
  });
}

class ObligationPayment {
  final int id;
  final int installmentId;
  final int installmentNumber;
  final DateTime dueDate;
  final double amount;
  final bool isPaid;
  final DateTime? paidAt;

  const ObligationPayment({
    required this.id,
    required this.installmentId,
    required this.installmentNumber,
    required this.dueDate,
    required this.amount,
    required this.isPaid,
    this.paidAt,
  });
}

class SelectCreditCardSheet extends StatelessWidget {
  const SelectCreditCardSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      title: 'Select Credit Card',
      child: StreamBuilder<List<AccountsTableData>>(
        stream: database.accountsDao.watchCreditCards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Unable to load credit cards.'));
          }

          final cards = snapshot.data ?? [];

          if (cards.isEmpty) {
            return const Center(child: Text('No credit cards found.'));
          }

          return ListView.separated(
            shrinkWrap: true,
            itemCount: cards.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final card = cards[index];

              return ListTile(
                title: Text(card.name),
                subtitle: Text('₱${card.currentValue.toStringAsFixed(2)}'),
                onTap: () {
                  Get.back(result: card);
                },
              );
            },
          );
        },
      ),
    );
  }
}
