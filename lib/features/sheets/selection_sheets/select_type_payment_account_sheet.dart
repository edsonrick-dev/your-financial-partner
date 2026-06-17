import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';

class SelectPaymentAccountTypeSheet extends StatelessWidget {
  const SelectPaymentAccountTypeSheet({super.key, required this.accountTypes});
  final List<AccountType> accountTypes;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: Container(
        // constraints: BoxConstraints(maxHeight: Get.height * 0.75, minHeight: 200),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(38)),
        ),

        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              /// Header
              Column(
                children: [
                  AppGrabber(),
                  AppToolbar(title: 'Select Payment Account Type'),
                ],
              ),
              Flexible(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: accountTypes.length,
                  itemBuilder: (context, index) {
                    final type = accountTypes[index];

                    return GestureDetector(
                      onTap: () {
                        Get.back(result: type);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.payments),
                            const SizedBox(width: 12),
                            Expanded(child: Text(type.label)),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                ),
              ),
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //       child: Column(
              //         spacing: 12,
              //         children: [
              //           AccountCard(
              //             name: 'Cash',
              //             icon: Icons.monetization_on_outlined,
              //             balance: 'P0.00',
              //           ),
              //           AccountCard(
              //             name: 'Savings Account',
              //             icon: Icons.account_balance_outlined,
              //             balance: 'P0.00',
              //           ),
              //           AccountCard(
              //             name: 'Checking Account',
              //             icon: Icons.account_balance_outlined,
              //             balance: 'P0.00',
              //           ),
              //           AccountCard(
              //             name: 'Credit Card',
              //             icon: Icons.credit_card_outlined,
              //             balance: 'P0.00',
              //           ),
              //           // const SizedBox(height: 12),
              //           GestureDetector(
              //             onTap: () {
              //               AppSheets.createPaymentAccount();
              //             },
              //             child: Container(
              //               alignment: Alignment.center,
              //               constraints: BoxConstraints(minHeight: 44),
              //               width: double.infinity,
              //               decoration: BoxDecoration(
              //                 color: Colors.grey[200],
              //                 borderRadius: BorderRadius.circular(999),
              //               ),
              //               child: Text('Add New Payment Account'),
              //             ),
              //           ),

              //           const SizedBox(height: 24),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
