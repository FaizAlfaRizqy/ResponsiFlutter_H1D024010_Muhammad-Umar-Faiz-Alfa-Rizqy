import 'package:flutter/foundation.dart';
import '../datasources/location_local_datasource.dart';
import '../datasources/weather_remote_datasource.dart';
import '../models/location_model.dart';

class LocationRepository extends ChangeNotifier {
  final WeatherRemoteDataSource remoteDataSource;
  final LocationLocalDataSource localDataSource;

  LocationRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<List<LocationModel>> searchCities(String query) async {
    final results = await remoteDataSource.searchCities(query);
    final favorites = await localDataSource.getFavorites();

    // Mark isFavorite flag accurately
    return results.map((result) {
      final isFav = favorites.any((fav) => _isSameLocation(fav, result));
      return result.copyWith(isFavorite: isFav);
    }).toList();
  }

  /// Get favorites instantly from local data source without waiting for network requests
  Future<List<LocationModel>> getLocalFavorites() async {
    final favs = await localDataSource.getFavorites();
    return favs.map((loc) => loc.copyWith(isFavorite: true)).toList();
  }

  /// Fetch live preview temperatures and weather codes for a list of favorite locations
  Future<List<LocationModel>> fetchFavoritesPreviews(List<LocationModel> favs) async {
    final updatedList = await Future.wait(
      favs.map((loc) async {
        try {
          final preview = await remoteDataSource.fetchCurrentPreview(
            latitude: loc.latitude,
            longitude: loc.longitude,
          );
          return loc.copyWith(
            currentTemp: preview['temp'] as double?,
            currentWeatherCode: preview['code'] as int?,
            isFavorite: true,
          );
        } catch (_) {
          return loc.copyWith(isFavorite: true);
        }
      }),
    );

    return updatedList;
  }

  /// Get favorites with live preview temperatures and weather codes
  Future<List<LocationModel>> getFavorites() async {
    final localFavs = await getLocalFavorites();
    return fetchFavoritesPreviews(localFavs);
  }

  Future<bool> toggleFavorite(LocationModel location) async {
    final favs = await localDataSource.getFavorites();
    final index = favs.indexWhere((loc) => _isSameLocation(loc, location));
    bool isNowFavorite;

    if (index >= 0) {
      favs.removeAt(index);
      isNowFavorite = false;
    } else {
      favs.add(location.copyWith(isFavorite: true));
      isNowFavorite = true;
    }

    await localDataSource.saveFavorites(favs);
    notifyListeners();
    return isNowFavorite;
  }

  Future<bool> isFavorite(LocationModel location) async {
    final favs = await localDataSource.getFavorites();
    return favs.any((loc) => _isSameLocation(loc, location));
  }

  Future<LocationModel> getSelectedLocation() {
    return localDataSource.getSelectedLocation();
  }

  Future<void> setSelectedLocation(LocationModel location) {
    return localDataSource.saveSelectedLocation(location);
  }

  Future<List<String>> getSearchHistory() {
    return localDataSource.getSearchHistory();
  }

  Future<void> addSearchHistory(String query) {
    return localDataSource.addSearchHistory(query);
  }

  bool _isSameLocation(LocationModel a, LocationModel b) {
    if (a.id != null && b.id != null && a.id == b.id) {
      return true;
    }
    if (a.name.toLowerCase() == b.name.toLowerCase()) {
      return (a.latitude - b.latitude).abs() < 0.1 &&
          (a.longitude - b.longitude).abs() < 0.1;
    }
    return false;
  }
}
