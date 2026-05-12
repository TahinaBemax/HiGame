import 'package:flutter/material.dart';
import '../../../core/theme/tokens/app_spacing.dart';

class VSpace extends StatelessWidget {
  final double size;
  const VSpace(this.size, {super.key});

  const VSpace.xs({super.key}) : size = AppSpacing.xs;
  const VSpace.sm({super.key}) : size = AppSpacing.sm;
  const VSpace.md({super.key}) : size = AppSpacing.md;
  const VSpace.lg({super.key}) : size = AppSpacing.lg;
  const VSpace.xl({super.key}) : size = AppSpacing.xl;
  const VSpace.xl2({super.key}) : size = AppSpacing.xl2;
  const VSpace.xl3({super.key}) : size = AppSpacing.xl3;

  @override
  Widget build(BuildContext context) => SizedBox(height: size);
}

class HSpace extends StatelessWidget {
  final double size;
  const HSpace(this.size, {super.key});

  const HSpace.xs({super.key}) : size = AppSpacing.xs;
  const HSpace.sm({super.key}) : size = AppSpacing.sm;
  const HSpace.md({super.key}) : size = AppSpacing.md;
  const HSpace.lg({super.key}) : size = AppSpacing.lg;

  @override
  Widget build(BuildContext context) => SizedBox(width: size);
}
