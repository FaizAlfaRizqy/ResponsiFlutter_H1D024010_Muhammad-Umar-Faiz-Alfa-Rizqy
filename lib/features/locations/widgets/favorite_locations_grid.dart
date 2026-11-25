import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/utils/weather_code_helper.dart';
import '../../../data/models/location_model.dart';
import '../../../shared/widgets/atmos_card.dart';

class FavoriteLocationsGrid extends StatelessWidget {
  final List<LocationModel> favorites;
  final ValueChanged<LocationModel> onSelectLocation;

  const FavoriteLocationsGrid({
    super.key,
    required this.favorites,
    required this.onSelectLocation,
  });

  @override
  Widget build(BuildContext context) {
    final countText = '${favorites.length} saved';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
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
              countText,
              style: AppTypography.labelSmall(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Grid / List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: favorites.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final loc = favorites[index];
            return _buildFavoriteCard(loc);
          },
        ),
      ],
    );
  }

  Widget _buildFavoriteCard(LocationModel loc) {
    final codeInfo = WeatherCodeHelper.getInfo(loc.currentWeatherCode);
    final tempStr = loc.currentTemp != null ? '${loc.currentTemp!.round()}°C' : '--°C';

    return AtmosCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      borderRadius: 16,
      onTap: () => onSelectLocation(loc),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: star, city name, country
          Expanded(
            child: Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: AppColors.warningSun,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        loc.name,
                        style: AppTypography.titleMedium(
                          color: AppColors.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        loc.country,
                        style: AppTypography.bodySmall(
                          color: AppColors.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Right: weather icon and temp
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                codeInfo.icon,
                color: codeInfo.iconColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                tempStr,
                style: AppTypography.headlineMedium(
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
