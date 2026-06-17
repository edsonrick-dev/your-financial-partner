// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities_dao.dart';

// ignore_for_file: type=lint
mixin _$EntitiesDaoMixin on DatabaseAccessor<AppDatabase> {
  $EntitiesTableTable get entitiesTable => attachedDatabase.entitiesTable;
  EntitiesDaoManager get managers => EntitiesDaoManager(this);
}

class EntitiesDaoManager {
  final _$EntitiesDaoMixin _db;
  EntitiesDaoManager(this._db);
  $$EntitiesTableTableTableManager get entitiesTable =>
      $$EntitiesTableTableTableManager(_db.attachedDatabase, _db.entitiesTable);
}
