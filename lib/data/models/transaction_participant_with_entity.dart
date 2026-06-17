import 'package:getx_drift_app/data/app_database.dart';

class TransactionParticipantWithEntity {
  final TransactionParticipantsTableData participant;

  final EntitiesTableData entity;

  TransactionParticipantWithEntity({
    required this.participant,
    required this.entity,
  });
}
