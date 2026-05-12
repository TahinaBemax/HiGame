import 'package:flutter/material.dart';
import '../../../core/theme/tokens/app_spacing.dart';

class ScreenPadding extends StatelessWidget {
  final Widget child;
  final bool horizontal;
  final bool vertical;

  const ScreenPadding({
    super.key,
    required this.child,
    this.horizontal = true,
    this.vertical = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal ? AppSpacing.screenPadding : 0,
        vertical: vertical ? AppSpacing.screenPadding : 0,
      ),
      child: child,
    );
  }
}
