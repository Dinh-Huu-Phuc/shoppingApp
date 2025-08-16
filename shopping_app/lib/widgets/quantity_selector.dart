import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  const QuantitySelector({super.key, required this.value, required this.onMinus, required this.onPlus});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: onMinus, icon: const Icon(Icons.remove_circle_outline)),
        Text('$value', style: Theme.of(context).textTheme.titleMedium),
        IconButton(onPressed: onPlus, icon: const Icon(Icons.add_circle_outline)),
      ],
    );
  }
}