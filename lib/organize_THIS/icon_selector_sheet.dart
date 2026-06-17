import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_category_sheet/create_category_controller.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';

class IconSelectorSheet extends StatelessWidget {
  const IconSelectorSheet({super.key, required this.controller});

  final CreateCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(38),
        color: Colors.white,
      ),
      height: 400,

      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: AppIcons.categories.availableIcons.length,
        itemBuilder: (context, index) {
          final item = AppIcons.categories.availableIcons[index];

          return GestureDetector(
            onTap: () {
              //! INCLUDE THIS IN CONTROLLER OF PARENT WIDGET
              //! void selectIcon(String iconKey) {selectedIconKey.value = iconKey;}
              controller.selectIcon(item.key);
              Get.back();
            },
            child: SizedBox(width: 44, height: 44, child: Icon(item.icon)),
          );
        },
      ),
    );
  }
}
