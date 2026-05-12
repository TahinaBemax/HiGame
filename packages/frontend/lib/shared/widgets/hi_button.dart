import 'package:flutter/material.dart';
import '../../core/theme/tokens/app_colors.dart';
import '../../core/theme/tokens/app_radius.dart';
import '../../core/theme/tokens/app_spacing.dart';
import '../../core/theme/theme_extensions.dart';
import 'layout/spacing.dart';

enum HiButtonVariant { primary, outline, text }

class HiButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final HiButtonVariant variant;
  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;
  final bool isFullWidth;

  const HiButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = HiButtonVariant.primary,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  const HiButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.isFullWidth = false,
  }) : variant = HiButtonVariant.primary;

  const HiButton.outline({
    super.key,
    required this.label,
    this.onPressed,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.isFullWidth = false,
  }) : variant = HiButtonVariant.outline;

  const HiButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.isFullWidth = false,
  }) : variant = HiButtonVariant.text;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;
    final cs = context.colors;

    final Color bg;
    final Color fg;
    final Color borderColor;
    final double borderWidth;

    switch (variant) {
      case HiButtonVariant.primary:
        bg = isDisabled
            ? cs.onSurface.withValues(alpha: 0.12)
            : AppColors.accent;
        fg =
            isDisabled ? cs.onSurface.withValues(alpha: 0.38) : AppColors.white;
        borderColor = Colors.transparent;
        borderWidth = 0;
      case HiButtonVariant.outline:
        bg = Colors.transparent;
        fg = isDisabled ? cs.onSurface.withValues(alpha: 0.38) : cs.primary;
        borderColor =
            isDisabled ? cs.onSurface.withValues(alpha: 0.12) : cs.primary;
        borderWidth = 1.5;
      case HiButtonVariant.text:
        bg = Colors.transparent;
        fg = isDisabled
            ? cs.onSurface.withValues(alpha: 0.38)
            : cs.onSurface.withValues(alpha: 0.6);
        borderColor = Colors.transparent;
        borderWidth = 0;
    }

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading)
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: fg,
            ),
          )
        else if (leading != null) ...[
          IconTheme(data: IconThemeData(size: 18, color: fg), child: leading!),
          const HSpace.sm(),
        ],
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: fg,
            letterSpacing: 0.1,
          ),
        ),
        if (trailing != null && !isLoading) ...[
          const HSpace.sm(),
          IconTheme(data: IconThemeData(size: 18, color: fg), child: trailing!),
        ],
      ],
    );

    final button = Material(
      color: bg,
      borderRadius: BorderRadius.circular(AppRadius.button),
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(AppRadius.button),
        splashColor: fg.withValues(alpha: 0.1),
        highlightColor: fg.withValues(alpha: 0.05),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          decoration: variant == HiButtonVariant.outline
              ? BoxDecoration(
                  border: Border.all(color: borderColor, width: borderWidth),
                  borderRadius: BorderRadius.circular(AppRadius.button),
                )
              : null,
          child: Center(child: content),
        ),
      ),
    );

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}
