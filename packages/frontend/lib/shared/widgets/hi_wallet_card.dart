import 'package:flutter/material.dart';
import '../../core/theme/tokens/app_colors.dart';
import '../../core/theme/tokens/app_radius.dart';
import '../../core/theme/tokens/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import 'layout/spacing.dart';

class HiWalletCard extends StatelessWidget {
  final String balance;
  final VoidCallback? onDeposit;
  final VoidCallback? onWithdraw;

  const HiWalletCard({
    super.key,
    required this.balance,
    this.onDeposit,
    this.onWithdraw,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      padding: const EdgeInsets.all(AppSpacing.xl + AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Solde',
            style: TextStyle(
              fontFamily: 'Inter',
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const VSpace.sm(),
          Text(
            balance,
            style: AppTextStyles.monetary(AppColors.white),
          ),
          const VSpace.lg(),
          Row(
            children: [
              if (onDeposit != null)
                Expanded(
                  child: _actionButton(
                    label: 'Déposer',
                    onTap: onDeposit,
                    isDeposit: true,
                  ),
                ),
              if (onDeposit != null && onWithdraw != null) const HSpace.sm(),
              if (onWithdraw != null)
                Expanded(
                  child: _actionButton(
                    label: 'Retirer',
                    onTap: onWithdraw,
                    isDeposit: false,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required VoidCallback? onTap,
    required bool isDeposit,
  }) {
    return Material(
      color: AppColors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Container(
          height: 36,
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: AppColors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
