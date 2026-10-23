import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/models/payment_terms_repository.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/models/payment_terms_sync_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/repository/insurance_product_repository.dart';

class InsurancePolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InsuranceProductRepository>(
      () => InsuranceProductRepository(supabase: Supabase.instance.client),
    );

    Get.lazyPut<PaymentTermsRepository>(
      () => PaymentTermsRepository(Supabase.instance.client),
    );

    Get.lazyPut<PaymentTermsSyncService>(
      () => PaymentTermsSyncService(
        repository: Get.find<PaymentTermsRepository>(),
      ),
    );

    Get.lazyPut<InsurancePolicyController>(
      () => InsurancePolicyController(
        Get.find<InsuranceProductRepository>(),
        Get.find<PaymentTermsSyncService>(),
      ),
    );
  }
}
