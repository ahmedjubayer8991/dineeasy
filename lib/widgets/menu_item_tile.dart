import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../theme/app_theme.dart';

class MenuItemTile extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onAdd;

  const MenuItemTile({super.key, required this.item, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      padding: const EdgeInsets.all(AppSpacing.s),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.chip),
            child: Image.network(
              item.imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 64,
                height: 64,
                color: AppColors.primaryOrange.withOpacity(0.3),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600)),
                Text(item.description, style: AppTextStyles.caption),
                const SizedBox(height: 4),
                Text('\$${item.price.toStringAsFixed(2)}',
                    style: AppTextStyles.bodyDark.copyWith(
                        color: AppColors.selectedOrange, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          _AddButton(onTap: onAdd),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryOrange.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: AppColors.selectedOrange, size: 20),
      ),
    );
  }
}
