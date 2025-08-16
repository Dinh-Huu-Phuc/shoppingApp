import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/cart_state.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Thanh toán')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Tổng cộng', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text('${cart.subtotal.toStringAsFixed(0)}đ', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 24),
          TextField(decoration: const InputDecoration(labelText: 'Họ và tên')),
          const SizedBox(height: 12),
          TextField(decoration: const InputDecoration(labelText: 'Số điện thoại')),
          const SizedBox(height: 12),
          TextField(decoration: const InputDecoration(labelText: 'Địa chỉ giao hàng')),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đặt hàng giả lập thành công!')),
              );
            },
            child: const Text('Đặt hàng'),
          )
        ],
      ),
    );
  }
}