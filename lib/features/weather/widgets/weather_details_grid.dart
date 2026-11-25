import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../shared/widgets/atmos_card.dart';

class WeatherDetailsGrid extends StatelessWidget {
  final int humidity;
  final double windSpeed;
  final double precipitation;
  final int rainProbability;

  const WeatherDetailsGrid({
    super.key,
    required this.humidity,
    required this.windSpeed,
    required this.precipitation,
    required this.rainProbability,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Weather Details',
              style: AppTypography.titleLarge(
                color: AppColors.onSurface,
              ),
            ),
            Text(
              'Current metrics',
              style: AppTypography.labelSmall(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // 2x2 Grid
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                icon: Icons.water_drop_outlined,
                iconColor: AppColors.secondary,
                label: 'Humidity',
                value: '$humidity%',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                icon: Icons.air,
                iconColor: AppColors.secondary,
                label: 'Wind Speed',
                value: '${windSpeed.round()} km/h',
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                icon: Icons.grain_rounded,
                iconColor: AppColors.tertiary,
                label: 'Precipitation',
                value: '${precipitation.toStringAsFixed(1)} mm',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                icon: Icons.umbrella_outlined,
                iconColor: AppColors.tertiary,
                label: 'Rain Prob.',
                value: '$rainProbability%',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return AtmosCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: AppTypography.labelMedium(
                    color: AppColors.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTypography.headlineLargeMobile(
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
