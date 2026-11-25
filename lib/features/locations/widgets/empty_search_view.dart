import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../shared/widgets/atmos_card.dart';

class EmptySearchView extends StatelessWidget {
  const EmptySearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return AtmosCard(
      padding: const EdgeInsets.all(24),
      borderRadius: 16,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryContainer,
            ),
            child: const Icon(
              Icons.search_off_rounded,
              color: AppColors.secondary,
              size: 26,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'No locations found',
            style: AppTypography.titleMedium(
              color: AppColors.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'Check the spelling or try searching for a nearby city or administrative region.',
            style: AppTypography.bodySmall(
              color: AppColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
