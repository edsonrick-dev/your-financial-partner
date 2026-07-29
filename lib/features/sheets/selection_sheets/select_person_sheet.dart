import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
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
                  child: AddPersonButton(),
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
  const AddPersonButton({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(() {
      final state = controller.buttonState.value;
      final isExpanded = state != AddButtonState.collapsed;
      return Container(
        padding: isExpanded
            ? const EdgeInsets.all(12)
            : const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: isExpanded ? colorScheme.bgLight : Colors.transparent,
          borderRadius: BorderRadius.circular(isExpanded ? 20 : 12),
          border: Border.all(color: colorScheme.appBorder),
        ),

        child: isExpanded
            ? _BuildExpanded(controller: controller)
            : _BuildCollapsed(controller: controller),
      );
    });
  }
}

class CreateEntityController extends GetxController {
  final Rx<AddButtonState> buttonState = AddButtonState.collapsed.obs;
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
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
        // Row(
        //   children: [
        //     Expanded(
        //       child: Container(
        //         height: 60,
        //         padding: const EdgeInsets.symmetric(
        //           horizontal: 12,
        //           vertical: 8,
        //         ),
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           border: Border.all(color: colorScheme.border),
        //           borderRadius: BorderRadius.circular(8),
        //         ),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               'Name',
        //               style: TextStyle(
        //                 fontSize: 15,
        //                 height: 20 / 15,
        //                 color: Colors.black54,
        //               ),
        //             ),

        //             TextField(
        //               controller: controller.nameController,
        //               maxLines: 1,
        //               textAlignVertical: TextAlignVertical.center,
        //               style: const TextStyle(fontSize: 17, height: 20 / 17),
        //               decoration: const InputDecoration(
        //                 hintText: '''Person's Name''',
        //                 border: InputBorder.none,

        //                 isDense: true,

        //                 contentPadding: EdgeInsets.zero,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        Row(
          spacing: 8,
          children: [
            ///CANCEL BUTTON
            GestureDetector(
              onTap: controller.collapseButton,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  // color: colorScheme.text,
                  border: Border.all(color: context.colors.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 44,
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Cancel', style: TextStyle())],
                ),
              ),
            ),

            ///SAVE BUTTON
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  final createPerson = await controller.savePerson();

                  if (createPerson != null) {
                    Get.back(result: createPerson);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 44,
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
                              style: TextStyle(color: context.colors.surface),
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
  const _BuildCollapsed({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: controller.expandButton,
      child: SizedBox(
        height: 52,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('Add New Person'),
          ],
        ),
      ),
    );
  }
}
