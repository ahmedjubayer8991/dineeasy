import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/restaurant.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _specialRequestController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final restaurant = args is Restaurant ? args : mockRestaurants.first;
    final cart = AppState.instance.cart;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Your Order'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.m),
            child: Center(child: Text('${AppState.instance.cartItemCount} item${AppState.instance.cartItemCount == 1 ? '' : 's'}', style: AppTextStyles.body)),
          ),
        ],
      ),
      body: cart.isEmpty
          ? const Center(child: Text('Your cart is empty.', style: AppTextStyles.body))
          : Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: cart.length,
                      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s),
                      itemBuilder: (context, i) {
                        final cartItem = cart[i];
                        return Container(
                          padding: const EdgeInsets.all(AppSpacing.s),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppRadius.card)),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(AppRadius.chip),
                                child: Image.network(cartItem.item.imageUrl, width: 64, height: 64, fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(width: 64, height: 64, color: AppColors.primaryOrange.withOpacity(0.3))),
                              ),
                              const SizedBox(width: AppSpacing.s),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cartItem.item.name, style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600)),
                                    Text('\$${cartItem.item.price.toStringAsFixed(2)}',
                                        style: const TextStyle(color: AppColors.selectedOrange, fontWeight: FontWeight.w700)),
                                    const Text('No special instructions', style: AppTextStyles.caption),
                                  ],
                                ),
                              ),
                              _QuantityStepper(
                                quantity: cartItem.quantity,
                                onDecrement: () => setState(() => AppState.instance.changeQuantity(cartItem, -1)),
                                onIncrement: () => setState(() => AppState.instance.changeQuantity(cartItem, 1)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.m),
                  const Text('Special request', style: AppTextStyles.bodyDark),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _specialRequestController,
                    decoration: const InputDecoration(hintText: 'e.g. no chilli, allergy note...'),
                  ),
                  const SizedBox(height: AppSpacing.m),
                  const Text('Order summary', style: AppTextStyles.subheading),
                  const SizedBox(height: 6),
                  _SummaryRow(label: 'Subtotal', value: AppState.instance.cartTotal),
                  const _SummaryRow(label: 'Booking fee', value: 0),
                  const Divider(),
                  _SummaryRow(label: 'Total', value: AppState.instance.cartTotal, bold: true),
                  const SizedBox(height: AppSpacing.m),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.m),
                    decoration: BoxDecoration(
                        color: AppColors.primaryOrange.withOpacity(0.12), borderRadius: BorderRadius.circular(AppRadius.chip)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reserve + pre-order', style: TextStyle(color: AppColors.selectedOrange, fontWeight: FontWeight.w700)),
                        SizedBox(height: 4),
                        Text('Your meal will be prepared around your booking time.', style: AppTextStyles.body),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.m),
                  PrimaryButton(
                    label: 'Continue to Table Booking',
                    onPressed: () => Navigator.pushNamed(context, '/table-booking', arguments: restaurant),
                  ),
                ],
              ),
            ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _QuantityStepper({required this.quantity, required this.onDecrement, required this.onIncrement});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryOrange.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.remove, size: 16), onPressed: onDecrement, color: AppColors.selectedOrange),
          Text('$quantity', style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w700)),
          IconButton(icon: const Icon(Icons.add, size: 16), onPressed: onIncrement, color: AppColors.selectedOrange),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool bold;

  const _SummaryRow({required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    final style = bold
        ? AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w700, fontSize: 16)
        : AppTextStyles.body;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text('\$${value.toStringAsFixed(2)}', style: style),
        ],
      ),
    );
  }
}
