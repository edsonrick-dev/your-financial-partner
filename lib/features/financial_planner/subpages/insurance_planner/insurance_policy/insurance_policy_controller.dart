import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_benefit/models/insurance_benefit.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_draft.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/models/payment_terms_sync_service.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/repository/insurance_product_repository.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/models/insurance_product.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InsurancePolicyController extends GetxController {
  InsurancePolicyController(
    this._policiesRepository,
    this._paymentTermsSyncService,
  );

  final InsuranceProductRepository _policiesRepository;
  final PaymentTermsSyncService _paymentTermsSyncService;
  final availablePaymentTerms = <PaymentTermRow>[].obs;
  final isLoadingPaymentTerms = false.obs;
  final selectedPaymentTerm = Rxn<PaymentTermRow>();
  Future<void> loadPaymentTermsForProduct(int localProductId) async {
    isLoadingPaymentTerms.value = true;
    availablePaymentTerms.clear();
    selectedPaymentTerm.value = null;

    try {
      // Resolve the local product to its Supabase ID.
      final product = await database.insurancePoliciesDao.getProductByLocalId(
        localProductId,
      );

      if (product == null) {
        debugPrint('Product not found locally: $localProductId');
        return;
      }

      // User-created products may not exist in Supabase.
      if (product.isUserGenerated || product.supabaseId == null) {
        debugPrint('Skipping remote payment-term sync for custom product.');
      } else {
        try {
          // Sync definitions first.
          await _paymentTermsSyncService.syncPaymentTerms();

          // Then sync the product associations.
          await _paymentTermsSyncService.syncProductPaymentTerms(
            remoteProductId: product.supabaseId!,
            localProductId: product.id,
          );
        } catch (error, stackTrace) {
          debugPrint('Payment-term sync failed: $error');
          debugPrintStack(stackTrace: stackTrace);
          // Continue loading locally cached associations.
        }
      }

      // Load terms from Drift.
      final linkedTerms = await database.insuranceProductPaymentTermsDao
          .getPaymentTermsForProduct(localProductId);

      debugPrint('Local product ID: ${product.id}');
      debugPrint('Supabase product ID: ${product.supabaseId}');
      debugPrint('Product-linked terms: ${linkedTerms.length}');

      availablePaymentTerms.assignAll(linkedTerms);
    } catch (error, stackTrace) {
      debugPrint('Failed to load payment terms: $error');
      debugPrintStack(stackTrace: stackTrace);
      availablePaymentTerms.clear();
    } finally {
      isLoadingPaymentTerms.value = false;
    }
  }

  void selectPaymentTerm(PaymentTermRow term) {
    selectedPaymentTerm.value = term;
  }

  final RxnInt editingBenefitIndex = RxnInt();

  void startEditingBenefit(int index) {
    isAddingBenefit.value = false;
    editingBenefitIndex.value = index;
  }

  void cancelEditingBenefit() {
    editingBenefitIndex.value = null;
  }

  void updateBenefitDraft(
    int index, {
    required BenefitType type,
    required String? name,
    required double amount,
  }) {
    benefitDrafts[index] = benefitDrafts[index].copyWith(
      benefitType: type,
      name: name,
      coverageAmount: amount,
    );

    editingBenefitIndex.value = null;
  }

  final policyNumberTextController = TextEditingController();
  final policyNumberFocusNode = FocusNode();
  void initializeBenefitDrafts(List<InsuranceBenefit> benefits) {
    benefitDrafts.assignAll(
      benefits.map(
        (benefit) => PolicyBenefitDraft(
          benefitType: benefit.benefitType,
          name: benefit.name ?? '',
          coverageAmount: 0,
        ),
      ),
    );
  }

  // Temporary benefits entered by the user.
  final RxList<PolicyBenefitDraft> benefitDrafts = <PolicyBenefitDraft>[].obs;

  // Definitions belonging to the selected product, loaded from Drift.
  final productBenefits = <InsuranceBenefit>[].obs;

  final isLoadingBenefits = false.obs;
  final benefitLoadError = RxnString();

  final RxBool isAddingBenefit = false.obs;

  void startAddingBenefit() {
    isAddingBenefit.value = true;
  }

  void cancelAddingBenefit() {
    isAddingBenefit.value = false;
  }

  void addBenefitDraft(PolicyBenefitDraft benefit) {
    benefitDrafts.add(benefit);
    isAddingBenefit.value = false;
  }

  // final policyBenefitDrafts = <PolicyBenefitDraft>[].obs;
  void updateBenefitAmount(int index, double amount) {
    benefitDrafts[index] = benefitDrafts[index].copyWith(
      coverageAmount: amount,
    );
  }

  Future<void> loadBenefitsForProduct(
    InsuranceProduct product, {
    required int localProductId,
  }) async {
    isLoadingBenefits.value = true;
    benefitLoadError.value = null;

    try {
      // 1. Show cached benefits immediately.
      final cached = await database.insurancePoliciesDao.getBenefitsByProductId(
        localProductId,
      );

      productBenefits.assignAll(cached);

      // Initialize the editable coverage amounts.
      initializeBenefitDrafts(cached);

      // Custom products do not have an official Supabase catalog.
      if (product.isUserGenerated) return;

      final remoteProductId = product.supabaseId;

      if (remoteProductId == null) {
        if (cached.isEmpty) {
          benefitLoadError.value =
              'Benefits have not been cached and are unavailable offline.';
        }
        return;
      }

      // 2. Fetch official benefit definitions from Supabase.
      final response = await Supabase.instance.client
          .from('product_benefit')
          .select()
          .eq('product_id', remoteProductId);

      debugPrint('Remote product ID: $remoteProductId');
      debugPrint('Fetched benefits: $response');

      // 3. Cache each remote benefit against the LOCAL product ID.
      for (final item in response) {
        await database.insurancePoliciesDao.upsertOfficialBenefit(
          localProductId: localProductId,
          json: Map<String, dynamic>.from(item),
        );
      }

      // 4. Reload Drift as the source of truth for the UI.
      final refreshed = await database.insurancePoliciesDao
          .getBenefitsByProductId(localProductId);

      productBenefits.assignAll(refreshed);
      initializeBenefitDrafts(refreshed);

      debugPrint(
        'Loaded ${refreshed.length} benefits for '
        '${product.name} (local ID: $localProductId, '
        'Supabase ID: $remoteProductId)',
      );
    } catch (error, stackTrace) {
      debugPrint('Failed to load product benefits: $error');
      debugPrintStack(stackTrace: stackTrace);

      // Keep cached benefits if the network request fails.
      if (productBenefits.isEmpty) {
        benefitLoadError.value = 'Unable to load benefits.';
      }
    } finally {
      isLoadingBenefits.value = false;
    }
  }

  final selectedType = Rxn<BenefitType>();

  final nameController = TextEditingController();
  final amountController = TextEditingController();

  bool get isNameRequired => selectedType.value == BenefitType.others;
  final selectedPremiumPaymentType = 0.obs;
  final productNameTextController = TextEditingController();
  final productNameFocusNode = FocusNode();
  final Rx<AddButtonState> createProductButtonState =
      AddButtonState.collapsed.obs;
  void expandButton() {
    createProductButtonState.value = AddButtonState.expanded;
  }

  void collapseButton() {
    createProductButtonState.value = AddButtonState.collapsed;
  }

  Future<void> saveInsuranceProduct() async {
    final name = productNameTextController.text.trim();
    final insurer = selectedInsurer.value;

    if (insurer == null) {
      AppSnackbar.show(
        title: 'Select an insurer',
        message: 'Please select an insurance company.',
      );
      return;
    }

    if (name.isEmpty) {
      AppSnackbar.show(
        title: 'Missing product name',
        message: 'Please enter a product name.',
      );
      return;
    }

    try {
      final id = await database.insurancePoliciesDao.createInsuranceProduct(
        insurerId: insurer.id,
        name: name,
      );

      final product = InsuranceProduct(
        id: id,
        companyId: insurer.id,
        name: name,
        isUserGenerated: true,
      );

      _localProducts.add(product);
      _updateAvailableProducts();
      selectedProduct.value = product;

      productNameTextController.clear();
      collapseButton();

      Get.back<InsuranceProduct>(result: product);

      AppSnackbar.show(
        title: 'Success',
        message: 'Insurance product saved.',
        type: AppSnackType.success,
      );
    } catch (error) {
      debugPrint('Failed to save insurance product: $error');

      AppSnackbar.show(
        title: 'Error',
        message: 'Unable to save insurance product.',
        type: AppSnackType.error,
      );
    }
  }

  @override
  void onClose() {
    _policySubscription?.cancel();
    super.onClose();
  }

  Future<void> setInsurer(InsuranceCompany insurer) async {
    if (selectedInsurer.value?.id == insurer.id) return;

    selectedInsurer.value = insurer;
    selectedProduct.value = null;

    _activeInsurerId = null;
    _localProducts.clear();
    _supabaseProducts.clear();
    availableProducts.clear();

    productErrorMessage.value = null;

    // Local Drift uses the local insurer ID.
    loadLocalProducts(insurer.id);

    // Supabase uses the remote insurer ID.
    final supabaseInsurerId = insurer.supabaseId;

    if (supabaseInsurerId == null) {
      isLoadingProducts.value = false;
      return;
    }

    await loadProducts(supabaseInsurerId);
  }

  Future<void> loadProducts(int supabaseInsurerId) async {
    isLoadingProducts.value = true;
    productErrorMessage.value = null;

    try {
      final insurer = selectedInsurer.value;

      if (insurer == null) return;

      // 1. Fetch official products from Supabase.
      final remoteProducts = await _policiesRepository.fetchOfficialproducts(
        supabaseInsurerId: supabaseInsurerId,
      );

      // 2. Cache each official product in Drift.
      for (final product in remoteProducts) {
        final remoteId = product.supabaseId;

        if (remoteId == null) {
          debugPrint('Skipping product without Supabase ID: ${product.name}');
          continue;
        }

        await database.insurancePoliciesDao.upsertOfficialPolicy(
          localInsurerId: insurer.id,
          supabasePolicy: {
            'id': remoteId,
            'name': product.name,
            'short_name': product.shortName,
            'description': product.description,
            'is_user_generated': product.isUserGenerated,
            'min_age': product.minAge,
            'max_age': product.maxAge,
            'note': product.note,
            'created_by_user_id': product.createdByUserId,
          },
        );
      }

      // 3. Read the cached products back from Drift.
      final localRows = await database.insurancePoliciesDao.getByInsurer(
        insurer.id,
      );

      // 4. Map Drift records into InsuranceProduct models.
      _localProducts.assignAll(
        localRows.map(
          (row) => InsuranceProduct(
            id: row.id,
            supabaseId: row.supabaseId,
            companyId: row.insurerId,
            name: row.name,
            shortName: row.shortName,
            description: row.description,
            isUserGenerated: row.isUserGenerated,
            minAge: row.minAge,
            maxAge: row.maxAge,
            note: row.note,
            createdByUserId: row.createdByUserId,
          ),
        ),
      );

      // 5. Update the available products.
      _updateAvailableProducts();
    } catch (error, stackTrace) {
      debugPrint('Failed to load insurance products: $error');
      debugPrintStack(stackTrace: stackTrace);

      productErrorMessage.value = 'Unable to load insurance products.';
    } finally {
      isLoadingProducts.value = false;
    }
  }
  // Future<void> loadProducts(int supabaseInsurerId) async {
  //   isLoadingProducts.value = true;
  //   productErrorMessage.value = null;

  //   try {
  //     final products = await _policiesRepository.fetchOfficialproducts(
  //       supabaseInsurerId: supabaseInsurerId,
  //     );

  //     // Cache each official product in Drift.
  //     for (final product in products) {
  //       await database.insurancePoliciesDao.upsertOfficialPolicy(
  //         localInsurerId: selectedInsurer.value!.id,
  //         supabasePolicy: {
  //           'id': product.supabaseId,
  //           'name': product.name,
  //           'short_name': product.shortName,
  //           'description': product.description,
  //           'is_user_generated': product.isUserGenerated,
  //           'min_age': product.minAge,
  //           'max_age': product.maxAge,
  //           'note': product.note,
  //           'created_by_user_id': product.createdByUserId,
  //         },
  //       );
  //     }

  //     // Update the product list after caching.
  //     _supabaseProducts
  //       ..clear()
  //       ..addAll(products);

  //     _updateAvailableProducts();
  //   } catch (error, stackTrace) {
  //     debugPrint('Failed to load insurance products: $error');
  //     debugPrintStack(stackTrace: stackTrace);

  //     productErrorMessage.value = 'Unable to load insurance products.';
  //   } finally {
  //     isLoadingProducts.value = false;
  //   }
  // }

  final selectedInsurer = Rxn<InsuranceCompany>();
  final selectedProduct = Rxn<InsuranceProduct>();
  final issueDate = Rxn<DateTime>();

  final nextPaymentDate = Rxn<DateTime>();
  final selectedFrequency = BillsFrequency.monthly.obs;
  final premiumAmount = 0.0.obs;

  // Product catalog state.
  final availableProducts = <InsuranceProduct>[].obs;
  final _localProducts = <InsuranceProduct>[].obs;
  final _supabaseProducts = <InsuranceProduct>[].obs;

  void _updateAvailableProducts() {
    final combined = <InsuranceProduct>[
      ..._supabaseProducts,
      ..._localProducts,
    ];

    // Prefer the Supabase version if the same remote product
    // also exists in Drift.
    final seenSupabaseIds = <int>{};
    final uniqueProducts = <InsuranceProduct>[];

    for (final product in combined) {
      final remoteId = product.supabaseId;

      if (remoteId != null && !seenSupabaseIds.add(remoteId)) {
        continue;
      }

      uniqueProducts.add(product);
    }

    availableProducts.assignAll(uniqueProducts);
  }

  final isLoadingProducts = false.obs;
  final productErrorMessage = RxnString();
  StreamSubscription? _policySubscription;
  int? _activeInsurerId;
  void loadLocalProducts(int localInsurerId) {
    if (_activeInsurerId == localInsurerId) return;

    _activeInsurerId = localInsurerId;
    _policySubscription?.cancel();

    _policySubscription = database.insurancePoliciesDao
        .watchByInsurer(localInsurerId)
        .listen(
          (rows) {
            _localProducts.assignAll(
              rows.map(
                (row) => InsuranceProduct(
                  id: row.id,
                  supabaseId: row.supabaseId,
                  companyId: row.insurerId,
                  name: row.name,
                  shortName: row.shortName,
                  description: row.description,
                  isUserGenerated: row.isUserGenerated,
                  minAge: row.minAge,
                  maxAge: row.maxAge,
                  note: row.note,
                  createdByUserId: row.createdByUserId,
                ),
              ),
            );

            _updateAvailableProducts();
            productErrorMessage.value = null;
          },
          onError: (Object error, StackTrace stackTrace) {
            debugPrint('Failed to watch insurance products: $error');
            debugPrintStack(stackTrace: stackTrace);
            productErrorMessage.value = 'Unable to load insurance products.';
          },
        );
  }

  static const List<BillsFrequency> mvpBillFrequencies = [
    BillsFrequency.monthly,
    BillsFrequency.quarterly,
    BillsFrequency.semiAnnual,
    BillsFrequency.annual,
  ];
}
