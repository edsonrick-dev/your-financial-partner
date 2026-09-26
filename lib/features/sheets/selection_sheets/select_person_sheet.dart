import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/widgets/cards/person_card.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/data/enums/entity_type_enum.dart';

import 'package:drift/drift.dart' as d;

class SelectPersonSheet extends GetView<CreateEntityController> {
  final EntitiesTableData? selectedPerson;
  final List<int> excludedPersonIds;
  const SelectPersonSheet({
    super.key,
    this.selectedPerson,
    this.excludedPersonIds = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      title: 'Choose Person',
      child: StreamBuilder(
        stream: database.entitiesDao.watchEntitiesByType(
          EntityType.person.name,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Column(
              children: [
                const Text('No Person Found'),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AddPersonButton(),
                ),
              ],
            );
          }

          final persons = (snapshot.data ?? [])
              .where((person) => !excludedPersonIds.contains(person.id))
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: persons.length + 1,
            itemBuilder: (context, index) {
              if (index == persons.length) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 36),
                  child: AddPersonButton(
                    onExpand: controller.scrollToAddPerson,
                  ),
                );
              }

              final person = persons[index];
              final isSelected = selectedPerson?.id == person.id;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),

                child: PersonCard(
                  person: person,
                  isSelected: isSelected,
                  onTap: () {
                    Get.back(result: person);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AddPersonButton extends GetView<CreateEntityController> {
  final VoidCallback? onExpand;
  const AddPersonButton({super.key, this.onExpand});
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(() {
      final state = controller.buttonState.value;
      final isExpanded = state != AddButtonState.collapsed;
      return isExpanded
          ? AnimatedContainer(
              duration: Duration(milliseconds: 180),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colorScheme.appBorder),
              ),

              child: _BuildExpanded(controller: controller),
            )
          : _BuildCollapsed(controller: controller, onExpand: onExpand);
      // return isExpanded
      //     ? Container(
      //         padding: isExpanded
      //             ? const EdgeInsets.all(12)
      //             : const EdgeInsets.all(0),
      //         decoration: BoxDecoration(
      //           color: isExpanded ? colorScheme.bgLight : Colors.transparent,
      //           borderRadius: BorderRadius.circular(isExpanded ? 20 : 12),
      //           border: Border.all(color: colorScheme.appBorder),
      //         ),

      //         child: isExpanded
      //             ? _BuildExpanded(controller: controller)
      //             : _BuildCollapsed(controller: controller),
      //       )
      //     : _BuildCollapsed(controller: controller);
    });
  }
}

class CreateEntityController extends GetxController {
  final Rx<AddButtonState> buttonState = AddButtonState.collapsed.obs;
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToAddPerson() {
    if (!_scrollController.hasClients) return;

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void expandButton() {
    buttonState.value = AddButtonState.expanded;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isClosed) return;

      nameFocusNode.requestFocus();
    });
  }

  void collapseButton() {
    buttonState.value = AddButtonState.collapsed;
  }

  Future<EntitiesTableData?> savePerson() async {
    final name = nameController.text.trim();

    if (name.isEmpty) return null;

    try {
      buttonState.value = AddButtonState.loading;

      final insertedId = await database.entitiesDao.insertEntity(
        EntitiesTableCompanion.insert(
          name: name,
          entityType: EntityType.person.name,
          isSystem: const d.Value(false),
        ),
      );

      final createdPerson = await database.entitiesDao.getEntityById(
        insertedId,
      );

      nameController.clear();

      collapseButton();

      return createdPerson;
    } finally {
      buttonState.value = AddButtonState.collapsed;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    nameFocusNode.dispose();

    super.onClose();
  }
}

class _BuildExpanded extends StatelessWidget {
  const _BuildExpanded({required this.controller});

  final CreateEntityController controller;

  @override
  Widget build(BuildContext context) {
    final state = controller.buttonState.value;
    // final colorScheme = context.colors;
    return Column(
      spacing: 12,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextField(
          label: 'Name',
          controller: controller.nameController,
          focusNode: controller.nameFocusNode,
        ),

        Row(
          spacing: 8,
          children: [
            ///CANCEL BUTTON
            AdaptivePressable(
              onTap: controller.collapseButton,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: context.colors.appText),
                  borderRadius: BorderRadius.circular(8),
                ),
                height: ButtonSize.medium.height,
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Cancel', style: ButtonSize.medium.textStyle),
                  ],
                ),
              ),
            ),

            ///SAVE BUTTON
            Expanded(
              child: AdaptivePressable(
                onTap: () async {
                  final createPerson = await controller.savePerson();

                  if (createPerson != null) {
                    Get.back(result: createPerson);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: context.colors.buttonBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: ButtonSize.medium.height,
                  child: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state == AddButtonState.loading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: context.colors.surface,
                              ),
                            )
                          : Text(
                              'Save Person',
                              style: ButtonSize.medium.textStyle.copyWith(
                                color: context.colors.surface,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BuildCollapsed extends StatelessWidget {
  final CreateEntityController controller;
  final VoidCallback? onExpand;
  const _BuildCollapsed({required this.controller, this.onExpand});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      size: ButtonSize.xLarge,
      type: ButtonType.outline,
      leadingIcon: Icons.add,
      text: 'Add new person',
      onTap: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onExpand?.call();
        });

        controller.expandButton();
      },
    );
  }
}
