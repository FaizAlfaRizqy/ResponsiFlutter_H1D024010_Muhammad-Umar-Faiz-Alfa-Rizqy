import 'package:flutter_test/flutter_test.dart';
import 'package:atmos/core/utils/weather_code_helper.dart';
import 'package:atmos/core/utils/date_formatter.dart';
import 'package:atmos/data/models/location_model.dart';
import 'package:atmos/data/models/weather_model.dart';

void main() {
  group('WeatherCodeHelper Tests', () {
    test('Code 0 returns Clear Sky', () {
      final info = WeatherCodeHelper.getInfo(0);
      expect(info.description, 'Clear Sky');
    });

    test('Code 2 returns Partly Cloudy', () {
      final info = WeatherCodeHelper.getInfo(2);
      expect(info.description, 'Partly Cloudy');
    });

    test('Code 61 returns Light Rain', () {
      final info = WeatherCodeHelper.getInfo(61);
      expect(info.description, 'Light Rain');
    });
  });

  group('DateFormatter Tests', () {
    test('formats day of week and month day properly', () {
      expect(DateFormatter.getDayOfWeek('2026-11-25'), 'Wed');
      expect(DateFormatter.getMonthDay('2026-11-25'), 'Nov 25');
    });
  });

  group('LocationModel Tests', () {
    test('creates from geocoding json correctly', () {
      final json = {
        'id': 12345,
        'name': 'Tokyo',
        'latitude': 35.6895,
        'longitude': 139.6917,
        'country': 'Japan',
        'admin1': 'Tokyo',
      };
      final loc = LocationModel.fromGeocodingJson(json);
      expect(loc.name, 'Tokyo');
      expect(loc.country, 'Japan');
      expect(loc.latitude, 35.6895);
      expect(loc.longitude, 139.6917);
    });
  });

  group('WeatherModel Tests', () {
    test('parses open meteo json properly', () {
      final json = {
        'current': {
          'time': '2026-11-25T12:00',
          'temperature_2m': 18.5,
          'relative_humidity_2m': 64,
          'apparent_temperature': 16.2,
          'precipitation': 0.2,
          'weather_code': 2,
          'wind_speed_10m': 14.1,
        },
        'daily': {
          'time': ['2026-11-25', '2026-11-26'],
          'temperature_2m_max': [19.0, 17.5],
          'temperature_2m_min': [11.0, 10.2],
          'precipitation_probability_max': [25, 10],
          'weather_code': [0, 2],
        }
      };

      final model = WeatherModel.fromOpenMeteoJson(json);
      expect(model.currentTemperature, 18.5);
      expect(model.relativeHumidity, 64);
      expect(model.apparentTemperature, 16.2);
      expect(model.precipitation, 0.2);
      expect(model.weatherCode, 2);
      expect(model.windSpeed, 14.1);
      expect(model.dailyForecasts.length, 2);
      expect(model.dailyForecasts[0].maxTemp, 19.0);
      expect(model.dailyForecasts[0].minTemp, 11.0);
      expect(model.todayPrecipitationProbabilityMax, 25);
    });
  });
}
