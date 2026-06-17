import 'package:get/get.dart';
import 'package:getx_drift_app/features/personal_balance/controller/personal_balance_controller.dart';

class PersonalBalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalBalanceController>(() => PersonalBalanceController());
  }
}
