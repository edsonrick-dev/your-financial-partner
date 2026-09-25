import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_group_enum.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:intl/intl.dart';

class CardPaymentForm extends GetView<TransactionController> {
  const CardPaymentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionType = TransactionType.cardPayment;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: AppSection(
        child: Column(
          spacing: 16,
          children: [
            Text('${controller.selectedLinkedAccount.value}'),
            Obx(() {
              final card = controller.selectedLinkedAccount.value;

              if (card == null) {
                return const SizedBox.shrink();
              }

              return FutureBuilder<CreditCardStatementsTableData?>(
                future: controller.getCreditCardStatement(card),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: CircularProgressIndicator(),
                    );
                  }

                  final statement = snapshot.data;
                  debugPrint('$statement');
                  if (statement == null) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.colors.bgLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.colors.appBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment due',
                          style: AppTextStyle.bodyM.copyWith(
                            color: context.colors.appText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          statement.statementBalance.toCurrency(),
                          style: AppTextStyle.amountL,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Due ${DateFormat('MMMM d, yyyy').format(statement.paymentDueDate)}',
                          style: AppTextStyle.bodyM.copyWith(
                            color: context.colors.appTextMuted,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
            Obx(
              () => AppDropdownField(
                label: 'Date',

                iconKey: 'calendar',

                value: controller.formattedDate,

                hint: 'Select date',

                onTap: () {
                  AppDatePicker.show(
                    context: context,

                    initialDate: controller.selectedDate.value,

                    onChanged: controller.setDate,
                  );
                },
              ),
            ),
            Obx(
              () => AppDropdownField(
                label: 'From',
                showIcon: controller.selectedAccount.value?.icon != null,
                iconKey: controller.selectedAccount.value?.icon ?? 'account',
                value: controller.selectedAccount.value?.name,
                hint: 'Select account',
                onTap: () => controller.selectAccount(transactionType),
              ),
            ),

            Obx(
              () => AppDropdownField(
                label: 'Card to pay',
                showIcon: controller.selectedLinkedAccount.value?.icon != null,
                iconKey:
                    controller.selectedLinkedAccount.value?.icon ?? 'account',
                value: controller.selectedLinkedAccount.value?.name,
                hint: 'Select credit card',
                onTap: () => controller.selectLinkedAccount(
                  transactionType,
                  accountGroup: AccountGroup.creditCards,
                ),
              ),
            ),
            AppTextField(
              optional: true,
              label: 'Notes',
              controller: controller.noteController,
              focusNode: controller.noteFocusNode,
              multiLine: true,
            ),
          ],
        ),
      ),
    );
  }
}
