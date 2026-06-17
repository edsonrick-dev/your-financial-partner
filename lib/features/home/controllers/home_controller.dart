import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';

class HomeController extends GetxController {
  final isFundHidden = false.obs;

  void toggleIsFundHidden() {
    isFundHidden.toggle();
  }

  final availableFundsStream = database.accountsDao.watchAvailableFunds();
}
