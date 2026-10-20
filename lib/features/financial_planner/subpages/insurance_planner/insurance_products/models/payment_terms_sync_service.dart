import 'package:flutter/rendering.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';

import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/models/payment_terms_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentTermsSyncService {
  PaymentTermsSyncService({required PaymentTermsRepository repository})
    : _repository = repository;

  final PaymentTermsRepository _repository;

  Future<void> syncPaymentTerms() async {
    final remoteTerms = await _repository.fetchPaymentTerms();

    for (final term in remoteTerms) {
      await database.paymentTermsDao.upsertFromSupabase(term);
    }
  }

  Future<void> syncProductPaymentTerms({
    required int remoteProductId,
    required int localProductId,
  }) async {
    final response = await Supabase.instance.client
        .from('insurance_product_payment_terms')
        .select('payment_term_id')
        .eq('product_id', remoteProductId);

    for (final row in response) {
      final remoteTermId = (row['payment_term_id'] as num).toInt();

      // Resolve the remote payment-term ID to a local Drift row.
      final localTerm = await database.insuranceProductPaymentTermsDao
          .getPaymentTermBySupabaseId(remoteTermId);

      if (localTerm == null) {
        debugPrint('Payment term $remoteTermId is not cached.');
        continue;
      }

      await database.insuranceProductPaymentTermsDao.linkPaymentTermToProduct(
        localProductId: localProductId,
        localPaymentTermId: localTerm.id,
      );
    }
  }
}
