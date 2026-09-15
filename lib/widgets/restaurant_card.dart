import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/app_theme.dart';

/// The large "Featured near you" card style, with the image hero and
/// rating badge overlay.
class FeaturedRestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;

  const FeaturedRestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: const [
            BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4)),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  restaurant.imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 150,
                    color: AppColors.primaryOrange.withOpacity(0.3),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: _RatingBadge(rating: restaurant.rating),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name, style: AppTextStyles.subheading),
                  const SizedBox(height: 4),
                  Text(
                    '${restaurant.cuisine} • ${restaurant.distanceKm} • ${restaurant.priceRange}',
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 4),
                  Text('Open until 11:00 PM',
                      style: AppTextStyles.body.copyWith(color: AppColors.success)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The compact list-row style used under "Popular tonight".
class PopularRestaurantTile extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;

  const PopularRestaurantTile({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.s),
        padding: const EdgeInsets.all(AppSpacing.s),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.chip),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.chip),
              child: Image.network(
                restaurant.imageUrl,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 56,
                  height: 56,
                  color: AppColors.primaryOrange.withOpacity(0.3),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.s),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name, style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600)),
                  Text(restaurant.cuisine, style: AppTextStyles.caption),
                ],
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star_rounded, size: 16, color: AppColors.selectedOrange),
                const SizedBox(width: 2),
                Text('${restaurant.rating}', style: AppTextStyles.bodyDark),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final double rating;
  const _RatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 14, color: AppColors.selectedOrange),
          const SizedBox(width: 2),
          Text('$rating', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
