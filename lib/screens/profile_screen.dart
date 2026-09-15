import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showNotImplemented(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature is not implemented in this prototype.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.l),
          children: [
            const Text('Profile', style: AppTextStyles.heading),
            const SizedBox(height: AppSpacing.l),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.l),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppRadius.card)),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.selectedOrange,
                    child: Text('A', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: AppSpacing.s),
                  const Text('Alex Morgan', style: AppTextStyles.subheading),
                  const Text('alex@example.com', style: AppTextStyles.body),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            _ProfileRow(
              icon: Icons.restaurant_menu,
              label: 'Dietary preferences',
              onTap: () => _showNotImplemented(context, 'Dietary preferences'),
            ),
            _ProfileRow(
              icon: Icons.notifications_none,
              label: 'Notifications',
              onTap: () => _showNotImplemented(context, 'Notifications'),
            ),
            _ProfileRow(
              icon: Icons.lock_outline,
              label: 'Privacy',
              onTap: () => _showNotImplemented(context, 'Privacy'),
            ),
            const SizedBox(height: AppSpacing.l),
            _ProfileRow(
              icon: Icons.logout,
              label: 'Log out',
              destructive: true,
              onTap: () {
                AppState.instance.clearCart();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(current: AppTab.profile),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  const _ProfileRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = destructive ? Colors.redAccent : AppColors.textDark;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppRadius.chip)),
      child: ListTile(
        leading: Icon(icon, color: destructive ? Colors.redAccent : AppColors.selectedOrange),
        title: Text(label, style: AppTextStyles.bodyDark.copyWith(color: color, fontWeight: FontWeight.w600)),
        trailing: destructive ? null : const Icon(Icons.chevron_right, color: AppColors.textMuted),
        onTap: onTap,
      ),
    );
  }
}
