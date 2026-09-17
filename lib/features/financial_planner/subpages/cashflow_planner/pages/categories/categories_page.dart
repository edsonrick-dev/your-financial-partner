import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/categories/category_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class CategoriesPage extends GetView<CategoryController> {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    // bool showIncome = controller.selectedCategoryTypeIndex.value == 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          AppSection(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorScheme.bgLight,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: colorScheme.appBorderMuted),
              ),
              child: Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: AdaptivePressable(
                        onTap: () {
                          controller.selectedCategoryTypeIndex.value = 0;
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                controller.selectedCategoryTypeIndex.value == 0
                                ? colorScheme.pageShifterFillSelected
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Income',
                                style:
                                    controller
                                            .selectedCategoryTypeIndex
                                            .value ==
                                        0
                                    ? AppTextStyle.bodyM.copyWith(
                                        color:
                                            colorScheme.pageShifterTextSelected,
                                        // fontWeight: FontWeight.w600,
                                      )
                                    : AppTextStyle.titleM.copyWith(
                                        color: colorScheme
                                            .pageShifterTextUnselected,
                                        // fontWeight: FontWeight.w400,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: AdaptivePressable(
                        onTap: () {
                          controller.selectedCategoryTypeIndex.value = 1;
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                controller.selectedCategoryTypeIndex.value == 1
                                ? colorScheme.pageShifterFillSelected
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Expense',
                                style:
                                    controller
                                            .selectedCategoryTypeIndex
                                            .value ==
                                        1
                                    ? AppTextStyle.bodyM.copyWith(
                                        color:
                                            colorScheme.pageShifterTextSelected,
                                        // fontWeight: FontWeight.w600,
                                      )
                                    : AppTextStyle.titleM.copyWith(
                                        color: colorScheme
                                            .pageShifterTextUnselected,
                                        // fontWeight: FontWeight.w400,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              final showIncome =
                  controller.selectedCategoryTypeIndex.value == 0;

              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final categories = showIncome
                  ? controller.incomeCategories
                  : controller.expenseCategories;

              if (categories.isEmpty) {
                return const Center(child: Text('No categories yet'));
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _CategorySection(
                    categories: categories,
                    onEdit: controller.openEditCategory,
                    onDelete: controller.confirmDeleteCategory,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.categories,
    required this.onEdit,
    required this.onDelete,
  });

  final List<CashflowCategoriesTableData> categories;
  final void Function(CashflowCategoriesTableData category) onEdit;
  final void Function(CashflowCategoriesTableData category) onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(title, style: Theme.of(context).textTheme.titleMedium),
        // const SizedBox(height: 8),
        ...categories.map((category) {
          return AppCard(
            onTap: () {
              onEdit(category);
            },
            child: Row(
              children: [
                Icon(AppIcons.categories.resolve(category.icon)),
                SizedBox(width: 16),
                Text(category.name),
              ],
            ),
          );

          // ListTile(
          //   contentPadding: EdgeInsets.zero,
          //   title: Text(category.name),
          //   trailing: PopupMenuButton<String>(
          //     onSelected: (value) {
          //       switch (value) {
          //         case 'edit':
          //           onEdit(category);
          //           break;

          //         case 'delete':
          //           onDelete(category);
          //           break;
          //       }
          //     },
          //     itemBuilder: (_) => const [
          //       PopupMenuItem(value: 'edit', child: Text('Edit')),
          //       PopupMenuItem(value: 'delete', child: Text('Delete')),
          //     ],
          //   ),
          // );
        }),
        SizedBox(height: context.bottomPaddingSub),
      ],
    );
  }
}
