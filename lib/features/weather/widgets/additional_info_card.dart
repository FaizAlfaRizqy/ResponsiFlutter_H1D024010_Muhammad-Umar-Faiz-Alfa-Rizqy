import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/utils/weather_code_helper.dart';
import '../../../data/models/weather_model.dart';
import '../../../shared/widgets/atmos_icon_button.dart';

class AdditionalInfoCard extends StatelessWidget {
  final WeatherModel weather;
  final DateTime? lastUpdated;
  final VoidCallback onRefresh;
  final bool isRefreshing;

  const AdditionalInfoCard({
    super.key,
    required this.weather,
    required this.lastUpdated,
    required this.onRefresh,
    this.isRefreshing = false,
  });

  @override
  Widget build(BuildContext context) {
    final codeInfo = WeatherCodeHelper.getInfo(
      weather.weatherCode,
      windSpeed: weather.windSpeed,
      precipitation: weather.precipitation,
    );

    final updatedStr = lastUpdated != null
        ? DateFormatter.formatLastUpdated(lastUpdated!)
        : 'Open-Meteo Live Forecast';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  codeInfo.note,
                  style: AppTypography.titleSmall(
                    color: AppColors.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  updatedStr,
                  style: AppTypography.bodySmall(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          AtmosIconButton(
            size: 36,
            onPressed: isRefreshing ? null : onRefresh,
            tooltip: 'Refresh weather data',
            borderColor: AppColors.outlineVariant.withValues(alpha: 0.4),
            icon: isRefreshing
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
                    ),
                  )
                : const Icon(
                    Icons.refresh,
                    size: 20,
                    color: AppColors.secondary,
                  ),
          ),
        ],
      ),
    );
  }
}
