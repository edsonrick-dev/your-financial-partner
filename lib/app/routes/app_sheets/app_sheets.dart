import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/add_transaction_sheet.dart';
import 'package:getx_drift_app/app/routes/app_sheets/selection_sheets.dart';
import 'package:getx_drift_app/app/routes/app_sheets/transaction_sheets.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/account_action_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/cash_and_bank_details_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/credit_card_details_sheet/credit_card_detail_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/loan_detail_sheet/load_detail_sheet.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_sheets.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_details_screen_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/views/sheet/shell/financial_stability_sheet_shell.dart';

class AppSheets {
  static final transaction = TransactionSheets();
  static final selection = SelectionSheets();
  static final endDrawer = _EndDrawerSheets();
  static final learningSheets = LearningSheets();

  static Future<void> viewStabilityProfileDetails(
    FinancialRatioType? ratioType,
  ) async {
    final controller = Get.find<FinancialProfileController>();

    if (ratioType != null) {
      controller.selectRatioTab(ratioType);
    } else {
      controller.selectedDetailsIndex.value = 0;
    }

    return Get.bottomSheet(
      const FinancialStabilitySheetShell(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  // static Future<FrequencyType?> selectFrequency() async {
  //   return await Get.bottomSheet<FrequencyType>(
  //     const SelectFrequencySheet(),
  //     backgroundColor: Colors.transparent,
  //   );
  // }

  static Future<void> addTransactionSheet() async {
    return await Get.bottomSheet(
      AddTransactionSheet(transaction: transaction, selection: selection),
      backgroundColor: Colors.transparent,
      isDismissible: true,
    );
  }

  static Future<void> openAccountActionSheet(AccountsTableData account) async {
    return await Get.bottomSheet(
      AccountActionsSheet(account: account),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  static Future<void> viewCreditCardDetailSheet(
    AccountsTableData account,
  ) async {
    return await Get.bottomSheet(
      CreditCardDetailSheet(account: account),
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
    );
  }

  static Future<void> viewLoanDetailSheet(AccountsTableData account) async {
    return await Get.bottomSheet(
      LoanDetailSheet(account: account),
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
    );
  }

  static Future<void> viewCashAndBankDetailSheet(
    AccountsTableData account,
  ) async {
    return await Get.bottomSheet(
      CashAndBankDetailsSheet(account: account),
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
    );
  }

  // static Future<void> budgetSheets() async {
  //   return await Get.bottomSheet(
  //     const CreateCashFlowPlanSheet(),
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //   );
  // }

  // static Future<CashflowPlanType?> selectCashflowPlanType() async {
  //   return await Get.bottomSheet<CashflowPlanType>(
  //     const SelectCashflowPlanType(),
  //     // isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //   );
  // }
}

class _EndDrawerSheets {
  Future<void> openHomeMenu() {
    return Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: 'Menu',
      barrierColor: Colors.black54,

      transitionDuration: const Duration(milliseconds: 250),

      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,

          child: Material(
            color: Colors.transparent,

            child: Container(
              width: 300,
              height: double.infinity,

              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(38),
                ),
                color: Colors.white,
              ),

              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'Menu options will appear here as launch-ready actions are added.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },

      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
