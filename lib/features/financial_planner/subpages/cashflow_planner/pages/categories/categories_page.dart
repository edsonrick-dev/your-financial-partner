import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/adaptive_pressable.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/categories/category_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/categories/create_category_sheet.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/design_system/shifters/segment_shifter/app_segmented_selector.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CategoriesPage extends GetView<CategoryController> {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.colors;
    // bool showIncome = controller.selectedCategoryTypeIndex.value == 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        surfaceTintColor: Colors.transparent,
        actions: [
          AdaptivePressable(
            onTap: () {
              Get.bottomSheet(
                CreateCategorySheet(
                  type: controller.selectedCategoryTypeIndex.value == 0
                      ? TransactionType.earn
                      : TransactionType.spend,
                ),
                isScrollControlled: true,
              );
            },
            child: SizedBox(
              height: 44,
              width: 44,
              child: Icon(PhosphorIconsRegular.plus),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          AppSection(
            child: Obx(
              () => AppSegmentedSelector(
                items: const ['Income', 'Expense'],
                selectedIndex: controller.selectedCategoryTypeIndex.value,
                onChanged: (index) {
                  controller.selectedCategoryTypeIndex.value = index;
                },
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
              final archivedCategories = showIncome
                  ? controller.archivedIncomeCategories
                  : controller.archivedExpenseCategories;

              if (categories.isEmpty && archivedCategories.isEmpty) {
                return const Center(child: Text('No categories yet'));
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (categories.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: Text('No active categories')),
                    )
                  else
                    _CategorySection(
                      categories: categories,
                      onEdit: _editCategory,
                      onArchive: controller.confirmArchiveCategory,
                      isArchived: false,
                    ),
                  if (archivedCategories.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(
                      'Archived',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    _CategorySection(
                      categories: archivedCategories,
                      onEdit: _editCategory,
                      onArchive: controller.restoreCategory,
                      isArchived: true,
                    ),
                  ],
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  void _editCategory(CashflowCategoriesTableData category) {
    final type = category.type == 'earn'
        ? TransactionType.earn
        : TransactionType.spend;

    Get.bottomSheet(
      CreateCategorySheet(type: type, category: category),
      isScrollControlled: true,
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.categories,
    required this.onEdit,
    required this.onArchive,
    required this.isArchived,
  });

  final List<CashflowCategoriesTableData> categories;
  final void Function(CashflowCategoriesTableData category) onEdit;
  final void Function(CashflowCategoriesTableData category) onArchive;
  final bool isArchived;

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
            onTap: category.isSystem ? null : () => onEdit(category),
            child: Row(
              children: [
                Opacity(
                  opacity: isArchived ? 0.55 : 1,
                  child: Icon(AppIcons.categories.resolve(category.icon)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(category.name),
                      if (category.isSystem)
                        Text(
                          'System category',
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      else if (isArchived)
                        Text(
                          'Archived',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                    ],
                  ),
                ),
                if (category.isSystem)
                  const Tooltip(
                    message: 'Required for insurance premium planning',
                    child: Icon(Icons.lock_outline),
                  )
                else
                  Tooltip(
                    message: isArchived
                        ? 'Restore category'
                        : 'Archive category',
                    child: IconButton(
                      onPressed: () => onArchive(category),
                      icon: Icon(isArchived ? Icons.unarchive : Icons.archive),
                    ),
                  ),
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
