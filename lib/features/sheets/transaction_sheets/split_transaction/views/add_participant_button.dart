import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AddParticipantButton extends GetView<TransactionController> {
  const AddParticipantButton({super.key, this.onExpand});
  final VoidCallback? onExpand;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: GestureDetector(
        onTap: () async {
          // final person = await AppSheets.selection.selectExpenseParticipant();/
          final person = await AppSheets.selection.selectTransactionParticipant(
            excludedPersonIds: controller.participants
                .map((participant) => participant.entityId)
                .toList(),
          );

          if (person == null) return;

          /// Prevent duplicates
          final alreadyExists = controller.participants.any(
            (participant) => participant.entityId == person.id,
          );

          if (alreadyExists) return;

          controller.addParticipant(entityId: person.id, name: person.name);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onExpand?.call();
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.appText),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(width: 12),
              const Text('Add Participant'),
            ],
          ),
        ),
      ),
    );
  }
}
