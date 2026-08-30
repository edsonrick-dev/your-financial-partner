import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/domain/app_calculator.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/split_transaction_ext.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/enums/split_mode_enum.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/participant_model.dart';

class ParticipantCard extends GetView<TransactionController> {
  final ParticipantModel participant;

  final int index;

  const ParticipantCard({
    super.key,
    required this.participant,
    required this.index,
  });
  String participantValue(ParticipantModel participant) {
    switch (controller.splitMode.value) {
      case SplitMode.custom:
      case SplitMode.equal:
        return participant.amount.value.toCurrency();

      case SplitMode.percentage:
        return '${(participant.percentage.value * 100).toStringAsFixed(2)}%';

      // case SplitMode.custom:
      //   final total = controller.amount.value;

      //   if (total == 0) return '0%';

      //   final percentage = participant.amount.value / total * 100;

      //   return '${percentage.toStringAsFixed(2)}%';
    }
  }

  Future<void> _openCalculator(BuildContext context) async {
    final calculatorController = Get.find<AppCalculatorController>();

    final mode = controller.splitMode.value;

    final originalValue = mode == SplitMode.percentage
        ? participant.percentage.value * 100
        : participant.amount.value;

    calculatorController.initialize(originalValue);

    final result = await Get.bottomSheet<double>(
      const AppCalculator(),
      isScrollControlled: true,
    );

    if (result == null) return;

    if (mode == SplitMode.percentage) {
      controller.updateParticipantPercentage(
        participant: participant,
        percentage: result / 100,
      );
      return;
    }

    if (mode == SplitMode.equal) {
      controller.updateParticipantAmount(
        participant: participant,
        amount: result,
      );

      // Manual change breaks equal split.
      if ((result - originalValue).abs() >= 0.01) {
        controller.splitMode.value = SplitMode.custom;
        controller.recalculateParticipants();
      }

      return;
    }

    // Custom
    controller.updateParticipantAmount(
      participant: participant,
      amount: result,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final isMe = participant.entityId == controller.currentUserEntityId.value;

    return Obx(() {
      final isActive = participant.isActive.value;

      return AdaptivePressable(
        onTap: () => _openCalculator(context),
        onLongPress: isMe
            ? null
            : () async {
                final shouldDelete = await Get.dialog<bool>(
                  AlertDialog(
                    title: const Text('Remove participant?'),
                    content: Text(
                      'Remove ${participant.name} from this expense split?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(result: false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Get.back(result: true),
                        child: const Text('Remove'),
                      ),
                    ],
                  ),
                );

                if (shouldDelete != true) return;

                controller.removeParticipant(participant.entityId);

                if (controller.splitMode.value == SplitMode.equal) {
                  controller.recalculateEqualSplit();
                }
              },

        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? colorScheme.bgLight : Colors.transparent,
            ),
            color: isActive ? colorScheme.bgLight : Colors.transparent,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: colorScheme.appText,
                child: Text(participant.name[0].toUpperCase()),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      participant.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),

                    Obx(() {
                      return controller.splitMode.value == SplitMode.percentage
                          ? Text(
                              (participant.amount.value).toCurrency(),
                              style: const TextStyle(fontSize: 12),
                            )
                          : Text(
                              '${(participant.percentage.value * 100).toStringAsFixed(2)}%',
                              style: const TextStyle(fontSize: 12),
                            );
                    }),
                  ],
                ),
              ),
              Text(
                participantValue(participant),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
