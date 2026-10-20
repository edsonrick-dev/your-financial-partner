import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/insurance_company_model.dart';

class InsuranceCompanyRepository {
  InsuranceCompanyRepository(this._client);

  final SupabaseClient _client;

  Future<List<InsuranceCompany>> fetchCompanies() async {
    debugPrint('Fetching insurance companies from Supabase...');

    try {
      final response = await _client
          .from('entities')
          .select('id, name, display_name')
          .eq('entity_type', 'organization')
          .eq('organization_type', 'insuranceCompany')
          .eq('is_system', true)
          .order('name');

      debugPrint('Supabase returned ${response.length} companies');

      return response
          .map<InsuranceCompany>((json) => InsuranceCompany.fromJson(json))
          .toList();
    } catch (error, stackTrace) {
      debugPrint('Supabase query failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }
}
