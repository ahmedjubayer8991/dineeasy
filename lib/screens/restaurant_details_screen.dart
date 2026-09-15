import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  const RestaurantDetailsScreen({super.key});

  @override
  State<RestaurantDetailsScreen> createState() => _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  bool _favourited = false;

  @override
  Widget build(BuildContext context) {
    final restaurant = ModalRoute.of(context)!.settings.arguments as Restaurant;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  restaurant.imageUrl,
                  height: 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 260,
                    color: AppColors.primaryOrange.withOpacity(0.3),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.m),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _CircleIconButton(
                          icon: Icons.arrow_back,
                          onTap: () => Navigator.pop(context),
                        ),
                        _CircleIconButton(
                          icon: _favourited ? Icons.favorite : Icons.favorite_border,
                          iconColor: _favourited ? Colors.red : Colors.black87,
                          onTap: () => setState(() => _favourited = !_favourited),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, size: 14, color: AppColors.selectedOrange),
                        Text(' ${restaurant.rating}', style: const TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name, style: AppTextStyles.heading),
                  const SizedBox(height: 4),
                  Text(
                    '${restaurant.cuisine} • ${restaurant.distanceKm} • ${restaurant.priceRange}',
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text('Open now', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 8),
                      Text(restaurant.hours, style: AppTextStyles.body),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.l),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(icon: Icons.location_on_outlined, value: restaurant.distanceKm, label: 'Distance'),
                      _StatChip(icon: Icons.access_time, value: restaurant.avgWait, label: 'Avg. wait'),
                      _StatChip(icon: Icons.star_rounded, value: '${restaurant.rating}', label: restaurant.reviewCount),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.l),
                  const Text('About', style: AppTextStyles.subheading),
                  const SizedBox(height: 6),
                  Text(restaurant.about, style: AppTextStyles.body),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          label: 'View Menu',
                          outlined: true,
                          onPressed: () => Navigator.pushNamed(context, '/menu', arguments: restaurant),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s),
                      Expanded(
                        child: PrimaryButton(
                          label: 'Book Table',
                          onPressed: () => Navigator.pushNamed(context, '/table-booking', arguments: restaurant),
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
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatChip({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryOrange.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.selectedOrange, size: 20),
        ),
        const SizedBox(height: 6),
        Text(value, style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w700)),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _CircleIconButton({required this.icon, required this.onTap, this.iconColor = Colors.black87});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}
