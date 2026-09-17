import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_category_sheet/create_category_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/category_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/add_category_button.dart';

class CategoryList extends GetView<CreateCategoryController> {
  final TransactionType transactionType;
  final CashflowCategoriesTableData? selectedCategory;
  final Set<int> excludedCategoryIds;

  final ValueChanged<CashflowCategoriesTableData> onCategorySelected;

  const CategoryList({
    super.key,
    required this.transactionType,
    required this.onCategorySelected,
    this.selectedCategory,
    this.excludedCategoryIds = const {},
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: database.categoryDao.watchCategoriesByType(
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

        // final categories = snapshot.data!;
        final allCategories = snapshot.data!;

        final categories = allCategories
            .where((category) => !excludedCategoryIds.contains(category.id))
            .toList();

        final categoryType = transactionType == TransactionType.earn
            ? 'income'
            : 'spending';

        if (categories.isEmpty) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      allCategories.isEmpty
                          ? 'You have no $categoryType categories'
                          : 'You have planned for all $categoryType categories already',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 36),
                child: AddCategoryButton(
                  transactionType: transactionType,
                  onExpand: controller.scrollToAddCategory,
                  onCategoryCreated: onCategorySelected,
                ),
              ),
            ],
          );
        }
        return ListView.builder(
          controller: controller.scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: categories.length + 1,
          itemBuilder: (context, index) {
            /// LAST ITEM
            /// ADD CATEGORY BUTTON
            if (index == categories.length) {
              return Column(
                spacing: 12,
                children: [
                  AddCategoryButton(
                    transactionType: transactionType,
                    onExpand: controller.scrollToAddCategory,
                    onCategoryCreated: onCategorySelected,
                  ),
                  SizedBox(height: context.bottomPaddingSub),
                ],
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
                  onCategorySelected(category);
                },
                // onTap: () {
                //   Get.back<CategoryOrBillSelection>(
                //     result: CategorySelection(category),
                //   );
                // },
              ),
            );
          },
        );
      },
    );
  }
}

// class _CategoryListState extends State<CategoryList> {
//   final ScrollController _scrollController = ScrollController();

//   late final CreateCategoryController controller = Get.put(
//     CreateCategoryController(widget.transactionType),
//   );

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _scrollToAddCategory() {
//     if (!_scrollController.hasClients) return;

//     _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
//       duration: const Duration(milliseconds: 350),
//       curve: Curves.easeOutCubic,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: database.categoryDao.watchCategoriesByType(
//         widget.transactionType == TransactionType.earn
//             ? TransactionType.earn.name
//             : TransactionType.spend.name,
//       ),
//       builder: (context, snapshot) {
//         /// LOADING
//         if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         /// ERROR
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }

//         // final categories = snapshot.data!;
//         final allCategories = snapshot.data!;

//         final categories = allCategories
//             .where(
//               (category) => !widget.excludedCategoryIds.contains(category.id),
//             )
//             .toList();

//         final categoryType = widget.transactionType == TransactionType.earn
//             ? 'income'
//             : 'spending';

//         if (categories.isEmpty) {
//           return Column(
//             children: [
//               Expanded(
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(24),
//                     child: Text(
//                       allCategories.isEmpty
//                           ? 'You have no $categoryType categories'
//                           : 'You have planned for all $categoryType categories already',
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(16, 0, 16, 36),
//                 child: AddCategoryButton(
//                   transactionType: widget.transactionType,
//                   onExpand: _scrollToAddCategory,
//                   onCategoryCreated: widget.onCategorySelected,
//                 ),
//               ),
//             ],
//           );
//         }
//         return ListView.builder(
//           controller: _scrollController,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           itemCount: categories.length + 1,
//           itemBuilder: (context, index) {
//             /// LAST ITEM
//             /// ADD CATEGORY BUTTON
//             if (index == categories.length) {
//               return Column(
//                 spacing: 12,
//                 children: [
//                   AddCategoryButton(
//                     transactionType: widget.transactionType,
//                     onExpand: _scrollToAddCategory,
//                   ),
//                   SizedBox(height: context.bottomPaddingSub),
//                 ],
//               );
//             }

//             /// CATEGORY ITEM
//             final category = categories[index];

//             final isSelected = widget.selectedCategory?.id == category.id;

//             return Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: CategoryCard(
//                 category: category,
//                 isSelected: isSelected,
//                 onTap: () {
//                   widget.onCategorySelected(category);
//                 },
//                 // onTap: () {
//                 //   Get.back<CategoryOrBillSelection>(
//                 //     result: CategorySelection(category),
//                 //   );
//                 // },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
