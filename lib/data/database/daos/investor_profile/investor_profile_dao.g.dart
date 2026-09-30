// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investor_profile_dao.dart';

// ignore_for_file: type=lint
mixin _$InvestorProfileDaoMixin on DatabaseAccessor<AppDatabase> {
  $InvestorProfilesTableTable get investorProfilesTable =>
      attachedDatabase.investorProfilesTable;
  InvestorProfileDaoManager get managers => InvestorProfileDaoManager(this);
}

class InvestorProfileDaoManager {
  final _$InvestorProfileDaoMixin _db;
  InvestorProfileDaoManager(this._db);
  $$InvestorProfilesTableTableTableManager get investorProfilesTable =>
      $$InvestorProfilesTableTableTableManager(
        _db.attachedDatabase,
        _db.investorProfilesTable,
      );
}
