import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/location_model.dart';
import '../models/weather_model.dart';

class WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSource({http.Client? client}) : client = client ?? http.Client();

  /// Search cities via Open-Meteo Geocoding API
  Future<List<LocationModel>> searchCities(String query) async {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return [];

    final uri = Uri.parse(
      '${ApiConstants.geocodingBaseUrl}/search?name=${Uri.encodeComponent(cleanQuery)}&count=10&language=en&format=json',
    );

    try {
      final response = await client.get(uri).timeout(ApiConstants.timeoutDuration);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>?;
        if (results == null || results.isEmpty) {
          return [];
        }

        return results
            .map((item) => LocationModel.fromGeocodingJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw HttpException('Geocoding request failed with status: ${response.statusCode}');
      }
    } on SocketException catch (_) {
      throw const SocketException('No Internet connection');
    }
  }

  /// Fetch full weather forecast via Open-Meteo Forecast API
  Future<WeatherModel> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(
      '${ApiConstants.forecastBaseUrl}/forecast'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m'
      '&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max,weather_code'
      '&timezone=auto',
    );

    try {
      final response = await client.get(uri).timeout(ApiConstants.timeoutDuration);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return WeatherModel.fromOpenMeteoJson(data);
      } else {
        throw HttpException('Weather request failed with status: ${response.statusCode}');
      }
    } on SocketException catch (_) {
      throw const SocketException('No Internet connection');
    }
  }

  /// Fetch lightweight current weather for favorite card preview
  Future<Map<String, dynamic>> fetchCurrentPreview({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(
      '${ApiConstants.forecastBaseUrl}/forecast'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&current=temperature_2m,weather_code'
      '&timezone=auto',
    );

    try {
      final response = await client.get(uri).timeout(ApiConstants.timeoutDuration);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final current = data['current'] as Map<String, dynamic>? ?? {};
        return {
          'temp': (current['temperature_2m'] as num?)?.toDouble(),
          'code': (current['weather_code'] as num?)?.toInt(),
        };
      }
    } catch (_) {}
    return {};
  }
}
