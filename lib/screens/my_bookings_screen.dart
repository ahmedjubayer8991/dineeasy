import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

/// Displays the just-confirmed booking (via AppState.instance.lastBooking)
/// plus a couple of hardcoded "past bookings" for realism, matching the
/// Figma prototype. "Manage booking" and the profile links are left
/// non-functional here — named explicitly in the Assessment 4 report as
/// remaining/non-implemented functionality.
class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = AppState.instance.lastBooking;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.l),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('My Bookings', style: AppTextStyles.heading),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                  child: const Text('Profile', style: TextStyle(color: AppColors.selectedOrange)),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.m),

            if (booking != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.m),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppRadius.card)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.successBg, borderRadius: BorderRadius.circular(20)),
                      child: const Text('CONFIRMED',
                          style: TextStyle(color: AppColors.success, fontSize: 11, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: AppSpacing.s),
                    Text(booking.restaurant.name, style: AppTextStyles.subheading),
                    const SizedBox(height: 2),
                    Text('${booking.date} • ${booking.time} • ${booking.guests} guests', style: AppTextStyles.body),
                    const Divider(height: AppSpacing.l),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Pre-order', style: AppTextStyles.body),
                        Text(
                          booking.preOrder.isEmpty ? 'None' : booking.preOrder.first.item.name,
                          style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Manage booking is not implemented in this build.')),
                          );
                        },
                        child: const Text('Manage booking', style: TextStyle(color: AppColors.selectedOrange)),
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.l),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppRadius.card)),
                child: const Center(
                  child: Text('No upcoming bookings yet. Book a table to see it here.', style: AppTextStyles.body),
                ),
              ),

            const SizedBox(height: AppSpacing.l),
            const Text('Past bookings', style: AppTextStyles.subheading),
            const SizedBox(height: AppSpacing.s),
            const _PastBookingTile(name: 'Harbour Grill', dateLabel: '18 Aug • Completed'),
            const _PastBookingTile(name: 'Saffron Table', dateLabel: '09 Aug • Completed'),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(current: AppTab.bookings),
    );
  }
}

class _PastBookingTile extends StatelessWidget {
  final String name;
  final String dateLabel;

  const _PastBookingTile({required this.name, required this.dateLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppRadius.chip)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600)),
              Text(dateLabel, style: AppTextStyles.caption),
            ],
          ),
          const Icon(Icons.chevron_right, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
