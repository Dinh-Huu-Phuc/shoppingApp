import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../models/product.dart';
import '../widgets/app_button.dart';
import '../theme/app_theme.dart';
import '../state/cart_state.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    final Product product = mockProducts.firstWhere((p) => p.id == widget.productId);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.asset(product.image, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.brand, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 6),
                Text(product.name, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Row(children: [
                  Text('${product.effectivePrice.toStringAsFixed(0)}đ',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w800,
                      )),
                  if (product.onSale) ...[
                    const SizedBox(width: 8),
                    Text('${product.price.toStringAsFixed(0)}đ',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.lineThrough,
                        )),
                  ],
                ]),
                const SizedBox(height: 16),
                Text('Size', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: product.sizes.map((s) => ChoiceChip(
                    label: Text(s),
                    selected: selectedSize == s,
                    onSelected: (_) => setState(() => selectedSize = s),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius)),
                  )).toList(),
                ),
                const SizedBox(height: 16),
                Text(product.description),
                const SizedBox(height: 24),
                AppButton(
                  label: 'Thêm vào giỏ',
                  onPressed: () {
                    if (selectedSize == null && product.sizes.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Vui lòng chọn size.')),
                      );
                      return;
                    }
                    context.read<CartState>().add(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đã thêm vào giỏ.')),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}