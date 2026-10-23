import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class SupabaseInitializer {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://opclmmluhqzlzifxqqsb.supabase.co',
      publishableKey: 'sb_publishable_oKAJUOS_PxpUyrGwX54eYg_VljVUjPg',
    );
  }
}
