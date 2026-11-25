import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../data/models/location_model.dart';
import '../../../data/repositories/location_repository.dart';

enum LocationSearchStatus { idle, searching, success, empty, error }

class LocationViewModel extends ChangeNotifier {
  final LocationRepository locationRepository;

  LocationSearchStatus _searchStatus = LocationSearchStatus.idle;
  List<LocationModel> _searchResults = [];
  List<LocationModel> _favorites = [];
  List<String> _searchHistory = [];
  String _searchQuery = '';
  bool _isLoadingFavorites = false;
  String? _errorMessage;

  Timer? _debounceTimer;

  LocationViewModel({required this.locationRepository});

  LocationSearchStatus get searchStatus => _searchStatus;
  List<LocationModel> get searchResults => _searchResults;
  List<LocationModel> get favorites => _favorites;
  List<String> get searchHistory => _searchHistory;
  String get searchQuery => _searchQuery;
  bool get isLoadingFavorites => _isLoadingFavorites;
  String? get errorMessage => _errorMessage;

  bool get isSearching => _searchStatus == LocationSearchStatus.searching;
  bool get isSearchEmpty => _searchStatus == LocationSearchStatus.empty;
  bool get hasSearchResults => _searchResults.isNotEmpty;

  Future<void> init() async {
    await loadFavorites();
    await loadSearchHistory();
  }

  Future<void> loadFavorites() async {
    _isLoadingFavorites = true;
    notifyListeners();

    try {
      _favorites = await locationRepository.getFavorites();
    } catch (_) {}

    _isLoadingFavorites = false;
    notifyListeners();
  }

  Future<void> loadSearchHistory() async {
    try {
      _searchHistory = await locationRepository.getSearchHistory();
      notifyListeners();
    } catch (_) {}
  }

  void onSearchQueryChanged(String query) {
    _searchQuery = query;
    _debounceTimer?.cancel();

    if (query.trim().isEmpty) {
      _searchResults = [];
      _searchStatus = LocationSearchStatus.idle;
      notifyListeners();
      return;
    }

    _searchStatus = LocationSearchStatus.searching;
    notifyListeners();

    _debounceTimer = Timer(const Duration(milliseconds: 350), () {
      executeSearch(query);
    });
  }

  Future<void> executeSearch(String query) async {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) {
      _searchResults = [];
      _searchStatus = LocationSearchStatus.idle;
      notifyListeners();
      return;
    }

    _searchStatus = LocationSearchStatus.searching;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await locationRepository.searchCities(cleanQuery);
      _searchResults = results;
      _searchStatus = results.isEmpty ? LocationSearchStatus.empty : LocationSearchStatus.success;
      if (results.isNotEmpty) {
        await locationRepository.addSearchHistory(cleanQuery);
        await loadSearchHistory();
      }
    } catch (e) {
      _searchStatus = LocationSearchStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    _searchQuery = '';
    _searchResults = [];
    _searchStatus = LocationSearchStatus.idle;
    notifyListeners();
  }

  Future<void> toggleFavorite(LocationModel location) async {
    final isFav = await locationRepository.toggleFavorite(location);

    // Update search results isFavorite state if present
    final index = _searchResults.indexWhere((loc) => _isSameLocation(loc, location));
    if (index >= 0) {
      _searchResults[index] = _searchResults[index].copyWith(isFavorite: isFav);
    }

    // Refresh favorites list
    await loadFavorites();
    notifyListeners();
  }

  bool _isSameLocation(LocationModel a, LocationModel b) {
    if (a.name.toLowerCase() == b.name.toLowerCase()) {
      return (a.latitude - b.latitude).abs() < 0.1 &&
          (a.longitude - b.longitude).abs() < 0.1;
    }
    return false;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
