import 'package:flutter/material.dart';

class PremiumLockedTile extends StatelessWidget {
  final bool isPaid;
  final Widget child;
  final Widget? foreground;

  const PremiumLockedTile({
    super.key,
    required this.isPaid,
    required this.child,
    this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        AbsorbPointer(
          absorbing: !isPaid,
          child: Opacity(opacity: isPaid ? 1 : 0.5, child: child),
        ),

        if (!isPaid)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

        if (!isPaid && foreground != null)
          Positioned(right: 12, top: 12, child: foreground!),
      ],
    );
  }
}
