import 'package:drift/drift.dart';

class InvestorProfilesTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get investmentHorizon => text().nullable()();

  TextColumn get withdrawalHorizon => text().nullable()();

  TextColumn get investmentKnowledge => text().nullable()();

  TextColumn get riskWillingness => text().nullable()();

  TextColumn get investmentExperience => text().nullable()();

  TextColumn get marketLossReaction => text().nullable()();

  TextColumn get riskReturnPreference => text().nullable()();

  IntColumn get totalScore => integer().nullable()();

  TextColumn get investorProfile => text().nullable()();

  DateTimeColumn get assessedAt => dateTime().nullable()();
}
