import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class AtmosIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final Color? backgroundColor;
  final Color? borderColor;

  const AtmosIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.size = 40,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor ?? AppColors.surfaceContainerLowest,
            border: Border.all(
              color: borderColor ?? AppColors.outlineVariant.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: icon,
        ),
      ),
    );
  }
}
