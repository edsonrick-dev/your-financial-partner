import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/participant_card.dart';

class ParticipantList extends GetView<TransactionController> {
  const ParticipantList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(() {
      if (controller.participants.isEmpty) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.appBorder),
          ),
          child: const Center(child: Text('No participants added')),
        );
      }

      return Column(
        children: List.generate(controller.sortedParticipants.length, (index) {
          final participant = controller.sortedParticipants[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ParticipantCard(participant: participant, index: index),
          );
        }),
      );
    });
  }
}
