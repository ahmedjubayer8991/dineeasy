import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/restaurant.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/selectable_chip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCuisine = cuisineFilters.first;
  final _searchController = TextEditingController();

  void _openDetails(Restaurant restaurant) {
    Navigator.pushNamed(context, '/restaurant-details', arguments: restaurant);
  }

  @override
  Widget build(BuildContext context) {
    final featured = mockRestaurants.first; // Casa Verona
    final popular = mockRestaurants.sublist(1); // Saffron Table, Harbour Grill

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(AppSpacing.l, AppSpacing.m, AppSpacing.l, AppSpacing.m),
          children: [
            const Text('Good evening, Alex', style: AppTextStyles.body),
            const SizedBox(height: 4),
            const Text('What are you craving?', style: AppTextStyles.heading),
            const SizedBox(height: AppSpacing.m),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search restaurant or cuisine',
                prefixIcon: Icon(Icons.search, color: AppColors.textMuted),
              ),
            ),
            const SizedBox(height: AppSpacing.m),
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: cuisineFilters.length,
                separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.s),
                itemBuilder: (context, i) {
                  final cuisine = cuisineFilters[i];
                  return SelectableChip(
                    label: cuisine,
                    selected: _selectedCuisine == cuisine,
                    onTap: () => setState(() => _selectedCuisine = cuisine),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Featured near you', style: AppTextStyles.subheading),
                TextButton(
                  onPressed: () {},
                  child: const Text('See all', style: TextStyle(color: AppColors.selectedOrange)),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s),
            FeaturedRestaurantCard(
              restaurant: featured,
              onTap: () => _openDetails(featured),
            ),
            const SizedBox(height: AppSpacing.l),
            const Text('Popular tonight', style: AppTextStyles.subheading),
            const SizedBox(height: AppSpacing.s),
            ...popular.map(
              (r) => PopularRestaurantTile(restaurant: r, onTap: () => _openDetails(r)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(current: AppTab.home),
    );
  }
}
