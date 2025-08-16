import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const CategoryChip({super.key, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.primary.withOpacity(.07) : Colors.white,
          border: Border.all(
            color: selected ? Theme.of(context).colorScheme.primary : const Color(0xFFE5E7EB),
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: selected ? Theme.of(context).colorScheme.primary : AppTheme.text,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        )),
      ),
    );
  }
}