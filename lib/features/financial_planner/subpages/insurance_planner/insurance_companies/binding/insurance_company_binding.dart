import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/controller/insurance_company_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/repositories/insurance_company_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InsuranceCompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InsuranceCompanyRepository>(
      () => InsuranceCompanyRepository(Supabase.instance.client),
    );

    Get.lazyPut<InsuranceCompanyController>(
      () => InsuranceCompanyController(
        Get.find<InsuranceCompanyRepository>(),
        database.entitiesDao,
      ),
    );
  }
}
