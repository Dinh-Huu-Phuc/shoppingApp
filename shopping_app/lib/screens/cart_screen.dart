import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../state/cart_state.dart';
import '../widgets/quantity_selector.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Giỏ hàng')),
      body: cart.lines.isEmpty
          ? const Center(child: Text('Giỏ hàng trống'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, i) {
                final line = cart.lines[i];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 72, height: 72,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(line.product.image, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(line.product.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 4),
                          Text('${line.product.effectivePrice.toStringAsFixed(0)}đ'),
                        ],
                      ),
                    ),
                    QuantitySelector(
                      value: line.qty,
                      onMinus: () => context.read<CartState>().decrease(line.product),
                      onPlus: () => context.read<CartState>().add(line.product),
                    ),
                    IconButton(
                      onPressed: () => context.read<CartState>().remove(line.product),
                      icon: const Icon(Icons.delete_outline),
                    )
                  ],
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: cart.lines.length,
            ),
      bottomNavigationBar: cart.lines.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Tạm tính'),
                          Text('${cart.subtotal.toStringAsFixed(0)}đ',
                              style: Theme.of(context).textTheme.headlineMedium),
                        ],
                      ),
                    ),
                    FilledButton(
                      onPressed: () => context.goNamed('checkout'),
                      child: const Text('Thanh toán'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}