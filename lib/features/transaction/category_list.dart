import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_category_sheet/create_category_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/category_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/add_category_button.dart';

class CategoryList extends StatelessWidget {
  final TransactionType transactionType;
  final CashflowCategoriesTableData? selectedCategory;

  CategoryList({
    super.key,
    required this.transactionType,
    this.selectedCategory,
  });
  late final CreateCategoryController controller = Get.put(
    CreateCategoryController(transactionType),
  );
  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.colors;
    return StreamBuilder(
      stream: database.watchCategoriesByType(
        transactionType == TransactionType.earn
            ? TransactionType.earn.name
            : TransactionType.spend.name,
      ),

      builder: (context, snapshot) {
        /// LOADING

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        /// ERROR

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final categories = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),

          itemCount: categories.length + 1,

          itemBuilder: (context, index) {
            /// LAST ITEM
            /// ADD CATEGORY BUTTON

            if (index == categories.length) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 36),

                child: Column(
                  spacing: 12,
                  children: [
                    AddCategoryButton(transactionType: transactionType),
                    // AddCategoryButton1(),
                  ],
                ),
              );
            }

            /// CATEGORY ITEM

            final category = categories[index];

            final isSelected = selectedCategory?.id == category.id;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),

              child: CategoryCard(
                category: category,
                isSelected: isSelected,
                onTap: () {
                  Get.back(result: category);
                },
              ),
            );
          },
        );
      },
    );
  }
}
