import 'package:flutter/material.dart';
import '../../core/theme/tokens/app_colors.dart';
import '../../core/theme/tokens/app_radius.dart';
import '../../core/theme/tokens/app_spacing.dart';

class HiChip extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;

  const HiChip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
  });

  const HiChip.beta({super.key})
      : label = 'Beta',
        backgroundColor = AppColors.warning,
        textColor = AppColors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          color: textColor ?? AppColors.white,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
