import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum AppTab { home, menu, bookings, profile }

/// Shared bottom navigation, present on every "post-login" screen.
/// Uses simple named-route navigation on tap rather than an IndexedStack,
/// which is a reasonable, explainable simplification for a prototype-scope
/// app built without an external navigation package.
class AppBottomNav extends StatelessWidget {
  final AppTab current;

  const AppBottomNav({super.key, required this.current});

  void _onTap(BuildContext context, AppTab tab) {
    if (tab == current) return;
    switch (tab) {
      case AppTab.home:
        Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
        break;
      case AppTab.menu:
        // No restaurant context from the nav bar itself, so default to
        // the primary restaurant used throughout the flow.
        Navigator.pushNamed(context, '/menu');
        break;
      case AppTab.bookings:
        Navigator.pushNamed(context, '/my-bookings');
        break;
      case AppTab.profile:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, -2)),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(context, AppTab.home, Icons.home_rounded, 'Home'),
          _navItem(context, AppTab.menu, Icons.menu_rounded, 'Menu'),
          _navItem(context, AppTab.bookings, Icons.bookmark_border_rounded, 'Bookings'),
          _navItem(context, AppTab.profile, Icons.person_outline_rounded, 'Profile'),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, AppTab tab, IconData icon, String label) {
    final active = tab == current;
    final color = active ? AppColors.selectedOrange : AppColors.textMuted;
    return InkWell(
      onTap: () => _onTap(context, tab),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: color, fontSize: 11)),
        ],
      ),
    );
  }
}
