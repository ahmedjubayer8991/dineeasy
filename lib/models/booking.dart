import 'cart_item.dart';
import 'restaurant.dart';

class Booking {
  final Restaurant restaurant;
  final String date;
  final String time;
  final int guests;
  final String seating;
  final List<CartItem> preOrder;
  final String bookingId;

  Booking({
    required this.restaurant,
    required this.date,
    required this.time,
    required this.guests,
    required this.seating,
    required this.preOrder,
    required this.bookingId,
  });

  double get preOrderTotal =>
      preOrder.fold(0, (sum, item) => sum + item.lineTotal);
}
