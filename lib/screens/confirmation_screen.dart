import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = ModalRoute.of(context)!.settings.arguments as Booking;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.l),
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(color: AppColors.selectedOrange, shape: BoxShape.circle),
                      child: const Icon(Icons.check, color: Colors.white, size: 30),
                    ),
                    const SizedBox(height: AppSpacing.s),
                    const Text('Booking confirmed!', style: AppTextStyles.heading),
                    const SizedBox(height: 4),
                    const Text('Your table and pre-order are reserved.', style: AppTextStyles.body),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.l),
              const Text('Reservation details', style: AppTextStyles.subheading),
              const SizedBox(height: AppSpacing.s),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.m),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppRadius.card)),
                child: Column(
                  children: [
                    _DetailRow('Restaurant', booking.restaurant.name),
                    _DetailRow('Date', booking.date),
                    _DetailRow('Time', booking.time),
                    _DetailRow('Guests', '${booking.guests}'),
                    _DetailRow(
                      'Pre-order',
                      booking.preOrder.isEmpty
                          ? 'None'
                          : booking.preOrder.map((c) => c.item.name).join(', '),
                    ),
                    _DetailRow('Booking ID', booking.bookingId),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.m),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.m),
                decoration: BoxDecoration(color: AppColors.successBg, borderRadius: BorderRadius.circular(AppRadius.chip)),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, size: 16, color: AppColors.success),
                        SizedBox(width: 6),
                        Text('Free cancellation until 5:30 PM',
                            style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text('Changes are available from My Bookings.', style: AppTextStyles.caption),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.l),
              PrimaryButton(
                label: 'View My Bookings',
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/my-bookings',
                  (route) => route.settings.name == '/home',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
