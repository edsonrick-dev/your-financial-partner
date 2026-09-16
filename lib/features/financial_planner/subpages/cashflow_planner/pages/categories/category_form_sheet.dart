import 'package:flutter/material.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class CategoryFormSheet extends StatefulWidget {
  const CategoryFormSheet({super.key, this.category, required this.onSave});

  final CashflowCategoriesTableData? category;

  final Future<void> Function(String name, String icon, String type) onSave;

  bool get isEditing => category != null;

  @override
  State<CategoryFormSheet> createState() => _CategoryFormSheetState();
}

class _CategoryFormSheetState extends State<CategoryFormSheet> {
  late final TextEditingController nameController;

  late String selectedType;
  late String selectedIcon;

  bool isSaving = false;

  final icons = const [
    'food',
    'transport',
    'shopping',
    'home',
    'health',
    'education',
    'entertainment',
    'salary',
    'business',
    'other',
  ];

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.category?.name ?? '');

    selectedType = widget.category?.type ?? 'expense';
    selectedIcon = widget.category?.icon ?? 'other';
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> save() async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter a category name.')));
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      await widget.onSave(name, selectedIcon, selectedType);
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isEditing ? 'Edit Category' : 'Create Category',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 24),

              TextField(
                controller: nameController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Category name',
                  hintText: 'e.g. Groceries',
                ),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: selectedType,
                decoration: const InputDecoration(labelText: 'Type'),
                items: const [
                  DropdownMenuItem(value: 'earn', child: Text('Income')),
                  DropdownMenuItem(value: 'spend', child: Text('Expense')),
                ],
                onChanged: isSaving
                    ? null
                    : (value) {
                        if (value == null) return;

                        setState(() {
                          selectedType = value;
                        });
                      },
              ),

              const SizedBox(height: 20),

              Text('Icon', style: Theme.of(context).textTheme.titleSmall),

              const SizedBox(height: 8),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: icons.map((icon) {
                  final isSelected = selectedIcon == icon;

                  return ChoiceChip(
                    label: Text(icon),
                    selected: isSelected,
                    onSelected: isSaving
                        ? null
                        : (_) {
                            setState(() {
                              selectedIcon = icon;
                            });
                          },
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: isSaving ? null : save,
                  child: isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          widget.isEditing ? 'Save Changes' : 'Create Category',
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
