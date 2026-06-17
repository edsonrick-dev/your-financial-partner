import 'package:get/get.dart';

class PersonalBalanceController extends GetxController {
  late final int entityId;

  @override
  void onInit() {
    super.onInit();

    entityId = Get.arguments as int;
  }
}
