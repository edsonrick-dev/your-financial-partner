import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/features/transaction/category_list.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

class SelectCategorySheet extends StatelessWidget {
  final TransactionType transactionType;
  final CashflowCategoriesTableData? selectedCategory;
  const SelectCategorySheet({
    super.key,
    required this.transactionType,
    this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        constraints: BoxConstraints(
          maxHeight: Get.height * AppSheetHeight.threeQuarter,
          minHeight: 200,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppBorderRadius.sheetTop,
        ),

        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Header
              Column(
                children: [
                  AppGrabber(),
                  AppToolbar(
                    title: transactionType == TransactionType.earn
                        ? 'Select Income Source'
                        : 'Select Category',
                  ),
                ],
              ),

              SizedBox(height: 8),
              Flexible(
                child: CategoryList(
                  transactionType: transactionType,
                  selectedCategory: selectedCategory,
                ),
              ),

              // const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
