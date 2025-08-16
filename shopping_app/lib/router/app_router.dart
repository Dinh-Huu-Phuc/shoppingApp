import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/checkout_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'product/:id',
          name: 'productDetail',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ProductDetailScreen(productId: id);
          },
        ),
        GoRoute(
          path: 'cart',
          name: 'cart',
          builder: (context, state) => const CartScreen(),
        ),
        GoRoute(
          path: 'checkout',
          name: 'checkout',
          builder: (context, state) => const CheckoutScreen(),
        ),
      ],
    ),
  ],
);