import 'package:drift/drift.dart';

class GoalsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()();
  TextColumn get name => text().nullable()();
  RealColumn get targetAmount => real().withDefault(const Constant(0))();
  RealColumn get monthlyContribution => real().withDefault(const Constant(0))();
  DateTimeColumn get dueDate => dateTime().nullable()();
}
