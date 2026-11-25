import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../shared/widgets/atmos_icon_button.dart';

class SearchHeader extends StatelessWidget {
  final VoidCallback onBack;

  const SearchHeader({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          AtmosIconButton(
            onPressed: onBack,
            tooltip: 'Back to Weather Dashboard',
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Explore Locations',
                  style: AppTypography.headlineMedium(
                    color: AppColors.onSurface,
                  ).copyWith(height: 1.2),
                ),
                Text(
                  'Find weather anywhere in the world',
                  style: AppTypography.bodySmall(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
