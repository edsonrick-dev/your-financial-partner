import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/core/constants/app_opacity.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/transaction/bill_list.dart';
import 'package:getx_drift_app/features/transaction/category_list.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';

class SelectCategoryOrBillSheet extends StatefulWidget {
  const SelectCategoryOrBillSheet({
    super.key,
    required this.transactionType,
    this.selectedCategory,
    this.selectedBill,
  });

  final TransactionType transactionType;
  final CashflowCategoriesTableData? selectedCategory;
  final BillWithNextOccurrence? selectedBill;

  @override
  State<SelectCategoryOrBillSheet> createState() =>
      _SelectCategoryOrBillSheetState();
}

class _SelectCategoryOrBillSheetState extends State<SelectCategoryOrBillSheet> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    if (widget.selectedBill != null) {
      selectedIndex = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      adaptiveHeight: true,
      title: widget.transactionType == TransactionType.earn
          ? 'Select Income Source'
          : 'Select Category or Bill',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Selector(
            selectedIndex: selectedIndex,
            onChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          const SizedBox(height: 12),

          Flexible(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                CategoryList(
                  transactionType: widget.transactionType,
                  selectedCategory: widget.selectedCategory,
                  onCategorySelected: (category) {
                    Get.back<CategoryOrBillSelection>(
                      result: CategorySelection(category),
                    );
                  },
                ),

                const BillList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Selector extends StatelessWidget {
  const _Selector({required this.selectedIndex, required this.onChanged});

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: colorScheme.appBorderMuted),
        ),
        child: Row(
          children: [
            Expanded(
              child: _SelectorItem(
                title: 'Category',
                selected: selectedIndex == 0,
                onTap: () => onChanged(0),
              ),
            ),
            Expanded(
              child: _SelectorItem(
                title: 'Bill',
                selected: selectedIndex == 1,
                onTap: () => onChanged(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectorItem extends StatelessWidget {
  const _SelectorItem({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.pageShifterFillSelected
              : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyle.titleS.copyWith(
            color: selected
                ? colorScheme.pageShifterTextSelected
                : colorScheme.pageShifterTextUnselected,
          ),
        ),
      ),
    );
  }
}
