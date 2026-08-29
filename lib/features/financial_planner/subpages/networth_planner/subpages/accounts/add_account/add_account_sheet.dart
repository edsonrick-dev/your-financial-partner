import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/account_form.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class AddAccountSheet extends GetView<AccountController> {
  const AddAccountSheet({super.key, required this.accountType});

  final AccountType accountType;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AppSheet(
        adaptiveHeight: true,
        title: 'Add ${accountType.label}',
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: AccountForm(accountType: accountType),
              ),
            ),

            const SizedBox(height: 24),
            AppSection(
              child: Obx(
                () => AppButton(
                  onTap: controller.isAccountFormValid
                      ? () async {
                          final createdAccount = await controller.saveAccount();

                          if (createdAccount != null) {
                            Get.back();
                          }
                        }
                      : null,
                  text: 'Save ${accountType.label.toLowerCase()}',
                ),
              ),
            ),

            SizedBox(height: bottomPadding),
          ],
        ),
      ),
    );
  }
}
// import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
// import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';

extension AccountValidationExtension on AccountController {
  bool get isAccountFormValid {
    final type = selectedAccountType.value;

    if (type == null) {
      return false;
    }

    switch (type) {
      case AccountType.cash:
        return isCashAccountValid;

      case AccountType.savingsAccount:
        return isSavingsAccountValid;

      case AccountType.checkingAccount:
        return isCheckingAccountValid;

      case AccountType.eWallet:
        return isEWalletAccountValid;

      case AccountType.creditCard:
        return isCreditCardAccountValid;

      case AccountType.realProperty:
        return isRealPropertyAccountValid;

      default:
        return false;
    }
  }

  bool get hasValidAccountName {
    return accountName.value.trim().isNotEmpty;
  }

  bool get hasValidBalance {
    return enteredBalance.value > 0;
  }

  bool get hasSelectedFinancialInstitution {
    return selectedInstitution.value != null;
  }

  bool get isCashAccountValid {
    return hasValidAccountName && hasValidBalance;
  }

  bool get isSavingsAccountValid {
    return hasValidAccountName &&
        hasSelectedFinancialInstitution &&
        hasValidBalance;
  }

  bool get isCheckingAccountValid {
    return hasValidAccountName &&
        hasSelectedFinancialInstitution &&
        hasValidBalance;
  }

  bool get isEWalletAccountValid {
    return hasValidAccountName &&
        hasSelectedFinancialInstitution &&
        hasValidBalance;
  }

  bool get isCreditCardAccountValid {
    return hasValidAccountName &&
        hasSelectedFinancialInstitution &&
        hasValidBalance &&
        enteredCreditLimit.value > 0;
  }

  bool get isRealPropertyAccountValid {
    return hasValidAccountName && enteredBalance.value > 0;
  }
}
