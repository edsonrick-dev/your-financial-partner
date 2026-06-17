import 'package:drift/drift.dart';
import 'transactions_table.dart';
import 'entities_table.dart';

class TransactionParticipantsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get transactionId => integer().references(
    TransactionsTable,
    #id,
    onDelete: KeyAction.cascade,
  )();

  IntColumn get entityId =>
      integer().references(EntitiesTable, #id, onDelete: KeyAction.cascade)();

  RealColumn get allocatedAmount => real()();

  RealColumn get allocationPercentage => real().nullable()();

  BoolColumn get isPayer => boolean().withDefault(const Constant(false))();

  TextColumn get displayNameSnapshot => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {transactionId, entityId},
  ];
}
