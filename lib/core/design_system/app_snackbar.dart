import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_opacity.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';

class AppSnackbar {
  static void show({
    required String title,
    required String message,
    AppSnackType type = AppSnackType.success,
  }) {
    final context = Get.context!;
    final colors = context.colors;
    late Color accent;
    late IconData icon;

    switch (type) {
      case AppSnackType.success:
        accent = colors.appSuccess;
        icon = Icons.check;
        break;
      case AppSnackType.error:
        accent = colors.appError;
        icon = Icons.close;
        break;
      case AppSnackType.warning:
        accent = colors.appWarning;
        icon = Icons.warning_amber_rounded;
        break;
      case AppSnackType.info:
        accent = colors.appInfo;
        icon = Icons.info_outline;
        break;
    }
    Get.rawSnackbar(
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(16),
      duration: const Duration(seconds: 4),
      messageText: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.bgLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accent),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: AppOpacity.snackBarIcon,
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Icon(icon, color: accent, size: 18),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
