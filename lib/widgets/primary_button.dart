import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A branded, full-width rounded button. Set [outlined] to true for the
/// secondary/outline style (e.g. "View Menu", "Continue with Google").
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool outlined;
  final bool expanded;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = outlined
        ? OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.selectedOrange),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
              ),
            ),
            child: Text(label, style: AppTextStyles.buttonOutline),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.selectedOrange,
              disabledBackgroundColor: AppColors.selectedOrange.withOpacity(0.4),
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
              ),
            ),
            child: Text(label, style: AppTextStyles.button),
          );

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
