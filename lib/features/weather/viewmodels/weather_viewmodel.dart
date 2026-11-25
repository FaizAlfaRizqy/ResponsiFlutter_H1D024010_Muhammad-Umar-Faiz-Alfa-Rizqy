import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../data/datasources/location_local_datasource.dart';
import '../../../data/models/location_model.dart';
import '../../../data/models/weather_model.dart';
import '../../../data/repositories/location_repository.dart';
import '../../../data/repositories/weather_repository.dart';

enum WeatherStatus { initial, loading, success, error, offline }

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository weatherRepository;
  final LocationRepository locationRepository;

  WeatherStatus _status = WeatherStatus.initial;
  WeatherModel? _weather;
  LocationModel _currentLocation = LocationLocalDataSource.defaultLocation;
  String? _errorMessage;
  bool _isFavoriteCurrentLocation = false;
  DateTime? _lastUpdated;

  WeatherViewModel({
    required this.weatherRepository,
    required this.locationRepository,
  });

  WeatherStatus get status => _status;
  WeatherModel? get weather => _weather;
  LocationModel get currentLocation => _currentLocation;
  String? get errorMessage => _errorMessage;
  bool get isFavoriteCurrentLocation => _isFavoriteCurrentLocation;
  DateTime? get lastUpdated => _lastUpdated;

  bool get isLoading => _status == WeatherStatus.loading;
  bool get isSuccess => _status == WeatherStatus.success;
  bool get isError => _status == WeatherStatus.error;
  bool get isOffline => _status == WeatherStatus.offline;

  Future<void> init() async {
    _status = WeatherStatus.loading;
    notifyListeners();

    try {
      _currentLocation = await locationRepository.getSelectedLocation();
      _isFavoriteCurrentLocation = await locationRepository.isFavorite(_currentLocation);
      await fetchWeather();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> fetchWeather() async {
    _status = WeatherStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await weatherRepository.getWeather(
        latitude: _currentLocation.latitude,
        longitude: _currentLocation.longitude,
      );
      _weather = data;
      _lastUpdated = DateTime.now();
      _status = WeatherStatus.success;
      notifyListeners();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> selectLocation(LocationModel location) async {
    _currentLocation = location;
    await locationRepository.setSelectedLocation(location);
    _isFavoriteCurrentLocation = await locationRepository.isFavorite(location);
    notifyListeners();
    await fetchWeather();
  }

  Future<void> toggleFavoriteCurrentLocation() async {
    final updated = await locationRepository.toggleFavorite(_currentLocation);
    _isFavoriteCurrentLocation = updated;
    notifyListeners();
  }

  void _handleError(Object error) {
    if (error is SocketException) {
      _status = WeatherStatus.offline;
      _errorMessage = 'No internet connection';
    } else {
      _status = WeatherStatus.error;
      _errorMessage = error.toString();
    }
    notifyListeners();
  }
}
