import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/data/models/participant_model.dart';
import 'package:getx_drift_app/data/enums/split_mode_enum.dart';

extension SplitTransactionController on TransactionController {
  Future<void> loadCurrentUserEntity() async {
    final me = await database.entitiesDao.getCurrentUserEntity();

    currentUserEntityId.value = me?.id;
  }

  double get myExpenseShare {
    final me = participants.firstWhereOrNull(
      (participant) => participant.entityId == currentUserEntityId.value,
    );

    return me?.amount.value ?? 0;
  }

  void syncTextController(ParticipantModel participant) {
    switch (splitMode.value) {
      case SplitMode.equal:
      case SplitMode.custom:
        participant.textController.text = participant.amount.value
            .toStringAsFixed(2);
        break;

      case SplitMode.percentage:
        participant.textController.text = (participant.percentage.value * 100)
            .toStringAsFixed(2);
        break;
    }
  }

  void updateParticipantAmount({
    required ParticipantModel participant,
    required double amount,
  }) {
    participant.amount.value = amount;

    syncPercentageFromAmount(participant);
    // syncTextController(participant);
    participants.refresh();
  }

  void updateParticipantPercentage({
    required ParticipantModel participant,
    required double percentage,
  }) {
    participant.percentage.value = percentage;

    syncAmountFromPercentage(participant);
    // syncTextController(participant);
    participants.refresh();
  }

  void removeParticipant(int entityId) {
    participants.removeWhere((participant) => participant.entityId == entityId);

    recalculateParticipants();
  }
}
