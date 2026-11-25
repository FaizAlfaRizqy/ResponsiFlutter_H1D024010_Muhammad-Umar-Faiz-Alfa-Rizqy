import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/app_colors.dart';
import '../viewmodels/weather_viewmodel.dart';
import '../widgets/additional_info_card.dart';
import '../widgets/current_weather_hero_card.dart';
import '../widgets/dashboard_error_view.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_offline_view.dart';
import '../widgets/dashboard_skeleton.dart';
import '../widgets/forecast_horizontal_strip.dart';
import '../widgets/weather_details_grid.dart';

class WeatherDashboardView extends StatelessWidget {
  final VoidCallback onNavigateToSearch;

  const WeatherDashboardView({
    super.key,
    required this.onNavigateToSearch,
  });

  @override
  Widget build(BuildContext context) {
    final weatherVM = context.watch<WeatherViewModel>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Sticky Dashboard Header
            DashboardHeader(
              cityName: weatherVM.currentLocation.name,
              isFavorite: weatherVM.isFavoriteCurrentLocation,
              onToggleFavorite: () {
                weatherVM.toggleFavoriteCurrentLocation();
              },
              onSearchPressed: onNavigateToSearch,
            ),

            // Scrollable Content
            Expanded(
              child: RefreshIndicator(
                color: AppColors.secondary,
                backgroundColor: AppColors.surfaceContainerLowest,
                onRefresh: () async {
                  await weatherVM.fetchWeather();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: _buildBody(context, weatherVM),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WeatherViewModel weatherVM) {
    if (weatherVM.isLoading && weatherVM.weather == null) {
      return const DashboardSkeleton();
    }

    if (weatherVM.isOffline && weatherVM.weather == null) {
      return DashboardOfflineView(
        onRetry: () => weatherVM.fetchWeather(),
      );
    }

    if (weatherVM.isError && weatherVM.weather == null) {
      return DashboardErrorView(
        message: weatherVM.errorMessage,
        onRetry: () => weatherVM.fetchWeather(),
      );
    }

    final weather = weatherVM.weather;
    if (weather == null) {
      return const DashboardSkeleton();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Current Weather Hero Card
        CurrentWeatherHeroCard(
          cityName: weatherVM.currentLocation.name,
          weather: weather,
        ),

        const SizedBox(height: 24),

        // Weather Details 2x2 Grid
        WeatherDetailsGrid(
          humidity: weather.relativeHumidity,
          windSpeed: weather.windSpeed,
          precipitation: weather.precipitation,
          rainProbability: weather.todayPrecipitationProbabilityMax,
        ),

        const SizedBox(height: 24),

        // 5-Day Forecast Strip
        ForecastHorizontalStrip(
          forecasts: weather.dailyForecasts,
        ),

        const SizedBox(height: 24),

        // Additional Information Card
        AdditionalInfoCard(
          weather: weather,
          lastUpdated: weatherVM.lastUpdated,
          isRefreshing: weatherVM.isLoading,
          onRefresh: () => weatherVM.fetchWeather(),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
