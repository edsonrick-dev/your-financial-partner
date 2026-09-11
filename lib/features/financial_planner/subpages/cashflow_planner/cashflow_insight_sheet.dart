import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class CashflowInsightSheet extends StatelessWidget {
  const CashflowInsightSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      title: 'Cashflow Insights',
      adaptiveHeight: true,
      height: AppSheetHeight.threeQuarter,
      child: Column(),
    );
  }
}
