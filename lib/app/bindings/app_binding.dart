import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppDatabase>(database, permanent: true);
  }
}
