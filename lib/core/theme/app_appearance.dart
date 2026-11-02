import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract final class AppAppearance {
  static const _themeModeKey = 'app_theme_mode';
  static final _storage = GetStorage();
  static final Rx<ThemeMode> themeMode = readThemeMode().obs;

  static ThemeMode readThemeMode() {
    final savedMode = _storage.read(_themeModeKey);
    if (savedMode is! String) return ThemeMode.system;

    for (final mode in ThemeMode.values) {
      if (mode.name == savedMode) return mode;
    }

    return ThemeMode.system;
  }

  static Future<void> saveThemeMode(ThemeMode mode) async {
    await _storage.write(_themeModeKey, mode.name);
    themeMode.value = mode;
  }
}
