import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../shared/widgets/atmos_icon_button.dart';

class DashboardHeader extends StatelessWidget {
  final String cityName;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onSearchPressed;

  const DashboardHeader({
    super.key,
    required this.cityName,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Atmos Brand Mark & Title
          Expanded(
            child: Row(
              children: [
                // Brand Mark
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A0F2942),
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.cloud_outlined,
                        size: 20,
                        color: AppColors.onPrimary,
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.skyGlow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Titles
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Atmos',
                        style: AppTypography.titleMedium(
                          color: AppColors.onSurface,
                        ).copyWith(height: 1.2),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 13,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 2),
                          Flexible(
                            child: Text(
                              cityName,
                              style: AppTypography.labelMedium(
                                color: AppColors.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Actions: Favorite and Search
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AtmosIconButton(
                onPressed: onToggleFavorite,
                tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
                icon: Icon(
                  isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: isFavorite ? AppColors.warningSun : AppColors.onSurfaceVariant,
                  size: 22,
                ),
              ),
              const SizedBox(width: 8),
              AtmosIconButton(
                onPressed: onSearchPressed,
                tooltip: 'Search locations',
                icon: const Icon(
                  Icons.search,
                  color: AppColors.onSurface,
                  size: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
