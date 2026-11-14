import 'package:get_storage/get_storage.dart';

class OnboardingPreference {
  static const String _key = 'onboarding_completed';

  static final GetStorage _storage = GetStorage();

  static bool get isCompleted => _storage.read<bool>(_key) ?? false;

  static Future<void> complete() async {
    await _storage.write(_key, true);
  }

  static Future<void> reset() async {
    await _storage.remove(_key);
  }
}
