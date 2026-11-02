import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/database/daos/entities_dao/entities_dao.dart';
import 'package:getx_drift_app/core/network/internet_connection_checker.dart';

import '../models/insurance_company_model.dart';
import '../repositories/insurance_company_repository.dart';

class InsuranceCompanyController extends GetxController {
  InsuranceCompanyController(this._repository, this._entitiesDao);

  final InsuranceCompanyRepository _repository;
  final EntitiesDao _entitiesDao;

  final companies = <InsuranceCompany>[].obs;
  final isLoading = false.obs;
  final errorMessage = RxnString();
  final isOnline = false.obs;
  StreamSubscription? _subscription;

  // Future<void> loadCompanies() async {
  //   if (isLoading.value) return;

  //   isLoading.value = true;
  //   errorMessage.value = null;

  //   try {
  //     final result = await _repository.fetchCompanies();
  //     companies.assignAll(result);
  //   } catch (error, stackTrace) {
  //     debugPrint('Failed to load insurance companies: $error');
  //     debugPrintStack(stackTrace: stackTrace);

  //     errorMessage.value = 'Unable to load insurance companies.';
  //   } finally {
  //     isLoading.value = false;
  //   }

  //   // } catch (e) {
  //   //   errorMessage.value = 'Unable to load insurance companies.';

  //   //   // Replace with your app's logger if available.
  //   //   // Log error and stackTrace for debugging.
  //   // } finally {
  //   //   isLoading.value = false;
  //   // }
  // }

  Future<void> refreshCatalogInBackground() async {
    if (isLoading.value) return;

    isLoading.value = true;
    errorMessage.value = null;

    try {
      isOnline.value = await InternetConnectionChecker.isOnline();
      if (!isOnline.value) {
        debugPrint('Offline: skipping Supabase insurer catalog request.');
        if (companies.isEmpty) {
          errorMessage.value =
              'Connect to the internet to load available insurers.';
        }
        return;
      }

      final result = await _repository.fetchCompanies();

      await _entitiesDao.syncSystemInsuranceCompanies(
        result
            .map(
              (company) => {
                'id': company.id,
                'name': company.name,
                'display_name': company.displayName,
                'entity_type': 'organization',
                'organization_type': 'insuranceCompany',
              },
            )
            .toList(),
      );
    } catch (error, stackTrace) {
      debugPrint('Failed to refresh insurer catalog: $error');
      debugPrintStack(stackTrace: stackTrace);

      // Keep cached companies if the network request fails.
      if (companies.isEmpty) {
        errorMessage.value = 'Unable to load insurance companies.';
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();

    // Local data appears immediately, including offline.
    _subscription = _entitiesDao.watchSystemInsuranceCompanies().listen(
      (entities) {
        companies.assignAll(
          entities.map(
            (entity) => InsuranceCompany(
              id: entity.id,
              supabaseId: entity.supabaseId,
              name: entity.name,
              displayName: entity.displayName ?? entity.name,
            ),
          ),
        );
      },
      onError: (Object error, StackTrace stackTrace) {
        debugPrint('Failed to watch local insurers: $error');
      },
    );

    // Refresh the local catalog from Supabase.
    refreshCatalogInBackground();
  }
}
