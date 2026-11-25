import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../shared/widgets/atmos_card.dart';

class DashboardOfflineView extends StatelessWidget {
  final VoidCallback onRetry;

  const DashboardOfflineView({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: AtmosCard(
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
                Icons.wifi_off_rounded,
                color: AppColors.secondary,
                size: 26,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'No internet connection',
              style: AppTypography.titleLarge(
                color: AppColors.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Connect to Wi-Fi or mobile data to fetch live weather updates.',
              style: AppTypography.bodyMedium(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(
                'Retry connection',
                style: AppTypography.labelLarge(
                  color: AppColors.onSecondary,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: AppColors.onSecondary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: const StadiumBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
