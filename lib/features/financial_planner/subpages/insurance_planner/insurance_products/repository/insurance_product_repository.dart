import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/models/insurance_product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InsuranceProductRepository {
  InsuranceProductRepository({required SupabaseClient supabase})
    : _supabase = supabase;

  final SupabaseClient _supabase;

  Future<List<InsuranceProduct>> fetchOfficialproducts({
    required int supabaseInsurerId,
  }) async {
    debugPrint('Fetching products for insurer ID: $supabaseInsurerId');

    final response = await _supabase
        .from('insurance_products')
        .select(
          'id, insurer_id, name, short_name, description, '
          'is_user_generated, min_age, max_age, note, '
          'created_by_user_id',
        )
        .eq('insurer_id', supabaseInsurerId)
        .eq('is_user_generated', false)
        .order('name');

    debugPrint('Supabase policy response: $response');

    final products = List<Map<String, dynamic>>.from(
      response,
    ).map(InsuranceProduct.fromJson).toList();

    debugPrint('Mapped ${products.length} insurance products');

    return products;
  }
}
