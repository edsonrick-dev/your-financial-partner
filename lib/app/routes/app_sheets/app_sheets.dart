import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/enums/frequency_type_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_plan_enum.dart';
import 'package:getx_drift_app/features/add_transaction_sheet.dart';
import 'package:getx_drift_app/features/balances/views/people_balances_view.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/app/routes/app_sheets/selection_sheets.dart';
import 'package:getx_drift_app/app/routes/app_sheets/transaction_sheets.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_cash_flow_plan/create_cash_flow_plan_sheet.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_cashflow_plan_type.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_frequency_sheet.dart';

import 'package:getx_drift_app/features/widgets/cards/category_card.dart';

class AppSheets {
  static final transaction = TransactionSheets();
  static final selection = SelectionSheets();
  static final endDrawer = _EndDrawerSheets();

  static Future<FrequencyType?> selectFrequency() async {
    return await Get.bottomSheet<FrequencyType>(
      const SelectFrequencySheet(),
      backgroundColor: Colors.transparent,
    );
  }

  static Future<void> addTransactionSheet() async {
    return await Get.bottomSheet(
      AddTransactionSheet(transaction: transaction, selection: selection),
      backgroundColor: Colors.transparent,
      isDismissible: true,
    );
  }

  static Future<void> budgetSheets() async {
    return await Get.bottomSheet(
      const CreateCashFlowPlanSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  static Future<CashflowPlanType?> selectCashflowPlanType() async {
    return await Get.bottomSheet<CashflowPlanType>(
      const SelectCashflowPlanType(),
      // isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
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
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.bottomSheet(
                          FutureBuilder(
                            future: database.getAllCashflowCategories(),
                            builder: (context, snapshot) {
                              /// LOADING

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              /// ERROR

                              if (snapshot.hasError) {
                                debugPrint('ERROR: ${snapshot.error}');

                                debugPrint('STACK: ${snapshot.stackTrace}');

                                return Text('Error: ${snapshot.error}');
                              }

                              /// NO DATA

                              if (!snapshot.hasData) {
                                return const Text('No data');
                              }

                              /// SAFE DATA ACCESS

                              final categories = snapshot.data!;

                              for (final category in categories) {
                                debugPrint(
                                  'CATEGORY: ${category.name}'
                                  ' | ICON: ${category.icon}',
                                );
                              }

                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                color: Colors.white,
                                child: ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),

                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),

                                  itemCount: categories.length,

                                  separatorBuilder: (_, _) =>
                                      const SizedBox(height: 12),

                                  itemBuilder: (context, index) {
                                    final category = categories[index];

                                    return CategoryCard(category: category);
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: Text('List of Categories in DB'),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.ACCOUNTS);
                      },
                      child: Text('List of Accounts in DB'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => const PeopleBalancesView());
                      },
                      child: const Text('People Balances'),
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
