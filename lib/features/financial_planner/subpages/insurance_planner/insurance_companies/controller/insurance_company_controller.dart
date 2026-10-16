import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../models/insurance_company_model.dart';
import '../repositories/insurance_company_repository.dart';

class InsuranceCompanyController extends GetxController {
  InsuranceCompanyController(this._repository);

  final InsuranceCompanyRepository _repository;

  final companies = <InsuranceCompany>[].obs;
  final isLoading = false.obs;
  final errorMessage = RxnString();

  Future<void> loadCompanies() async {
    if (isLoading.value) return;

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final result = await _repository.fetchCompanies();
      companies.assignAll(result);
    } catch (error, stackTrace) {
      debugPrint('Failed to load insurance companies: $error');
      debugPrintStack(stackTrace: stackTrace);

      errorMessage.value = 'Unable to load insurance companies.';
    } finally {
      isLoading.value = false;
    }

    // } catch (e) {
    //   errorMessage.value = 'Unable to load insurance companies.';

    //   // Replace with your app's logger if available.
    //   // Log error and stackTrace for debugging.
    // } finally {
    //   isLoading.value = false;
    // }
  }

  @override
  void onInit() {
    super.onInit();
    loadCompanies();
  }
}
