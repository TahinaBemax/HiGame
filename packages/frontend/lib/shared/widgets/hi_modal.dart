import 'package:flutter/material.dart';
import '../../core/theme/tokens/app_colors.dart';
import '../../core/theme/tokens/app_radius.dart';
import '../../core/theme/tokens/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HiModal {
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required Widget content,
    String? confirmLabel,
    String? cancelLabel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool dismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: dismissible,
      enableDrag: dismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.modal),
          topRight: Radius.circular(AppRadius.modal),
        ),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.xs),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.neutral300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.sm,
              ),
              child: Text(
                title,
                style: AppTextStyles.light.headlineSmall,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                ),
                child: content,
              ),
            ),
            if (confirmLabel != null || cancelLabel != null)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Row(
                  children: [
                    if (cancelLabel != null) ...[
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            onCancel?.call();
                            Navigator.of(ctx).pop();
                          },
                          child: Text(cancelLabel),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    if (confirmLabel != null)
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {
                            onConfirm?.call();
                            Navigator.of(ctx).pop();
                          },
                          child: Text(confirmLabel),
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
  }
}
