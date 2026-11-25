class ApiConstants {
  ApiConstants._();

  static const String geocodingBaseUrl = 'https://geocoding-api.open-meteo.com/v1';
  static const String forecastBaseUrl = 'https://api.open-meteo.com/v1';

  static const Duration timeoutDuration = Duration(seconds: 10);
}
