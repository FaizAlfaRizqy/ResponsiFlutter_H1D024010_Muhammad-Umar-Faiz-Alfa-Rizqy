import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../data/models/location_model.dart';
import '../../weather/viewmodels/weather_viewmodel.dart';
import '../viewmodels/location_viewmodel.dart';
import '../widgets/empty_favorites_view.dart';
import '../widgets/empty_search_view.dart';
import '../widgets/favorite_locations_grid.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/search_header.dart';
import '../widgets/search_results_list.dart';

class SearchLocationsView extends StatelessWidget {
  final VoidCallback onBackToDashboard;

  const SearchLocationsView({
    super.key,
    required this.onBackToDashboard,
  });

  void _onLocationSelected(BuildContext context, LocationModel location) {
    final weatherVM = context.read<WeatherViewModel>();
    weatherVM.selectLocation(location);
    onBackToDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final locationVM = context.watch<LocationViewModel>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Sticky Contextual Header
            SearchHeader(onBack: onBackToDashboard),

            // Main Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Search Bar
                    SearchBarWidget(
                      initialValue: locationVM.searchQuery,
                      onChanged: (val) => locationVM.onSearchQueryChanged(val),
                      onClear: () => locationVM.clearSearch(),
                      onSubmitted: (val) => locationVM.executeSearch(val),
                    ),

                    const SizedBox(height: 24),

                    // Search Active or Idle States
                    if (locationVM.isSearching)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
                          ),
                        ),
                      )
                    else if (locationVM.searchQuery.isNotEmpty) ...[
                      if (locationVM.hasSearchResults)
                        SearchResultsList(
                          results: locationVM.searchResults,
                          onSelectLocation: (loc) => _onLocationSelected(context, loc),
                          onToggleFavorite: (loc) => locationVM.toggleFavorite(loc),
                        )
                      else if (locationVM.isSearchEmpty)
                        const EmptySearchView()
                      else if (locationVM.searchStatus == LocationSearchStatus.error)
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            locationVM.errorMessage ?? 'An error occurred while searching.',
                            style: AppTypography.bodyMedium(color: AppColors.error),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      const SizedBox(height: 24),
                    ],

                    // Favorite Locations Section
                    if (locationVM.favorites.isNotEmpty)
                      FavoriteLocationsGrid(
                        favorites: locationVM.favorites,
                        onSelectLocation: (loc) => _onLocationSelected(context, loc),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Favorite Locations',
                                style: AppTypography.titleLarge(
                                  color: AppColors.onSurface,
                                ),
                              ),
                              Text(
                                '0 saved',
                                style: AppTypography.labelSmall(
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const EmptyFavoritesView(),
                        ],
                      ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
