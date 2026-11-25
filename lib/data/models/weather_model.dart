import 'daily_forecast_model.dart';

class WeatherModel {
  final double currentTemperature;
  final int relativeHumidity;
  final double apparentTemperature;
  final double precipitation;
  final int weatherCode;
  final double windSpeed;
  final DateTime time;
  final List<DailyForecastModel> dailyForecasts;

  const WeatherModel({
    required this.currentTemperature,
    required this.relativeHumidity,
    required this.apparentTemperature,
    required this.precipitation,
    required this.weatherCode,
    required this.windSpeed,
    required this.time,
    required this.dailyForecasts,
  });

  /// Get today's max precipitation probability from daily forecast
  int get todayPrecipitationProbabilityMax {
    if (dailyForecasts.isNotEmpty) {
      return dailyForecasts.first.precipitationProbabilityMax;
    }
    return 0;
  }

  factory WeatherModel.fromOpenMeteoJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>? ?? {};
    final daily = json['daily'] as Map<String, dynamic>? ?? {};

    final currentTemp = (current['temperature_2m'] as num?)?.toDouble() ?? 0.0;
    final humidity = (current['relative_humidity_2m'] as num?)?.toInt() ?? 0;
    final apparentTemp = (current['apparent_temperature'] as num?)?.toDouble() ?? currentTemp;
    final precip = (current['precipitation'] as num?)?.toDouble() ?? 0.0;
    final weatherCode = (current['weather_code'] as num?)?.toInt() ?? 0;
    final wind = (current['wind_speed_10m'] as num?)?.toDouble() ?? 0.0;

    DateTime parsedTime;
    final timeStr = current['time'] as String?;
    if (timeStr != null) {
      parsedTime = DateTime.tryParse(timeStr) ?? DateTime.now();
    } else {
      parsedTime = DateTime.now();
    }

    // Parse daily forecast
    final dailyTimes = (daily['time'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
    final dailyMaxTemps = (daily['temperature_2m_max'] as List<dynamic>?)
            ?.map((e) => (e as num).toDouble())
            .toList() ??
        [];
    final dailyMinTemps = (daily['temperature_2m_min'] as List<dynamic>?)
            ?.map((e) => (e as num).toDouble())
            .toList() ??
        [];
    final dailyPrecipProb = (daily['precipitation_probability_max'] as List<dynamic>?)
            ?.map((e) => (e as num).toInt())
            .toList() ??
        [];
    final dailyCodes = (daily['weather_code'] as List<dynamic>?)
            ?.map((e) => (e as num).toInt())
            .toList() ??
        [];

    final count = [
      dailyTimes.length,
      dailyMaxTemps.length,
      dailyMinTemps.length,
      dailyPrecipProb.length,
      dailyCodes.length,
    ].reduce((min, val) => val < min ? val : min);

    final forecasts = <DailyForecastModel>[];
    for (int i = 0; i < count; i++) {
      forecasts.add(
        DailyForecastModel(
          date: dailyTimes[i],
          maxTemp: dailyMaxTemps[i],
          minTemp: dailyMinTemps[i],
          precipitationProbabilityMax: dailyPrecipProb[i],
          weatherCode: dailyCodes[i],
        ),
      );
    }

    return WeatherModel(
      currentTemperature: currentTemp,
      relativeHumidity: humidity,
      apparentTemperature: apparentTemp,
      precipitation: precip,
      weatherCode: weatherCode,
      windSpeed: wind,
      time: parsedTime,
      dailyForecasts: forecasts,
    );
  }
}
