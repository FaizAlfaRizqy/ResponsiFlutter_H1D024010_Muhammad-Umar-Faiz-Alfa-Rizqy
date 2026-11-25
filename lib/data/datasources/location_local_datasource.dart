import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/location_model.dart';

class LocationLocalDataSource {
  static const String _keyFavorites = 'atmos_favorite_locations';
  static const String _keySelectedLocation = 'atmos_selected_location';
  static const String _keySearchHistory = 'atmos_search_history';

  // Default initial location matching Stitch: San Francisco
  static const LocationModel defaultLocation = LocationModel(
    id: 5391959,
    name: 'San Francisco',
    region: 'California, United States',
    country: 'United States',
    latitude: 37.7749,
    longitude: -122.4194,
    isFavorite: true,
  );

  // Default initial favorites matching Stitch
  static const List<LocationModel> defaultFavorites = [
    LocationModel(
      id: 5391959,
      name: 'San Francisco',
      region: 'California, United States',
      country: 'United States',
      latitude: 37.7749,
      longitude: -122.4194,
      isFavorite: true,
    ),
    LocationModel(
      id: 2657896,
      name: 'Zurich',
      region: 'Zurich, Switzerland',
      country: 'Switzerland',
      latitude: 47.3667,
      longitude: 8.55,
      isFavorite: true,
    ),
  ];

  Future<List<LocationModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_keyFavorites);

    if (rawList == null) {
      // First time launch: save default favorites
      await saveFavorites(defaultFavorites);
      return defaultFavorites;
    }

    return rawList
        .map((str) => LocationModel.fromJson(json.decode(str) as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveFavorites(List<LocationModel> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = favorites.map((loc) => json.encode(loc.toJson())).toList();
    await prefs.setStringList(_keyFavorites, stringList);
  }

  Future<LocationModel> getSelectedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keySelectedLocation);
    if (raw != null) {
      try {
        return LocationModel.fromJson(json.decode(raw) as Map<String, dynamic>);
      } catch (_) {}
    }
    return defaultLocation;
  }

  Future<void> saveSelectedLocation(LocationModel location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keySelectedLocation, json.encode(location.toJson()));
  }

  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keySearchHistory) ?? [];
  }

  Future<void> addSearchHistory(String query) async {
    final clean = query.trim();
    if (clean.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList(_keySearchHistory) ?? [];
    current.remove(clean);
    current.insert(0, clean);
    if (current.length > 10) {
      current.removeLast();
    }
    await prefs.setStringList(_keySearchHistory, current);
  }

  Future<void> clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keySearchHistory);
  }
}
