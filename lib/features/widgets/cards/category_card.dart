import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class CategoryCard extends StatelessWidget {
  final CashflowCategoriesTableData category;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppCard(
      padding: 0,
      onTap: onTap,
      // behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Icon(AppIcons.categories.resolve(category.icon), size: 16),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.titleL,
              ),
            ),

            if (isSelected) ...[
              const SizedBox(width: 12),

              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.appAccent,
                ),
                child: const Icon(Icons.check, size: 10, color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// class _CategoryCardState extends State<CategoryCard> {
//   bool _isPressed = false;

//   void _setPressed(bool value) {
//     if (_isPressed == value) return;

//     setState(() {
//       _isPressed = value;
//     });
//   }

//   }
