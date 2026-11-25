import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../data/models/location_model.dart';
import '../../../shared/widgets/atmos_card.dart';

class SearchResultsList extends StatelessWidget {
  final List<LocationModel> results;
  final ValueChanged<LocationModel> onSelectLocation;
  final ValueChanged<LocationModel> onToggleFavorite;

  const SearchResultsList({
    super.key,
    required this.results,
    required this.onSelectLocation,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final countText = '${results.length} ${results.length == 1 ? 'city' : 'cities'}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search Results',
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

        // List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: results.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final loc = results[index];
            return _buildResultCard(loc);
          },
        ),
      ],
    );
  }

  Widget _buildResultCard(LocationModel loc) {
    return AtmosCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 16,
      onTap: () => onSelectLocation(loc),
      child: Row(
        children: [
          // Location pin icon in circular container
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryContainer,
            ),
            child: const Icon(
              Icons.location_on,
              color: AppColors.secondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // City and Region
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  loc.name,
                  style: AppTypography.titleSmall(
                    color: AppColors.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  loc.region,
                  style: AppTypography.bodySmall(
                    color: AppColors.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Favorite toggle button
          IconButton(
            icon: Icon(
              loc.isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
              color: loc.isFavorite ? AppColors.warningSun : AppColors.onSurfaceVariant,
              size: 22,
            ),
            splashRadius: 20,
            onPressed: () => onToggleFavorite(loc),
          ),
        ],
      ),
    );
  }
}
