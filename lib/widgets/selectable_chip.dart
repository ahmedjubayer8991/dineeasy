import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A single tappable chip with a clear selected/unselected visual state.
///
/// The selected fill uses AppColors.selectedOrange (#C2410C) rather than
/// the lighter brand orange, specifically because this chip carries white
/// text — see app_theme.dart for the WCAG 2.2 contrast reasoning.
class SelectableChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double? width;

  const SelectableChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.selectedOrange : Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          border: Border.all(
            color: selected ? AppColors.selectedOrange : AppColors.border,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
