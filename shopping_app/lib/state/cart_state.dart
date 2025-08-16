import 'package:flutter/material.dart';
import '../models/product.dart';

class CartLine {
  final Product product;
  int qty;
  CartLine({required this.product, this.qty = 1});
  double get lineTotal => product.effectivePrice * qty;
}

class CartState extends ChangeNotifier {
  final Map<String, CartLine> _lines = {};

  List<CartLine> get lines => _lines.values.toList(growable: false);
  int get totalItems => _lines.values.fold(0, (s, l) => s + l.qty);
  double get subtotal => _lines.values.fold(0.0, (s, l) => s + l.lineTotal);

  void add(Product p, {int qty = 1}) {
    final line = _lines[p.id];
    if (line == null) {
      _lines[p.id] = CartLine(product: p, qty: qty);
    } else {
      line.qty += qty;
    }
    notifyListeners();
  }

  void decrease(Product p) {
    final line = _lines[p.id];
    if (line == null) return;
    if (line.qty > 1) {
      line.qty -= 1;
    } else {
      _lines.remove(p.id);
    }
    notifyListeners();
  }

  void remove(Product p) {
    _lines.remove(p.id);
    notifyListeners();
  }

  void clear() {
    _lines.clear();
    notifyListeners();
  }
}