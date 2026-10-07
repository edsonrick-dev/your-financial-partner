import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/user_profile_table.dart';

part 'user_profile_dao.g.dart';

@DriftAccessor(tables: [UserProfileTable])
class UserProfileDao extends DatabaseAccessor<AppDatabase>
    with _$UserProfileDaoMixin {
  UserProfileDao(super.db);

  Stream<UserProfileTableData?> watchProfile() {
    return select(userProfileTable).watchSingleOrNull();
  }

  Future<UserProfileTableData?> getProfile() {
    return select(userProfileTable).getSingleOrNull();
  }

  Future<void> updateProfile({String? name, DateTime? birthday}) async {
    await into(userProfileTable).insertOnConflictUpdate(
      UserProfileTableCompanion(
        id: const Value(1),
        name: Value(name),
        birthday: Value(birthday),
      ),
    );
  }
}
