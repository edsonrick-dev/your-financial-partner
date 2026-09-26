import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/icons/icon_selector_sheet.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/categories/category_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_category_sheet/create_category_controller.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/widgets/fields/icon_picker_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class CreateCategorySheet extends StatelessWidget {
  const CreateCategorySheet({super.key, required this.type, this.category});

  final TransactionType type;
  final CashflowCategoriesTableData? category;

  bool get isEditing => category != null;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CreateCategoryController(type, category: category),
    );

    return AppSheet(
      adaptiveHeight: true,
      minHeightFactor: AppSheetHeight.quarter,
      title: isEditing ? 'Edit Category' : 'New Category',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSection(
            child: Column(
              spacing: 12,
              children: [
                Row(
                  children: [
                    Obx(
                      () => AppIconPickerField(
                        iconKey: controller.selectedIconKey.value,
                        onTap: () {
                          Get.bottomSheet(
                            CategoryIconSelector(controller: controller),
                            isScrollControlled: true,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: AppTextField(
                        label: 'Name',
                        focusNode: controller.nameFocusNode,
                        controller: controller.nameController,
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => AdaptivePressable(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        final createdCategory = await controller.saveCategory();

                        if (createdCategory == null) {
                          return;
                        }

                        await Get.find<CategoryController>().loadCategories();

                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: context.colors.buttonBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: ButtonSize.medium.height,
                        child: Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            controller.buttonState.value ==
                                    AddButtonState.loading
                                ? CircularProgressIndicator(
                                    color: context.colors.surface,
                                  )
                                : Text(
                                    'Save category',
                                    style: ButtonSize.medium.textStyle.copyWith(
                                      color: context.colors.surface,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: context.bottomPadding),
        ],
      ),
    );
  }
}
