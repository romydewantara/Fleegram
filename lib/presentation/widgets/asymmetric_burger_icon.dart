import 'package:flutter/material.dart';

class AsymmetricBurgerIcon extends StatelessWidget {
  const AsymmetricBurgerIcon({
    super.key,
    this.width = 22,
    this.lineHeight = 3,
    this.spacing = 3,
    this.color,
  });

  final double width;
  final double lineHeight;
  final double spacing;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final resolvedColor =
        color ??
        Theme.of(context).iconTheme.color ??
        Theme.of(context).colorScheme.onSurface;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          _Line(width: width, height: lineHeight, color: resolvedColor),
          SizedBox(height: spacing),
          _Line(width: width * 0.7, height: lineHeight, color: resolvedColor),
          SizedBox(height: spacing),
          _Line(width: width * 0.45, height: lineHeight, color: resolvedColor),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.width, required this.height, required this.color});

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(height),
      ),
    );
  }
}
