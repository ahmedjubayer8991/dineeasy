import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/restaurant.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/menu_item_tile.dart';
import '../widgets/selectable_chip.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _selectedCategory = menuCategories.first; // 'Popular'

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final restaurant = args is Restaurant ? args : mockRestaurants.first;

    final items = casaVeronaMenu.where((item) {
      if (_selectedCategory == 'Popular') return item.popular;
      return item.category == _selectedCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('${restaurant.name} Menu'),
        actions: const [Padding(padding: EdgeInsets.only(right: 16), child: Icon(Icons.search))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: menuCategories.length,
                separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.s),
                itemBuilder: (context, i) {
                  final category = menuCategories[i];
                  return SelectableChip(
                    label: category,
                    selected: _selectedCategory == category,
                    onTap: () => setState(() => _selectedCategory = category),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.m),
            const Text('Popular dishes', style: AppTextStyles.subheading),
            const SizedBox(height: AppSpacing.s),
            Expanded(
              child: items.isEmpty
                  ? const Center(child: Text('No dishes in this category yet.', style: AppTextStyles.body))
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        final item = items[i];
                        return MenuItemTile(
                          item: item,
                          onAdd: () {
                            setState(() => AppState.instance.addToCart(item));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${item.name} added to cart'),
                                duration: const Duration(milliseconds: 900),
                                backgroundColor: AppColors.selectedOrange,
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: AppState.instance.cartItemCount > 0
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.selectedOrange,
              onPressed: () => Navigator.pushNamed(context, '/cart', arguments: restaurant),
              icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
              label: Text(
                'Cart (${AppState.instance.cartItemCount})',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            )
          : null,
    );
  }
}
