import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/booking.dart';
import '../models/restaurant.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../widgets/selectable_chip.dart';

class TableBookingScreen extends StatefulWidget {
  const TableBookingScreen({super.key});

  @override
  State<TableBookingScreen> createState() => _TableBookingScreenState();
}

class _TableBookingScreenState extends State<TableBookingScreen> {
  int _selectedDate = 1; // SAT 24, matching the Figma default
  int _selectedTime = 2; // 7:30 PM
  int _guests = 2;
  int _selectedSeating = 0; // Indoor

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final restaurant = args is Restaurant ? args : mockRestaurants.first;
    final selectedTimeLabel = bookingTimes[_selectedTime];
    final suggestion = popularAtTime[selectedTimeLabel];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Book a Table'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(restaurant.name, style: AppTextStyles.subheading),
            const SizedBox(height: 4),
            const Text('Choose when you would like to dine.', style: AppTextStyles.body),
            const SizedBox(height: AppSpacing.l),

            const Text('Date', style: AppTextStyles.bodyDark),
            const SizedBox(height: AppSpacing.s),
            Row(
              children: List.generate(bookingDates.length, (i) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: i == bookingDates.length - 1 ? 0 : AppSpacing.s),
                    child: SelectableChip(
                      label: bookingDates[i],
                      selected: _selectedDate == i,
                      onTap: () => setState(() => _selectedDate = i),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.l),

            const Text('Time', style: AppTextStyles.bodyDark),
            const SizedBox(height: AppSpacing.s),
            Wrap(
              spacing: AppSpacing.s,
              runSpacing: AppSpacing.s,
              children: List.generate(bookingTimes.length, (i) {
                return SizedBox(
                  width: (MediaQuery.of(context).size.width - AppSpacing.l * 2 - AppSpacing.s * 2) / 3,
                  child: SelectableChip(
                    label: bookingTimes[i],
                    selected: _selectedTime == i,
                    onTap: () => setState(() => _selectedTime = i),
                  ),
                );
              }),
            ),

            // --- Original feature: lightweight "popular at this time" hint.
            // See build plan Section 6 / mock_data.dart popularAtTime map.
            if (suggestion != null) ...[
              const SizedBox(height: AppSpacing.s),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_fire_department_rounded, size: 16, color: AppColors.success),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Popular pick for this time: $suggestion',
                        style: const TextStyle(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: AppSpacing.l),
            const Text('Guests', style: AppTextStyles.bodyDark),
            const SizedBox(height: AppSpacing.s),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: 4),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppRadius.chip)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$_guests guests', style: AppTextStyles.bodyDark),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: AppColors.selectedOrange),
                        onPressed: _guests > 1 ? () => setState(() => _guests--) : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: AppColors.selectedOrange),
                        onPressed: () => setState(() => _guests++),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.l),

            const Text('Seating preference', style: AppTextStyles.bodyDark),
            const SizedBox(height: AppSpacing.s),
            Row(
              children: List.generate(seatingOptions.length, (i) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: i == seatingOptions.length - 1 ? 0 : AppSpacing.s),
                    child: SelectableChip(
                      label: seatingOptions[i],
                      selected: _selectedSeating == i,
                      onTap: () => setState(() => _selectedSeating = i),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.xl),

            PrimaryButton(
              label: 'Confirm Booking',
              onPressed: () {
                final booking = Booking(
                  restaurant: restaurant,
                  date: bookingDates[_selectedDate].replaceAll('\n', ' '),
                  time: bookingTimes[_selectedTime],
                  guests: _guests,
                  seating: seatingOptions[_selectedSeating],
                  preOrder: List.from(AppState.instance.cart),
                  bookingId: 'DE-${(1000 + DateTime.now().millisecond).toString()}',
                );
                AppState.instance.confirmBooking(booking);
                Navigator.pushNamed(context, '/confirmation', arguments: booking);
              },
            ),
            const SizedBox(height: AppSpacing.s),
            const Center(
              child: Text('You can edit or cancel later in My Bookings.', style: AppTextStyles.caption),
            ),
          ],
        ),
      ),
    );
  }
}
