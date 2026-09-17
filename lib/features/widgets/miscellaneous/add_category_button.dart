import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/organize_THIS/icon_selector_sheet.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_category_sheet/create_category_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/icon_picker_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

class AddCategoryButton extends GetView<CreateCategoryController> {
  final TransactionType transactionType;
  final VoidCallback? onExpand;
  final ValueChanged<CashflowCategoriesTableData>? onCategoryCreated;
  const AddCategoryButton({
    super.key,
    required this.transactionType,
    this.onExpand,
    this.onCategoryCreated,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    // Get.put(CreateCategoryController(transactionType));
    return Obx(() {
      final state = controller.buttonState.value;

      final isExpanded = state != AddButtonState.collapsed;

      return isExpanded
          ? AnimatedContainer(
              duration: Duration(milliseconds: 180),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colorScheme.appBorder),
              ),

              child: _BuildExpanded(
                controller: controller,
                onCategoryCreated: onCategoryCreated,
              ),
            )
          : _BuildCollapsed(controller: controller, onExpand: onExpand);
    });
  }
}

class _BuildExpanded extends StatelessWidget {
  const _BuildExpanded({required this.controller, this.onCategoryCreated});

  final CreateCategoryController controller;
  final ValueChanged<CashflowCategoriesTableData>? onCategoryCreated;

  @override
  Widget build(BuildContext context) {
    final state = controller.buttonState.value;

    return Column(
      spacing: 12,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Obx(
              () => AppIconPickerField(
                iconKey: controller.selectedIconKey.value,
                onTap: () {
                  Get.bottomSheet(IconSelectorSheet(controller: controller));
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
        Row(
          spacing: 8,
          children: [
            ///CANCEL BUTTON
            AdaptivePressable(
              onTap: controller.collapseButton,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: context.colors.appText),
                  borderRadius: BorderRadius.circular(8),
                ),
                height: ButtonSize.medium.height,
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Cancel', style: ButtonSize.medium.textStyle),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AdaptivePressable(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    final createdCategory = await controller.saveCategory();

                    if (createdCategory != null) {
                      onCategoryCreated?.call(createdCategory);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: context.colors.buttonBackground,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: ButtonSize.medium.height,
                    child: Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        state == AddButtonState.loading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: context.colors.surface,
                                ),
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

            ///SAVE BUTTON
            // Expanded(
            //   child: AdaptivePressable(
            //     child: GestureDetector(
            //       behavior: HitTestBehavior.opaque,
            //       onTap: () async {
            //         // final createdCategory = await controller.saveCategory();

            //         // if (createdCategory != null) {
            //         //   Get.back(result: createdCategory);
            //         // }
            //         final createdCategory = await controller.saveCategory();

            //         if (createdCategory != null) {
            //           onCategoryCreated?.call(createdCategory);
            //         }
            //       },
            //       child: Container(
            //         padding: EdgeInsets.symmetric(horizontal: 24),
            //         decoration: BoxDecoration(
            //           color: context.colors.appText,
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         height: 44,
            //         child: Row(
            //           spacing: 8,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             state == AddButtonState.loading
            //                 ? Center(
            //                     child: CircularProgressIndicator(
            //                       color: context.colors.surface,
            //                     ),
            //                   )
            //                 : Text(
            //                     'Save Category',
            //                     style: TextStyle(color: context.colors.surface),
            //                   ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}

class _BuildCollapsed extends StatelessWidget {
  final CreateCategoryController controller;
  final VoidCallback? onExpand;
  const _BuildCollapsed({required this.controller, this.onExpand});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      size: ButtonSize.xLarge,
      type: ButtonType.outline,
      text: 'Add new category',
      onTap: () {
        controller.expandButton();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onExpand?.call();
        });
      },
      leadingIcon: Icons.add,
    );
  }
}
