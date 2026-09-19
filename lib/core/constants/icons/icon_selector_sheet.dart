import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_category_sheet/create_category_controller.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class CategoryIconSelector extends StatelessWidget {
  const CategoryIconSelector({super.key, required this.controller});

  final CreateCategoryController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSheet(
      height: AppSheetHeight.half,
      title: 'Select Category',
      child: GridView.builder(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: context.bottomPaddingSub,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: AppIcons.categories.availableIcons.length,
        itemBuilder: (context, index) {
          final item = AppIcons.categories.availableIcons[index];

          return AdaptivePressable(
            onTap: () {
              //! INCLUDE THIS IN CONTROLLER OF PARENT WIDGET
              //! void selectIcon(String iconKey) {selectedIconKey.value = iconKey;}
              controller.selectIcon(item.key);
              Get.back();
            },
            child: Container(
              alignment: Alignment.center,
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: colorScheme.bgLight,
                shape: BoxShape.circle,
                boxShadow: AppShadows.card(colorScheme.appTextMuted),
              ),
              child: Icon(item.icon),
            ),
          );
        },
      ),
    );
  }
}
