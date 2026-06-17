import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/organize_THIS/icon_selector_sheet.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_category_sheet/create_category_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/icon_picker_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

class AddCategoryButton extends GetView<CreateCategoryController> {
  final TransactionType transactionType;
  const AddCategoryButton({super.key, required this.transactionType});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    Get.put(CreateCategoryController(transactionType));
    return Obx(() {
      final state = controller.buttonState.value;

      final isExpanded = state != AddButtonState.collapsed;

      return AnimatedContainer(
        duration: Duration(milliseconds: 180),

        padding: isExpanded
            ? const EdgeInsets.all(12)
            : const EdgeInsets.all(0),
        decoration: BoxDecoration(
          // color: isExpanded ? colorScheme.secondaryBg : Colors.transparent,
          borderRadius: BorderRadius.circular(isExpanded ? 20 : 12),
          border: Border.all(color: colorScheme.appBorder),
        ),

        child: isExpanded
            ? _BuildExpanded(controller: controller)
            : _BuildCollapsed(controller: controller),
      );
    });
  }
}

class _BuildExpanded extends StatelessWidget {
  const _BuildExpanded({required this.controller});

  final CreateCategoryController controller;

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
            GestureDetector(
              onTap: controller.collapseButton,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  // color: colorScheme.text,
                  border: Border.all(color: context.colors.appText),
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 44,
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Cancel', style: TextStyle())],
                ),
              ),
            ),

            ///SAVE BUTTON
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  final createdCategory = await controller.saveCategory();

                  if (createdCategory != null) {
                    Get.back(result: createdCategory);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: context.colors.appText,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 44,
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
                              'Save Category',
                              style: TextStyle(color: context.colors.surface),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BuildCollapsed extends StatelessWidget {
  final CreateCategoryController controller;
  const _BuildCollapsed({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: controller.expandButton,
      child: SizedBox(
        height: 52,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('Add New Category'),
          ],
        ),
      ),
    );
  }
}
