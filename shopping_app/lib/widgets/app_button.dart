import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool fullWidth;

  const AppButton({super.key, required this.label, required this.onPressed, this.fullWidth = true});

  @override
  Widget build(BuildContext context) {
    final btn = ElevatedButton(onPressed: onPressed, child: Text(label));
    return fullWidth ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}