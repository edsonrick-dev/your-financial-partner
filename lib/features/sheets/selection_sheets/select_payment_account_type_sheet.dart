import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_type_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';

class SelectPaymentAccountTypeSheet extends StatelessWidget {
  const SelectPaymentAccountTypeSheet({super.key, required this.accountTypes});
  final List<AccountType> accountTypes;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return FractionallySizedBox(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.bg,
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

                    return AccountTypeCard(
                      type: type,
                      onTap: () {
                        Get.back(result: type);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
