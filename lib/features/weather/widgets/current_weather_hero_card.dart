import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/utils/weather_code_helper.dart';
import '../../../data/models/weather_model.dart';
import 'weather_illustration.dart';

class CurrentWeatherHeroCard extends StatelessWidget {
  final String cityName;
  final WeatherModel weather;

  const CurrentWeatherHeroCard({
    super.key,
    required this.cityName,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    final codeInfo = WeatherCodeHelper.getInfo(
      weather.weatherCode,
      windSpeed: weather.windSpeed,
      precipitation: weather.precipitation,
    );

    final tempInt = weather.currentTemperature.round();
    final feelsLikeInt = weather.apparentTemperature.round();
    final dateTimeStr = DateFormatter.formatHeroDateTime(weather.time);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.heroGradient,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x260F2942),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Location & Live pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.near_me,
                          size: 16,
                          color: AppColors.skyGlow,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            cityName,
                            style: AppTypography.headlineMedium(
                              color: AppColors.onPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateTimeStr,
                      style: AppTypography.bodySmall(
                        color: AppColors.primaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'Live',
                  style: AppTypography.labelSmall(
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Main row: Temp, condition, feels like & Illustration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$tempInt°C',
                      style: AppTypography.displayLargeMobile(
                        color: AppColors.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      codeInfo.description,
                      style: AppTypography.titleMedium(
                        color: AppColors.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Feels like $feelsLikeInt°C',
                      style: AppTypography.bodyMedium(
                        color: AppColors.primaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              WeatherIllustration(
                weatherCode: weather.weatherCode,
                size: 96,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
