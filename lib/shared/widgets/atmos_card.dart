import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class AtmosCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final Border? border;

  const AtmosCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 16,
    this.backgroundColor,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: backgroundColor ?? AppColors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(borderRadius),
      border: border ??
          Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.4),
            width: 1,
          ),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0F0F2942),
          blurRadius: 16,
          offset: Offset(0, 4),
        ),
      ],
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: padding,
            decoration: decoration,
            child: child,
          ),
        ),
      );
    }

    return Container(
      padding: padding,
      decoration: decoration,
      child: child,
    );
  }
}
