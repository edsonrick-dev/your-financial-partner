import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentTermsRepository {
  PaymentTermsRepository(this._client);

  final SupabaseClient _client;

  Future<List<Map<String, dynamic>>> fetchPaymentTerms() async {
    final response = await _client
        .from('payment_terms')
        .select(
          'id, payment_type, years_to_pay, '
          'age_end_of_payment, description, created_at',
        );

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> fetchProductPaymentTerms() async {
    final response = await _client
        .from('insurance_product_payment_terms')
        .select('id, product_id, payment_term_id, created_at');

    return List<Map<String, dynamic>>.from(response);
  }
}
