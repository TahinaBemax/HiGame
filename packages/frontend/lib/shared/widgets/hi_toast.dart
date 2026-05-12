import 'package:flutter/material.dart';
import '../../core/theme/tokens/app_colors.dart';
import '../../core/theme/tokens/app_radius.dart';
import '../../core/theme/tokens/app_spacing.dart';
import 'layout/spacing.dart';

enum HiToastType { success, error, warning }

class HiToast {
  static void show(
    BuildContext context, {
    required String message,
    HiToastType type = HiToastType.success,
  }) {
    final color = switch (type) {
      HiToastType.success => AppColors.success,
      HiToastType.error => AppColors.error,
      HiToastType.warning => AppColors.warning,
    };
    final icon = switch (type) {
      HiToastType.success => Icons.check_circle_outline,
      HiToastType.error => Icons.error_outline,
      HiToastType.warning => Icons.warning_amber_outlined,
    };

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: AppColors.white, size: 20),
              const HSpace.sm(),
              Expanded(
                child: Text(message,
                    style: const TextStyle(color: AppColors.white)),
              ),
            ],
          ),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
