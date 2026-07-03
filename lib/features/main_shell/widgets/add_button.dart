import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isOpen;
  const AddButton({super.key, required this.onTap, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF0F172A),
          ),
          child: AnimatedRotation(
            turns: isOpen ? 0.125 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
