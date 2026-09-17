import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_category_sheet/create_category_controller.dart';
import 'package:getx_drift_app/features/transaction/category_list.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

class SelectCategorySheet extends GetView<CreateCategoryController> {
  final TransactionType transactionType;
  final CashflowCategoriesTableData? selectedCategory;
  final Set<int> excludedCategoryIds;
  const SelectCategorySheet({
    super.key,
    required this.transactionType,
    this.selectedCategory,
    this.excludedCategoryIds = const {},
  });

  @override
  String? get tag => transactionType.name;

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
                  excludedCategoryIds: excludedCategoryIds,
                  onCategorySelected: (category) {
                    Get.back<CashflowCategoriesTableData>(result: category);
                  },
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
