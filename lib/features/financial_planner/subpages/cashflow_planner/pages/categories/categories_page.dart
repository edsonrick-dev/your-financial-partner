import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/categories/category_controller.dart';

class CategoriesPage extends GetView<CategoryController> {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.openCreateCategory,
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.categories.isEmpty) {
          return const Center(child: Text('No categories yet'));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _CategorySection(
              title: 'Income',
              categories: controller.incomeCategories,
              onEdit: controller.openEditCategory,
              onDelete: controller.confirmDeleteCategory,
            ),
            const SizedBox(height: 24),
            _CategorySection(
              title: 'Expenses',
              categories: controller.expenseCategories,
              onEdit: controller.openEditCategory,
              onDelete: controller.confirmDeleteCategory,
            ),
          ],
        );
      }),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.title,
    required this.categories,
    required this.onEdit,
    required this.onDelete,
  });

  final String title;
  final List<CashflowCategoriesTableData> categories;
  final void Function(CashflowCategoriesTableData category) onEdit;
  final void Function(CashflowCategoriesTableData category) onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),

        ...categories.map((category) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(category.name),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    onEdit(category);
                    break;

                  case 'delete':
                    onDelete(category);
                    break;
                }
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          );
        }),
      ],
    );
  }
}
