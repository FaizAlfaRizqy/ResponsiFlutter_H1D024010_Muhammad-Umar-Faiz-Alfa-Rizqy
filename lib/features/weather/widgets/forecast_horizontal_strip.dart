import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/utils/weather_code_helper.dart';
import '../../../data/models/daily_forecast_model.dart';
import '../../../shared/widgets/atmos_card.dart';

class ForecastHorizontalStrip extends StatelessWidget {
  final List<DailyForecastModel> forecasts;

  const ForecastHorizontalStrip({
    super.key,
    required this.forecasts,
  });

  @override
  Widget build(BuildContext context) {
    // Show 5 to 7 days
    final items = forecasts.take(7).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '5-Day Forecast',
              style: AppTypography.titleLarge(
                color: AppColors.onSurface,
              ),
            ),
            Text(
              'Daily highs & lows',
              style: AppTypography.labelSmall(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Forecast Horizontal Scroll List
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final forecast = items[index];
              return _buildForecastCard(forecast);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildForecastCard(DailyForecastModel forecast) {
    final dayOfWeek = DateFormatter.getDayOfWeek(forecast.date);
    final monthDay = DateFormatter.getMonthDay(forecast.date);
    final codeInfo = WeatherCodeHelper.getInfo(forecast.weatherCode);

    final maxTempInt = forecast.maxTemp.round();
    final minTempInt = forecast.minTemp.round();

    return AtmosCard(
      borderRadius: 12,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: SizedBox(
        width: 76,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Day and Date
            Column(
              children: [
                Text(
                  dayOfWeek,
                  style: AppTypography.labelMedium(
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  monthDay,
                  style: AppTypography.bodySmall(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            // Weather Icon
            Icon(
              codeInfo.icon,
              size: 24,
              color: codeInfo.iconColor,
            ),

            // Temps (High / Low)
            Column(
              children: [
                Text(
                  '$maxTempInt°',
                  style: AppTypography.labelLarge(
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  '$minTempInt°',
                  style: AppTypography.bodySmall(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            // Rain Probability
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.water_drop,
                  size: 11,
                  color: AppColors.secondary,
                ),
                const SizedBox(width: 2),
                Text(
                  '${forecast.precipitationProbabilityMax}%',
                  style: AppTypography.labelSmall(
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
