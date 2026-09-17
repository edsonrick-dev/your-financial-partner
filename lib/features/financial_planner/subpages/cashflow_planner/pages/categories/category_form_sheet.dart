import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_category_sheet/create_category_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class CategoryFormSheet extends GetView<CreateCategoryController> {
  final CashflowCategoriesTableData? category;
  const CategoryFormSheet({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      adaptiveHeight: true,
      title: category?.name ?? 'New Category',
      child: AppSection(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //   const SizedBox(height: 24),
            AppTextField(
              label: 'Name',
              focusNode: controller.nameFocusNode,
              controller: controller.nameController,
            ),
            //   TextField(
            //     controller: controller.nameController,
            //     focusNode: controller.nameFocusNode,
            //     decoration: const InputDecoration(
            //       labelText: 'Category name',
            //       hintText: 'e.g. Groceries',
            //     ),
            //   ),

            //   const SizedBox(height: 16),

            //   Obx(
            //     () => DropdownButtonFormField<TransactionType>(
            //       initialValue: controller.categoryType.value,
            //       decoration: const InputDecoration(labelText: 'Type'),
            //       items: const [
            //         DropdownMenuItem(
            //           value: TransactionType.earn,
            //           child: Text('Income'),
            //         ),
            //         DropdownMenuItem(
            //           value: TransactionType.spend,
            //           child: Text('Expense'),
            //         ),
            //       ],
            //       onChanged: (value) {
            //         if (value != null) {
            //           controller.selectCategoryType(value);
            //         }
            //       },
            //     ),
            //   ),

            //   const SizedBox(height: 20),

            //   Text('Icon', style: Theme.of(context).textTheme.titleSmall),

            //   const SizedBox(height: 8),

            //   Obx(
            //     () => Wrap(
            //       spacing: 8,
            //       runSpacing: 8,
            //       children: CreateCategoryController.icons.map((icon) {
            //         return ChoiceChip(
            //           label: Text(icon),
            //           selected: controller.selectedIconKey.value == icon,
            //           onSelected: (_) {
            //             controller.selectIcon(icon);
            //           },
            //         );
            //       }).toList(),
            //     ),
            //   ),

            //   const SizedBox(height: 24),

            //   SizedBox(
            //     width: double.infinity,
            //     child: FilledButton(
            //       onPressed: controller.saveCategory,
            //       child: const Text('Create Category'),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
