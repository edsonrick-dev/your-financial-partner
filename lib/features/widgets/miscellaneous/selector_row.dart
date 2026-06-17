import 'package:flutter/material.dart';

class SelectorRow extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final IconData? icon;
  final String? value;
  const SelectorRow({
    super.key,
    this.title = 'Title',
    this.onTap,
    this.icon,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 16, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon ?? Icons.question_mark, size: 20),
              Text(title, style: TextStyle(fontSize: 16, height: 20 / 16)),
            ],
          ),
          Spacer(),
          TextButton(
            onPressed: onTap,

            child: Text(
              value ?? 'Select value',
              style: const TextStyle(fontSize: 16, height: 20 / 16),
            ),
          ),
        ],
      ),
    );
  }
}
