import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isOpen;
  const AddButton({super.key, required this.onTap, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppGradient.gradientA(context.colors),
          // color: Color(0xFF0F172A),
        ),
        child: AnimatedRotation(
          turns: isOpen ? 0.125 : 0,
          duration: const Duration(milliseconds: 200),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
