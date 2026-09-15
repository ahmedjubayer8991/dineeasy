import '../models/booking.dart';
import '../models/cart_item.dart';
import '../models/menu_item.dart';

/// A deliberately simple singleton holding the parts of app state that need
/// to persist across screens (cart contents, most recent booking).
///
/// For a prototype of this scope, a singleton + setState() in the screens
/// that read it is a reasonable, explainable choice — it avoids pulling in
/// an external state-management package (Provider/Riverpod/Bloc) for what
/// is fundamentally a small amount of shared state. This is a conscious
/// architectural decision worth naming in your Assessment 4 report.
class AppState {
  AppState._internal();
  static final AppState instance = AppState._internal();

  final List<CartItem> cart = [];
  Booking? lastBooking;
  final List<Booking> pastBookings = [];

  double get cartTotal =>
      cart.fold(0.0, (sum, item) => sum + item.lineTotal);

  int get cartItemCount =>
      cart.fold(0, (sum, item) => sum + item.quantity);

  void addToCart(MenuItem item) {
    final existingIndex =
        cart.indexWhere((cartItem) => cartItem.item.id == item.id);
    if (existingIndex >= 0) {
      cart[existingIndex].quantity += 1;
    } else {
      cart.add(CartItem(item: item));
    }
  }

  void changeQuantity(CartItem cartItem, int delta) {
    cartItem.quantity += delta;
    if (cartItem.quantity <= 0) {
      cart.remove(cartItem);
    }
  }

  void clearCart() => cart.clear();

  void confirmBooking(Booking booking) {
    lastBooking = booking;
    clearCart();
  }
}
