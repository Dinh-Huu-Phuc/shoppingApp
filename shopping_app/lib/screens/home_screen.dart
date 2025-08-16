import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/widgets/product_cart.dart';
import '../data/mock_data.dart';
import '../widgets/category_chip.dart';
import '../state/cart_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategoryId; // null = all

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartState>();
    final filtered = selectedCategoryId == null
        ? mockProducts
        : mockProducts.where((p) => p.categoryId == selectedCategoryId).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fashion Store'),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () => context.goNamed('cart'),
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
              if (cart.totalItems > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('${cart.totalItems}', style: const TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          // Search bar (đơn giản)
          TextField(
            decoration: InputDecoration(
              hintText: 'Tìm sản phẩm...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 12),
          // Category chips
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length + 1,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                if (i == 0) {
                  return CategoryChip(
                    label: 'All',
                    selected: selectedCategoryId == null,
                    onTap: () => setState(() => selectedCategoryId = null),
                  );
                }
                final c = categories[i - 1];
                return CategoryChip(
                  label: c.name,
                  selected: selectedCategoryId == c.id,
                  onTap: () => setState(() => selectedCategoryId = c.id),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          // Grid products
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.68,
            ),
            itemBuilder: (context, i) => ProductCard(product: filtered[i]),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (i) {
          if (i == 1) context.goNamed('cart');
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.storefront_outlined), label: 'Shop'),
          NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), label: 'Cart'),
        ],
      ),
    );
  }
}