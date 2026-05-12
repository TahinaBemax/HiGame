import 'package:flutter/material.dart';
import '../../core/theme/tokens/app_colors.dart';

class HiAvatar extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final String? initials;
  final Color? borderColor;

  const HiAvatar({
    super.key,
    this.size = 40,
    this.imageUrl,
    this.initials,
    this.borderColor,
  });

  const HiAvatar.profile({super.key, this.imageUrl, this.initials})
      : size = 56,
        borderColor = null;

  const HiAvatar.small({super.key, this.imageUrl, this.initials})
      : size = 24,
        borderColor = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 2)
            : null,
      ),
      child: initials != null && imageUrl == null
          ? Center(
              child: Text(
                initials!,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.white,
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );
  }
}
