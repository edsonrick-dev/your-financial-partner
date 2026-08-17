import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AppDetailsHeader extends StatelessWidget {
  final String title;
  final Widget child;

  const AppDetailsHeader({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.text,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(38)),
      ),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: colorScheme.textInversed,
            centerTitle: true,
            title: Text(
              title,
              style: AppTextStyle.headlineL.copyWith(
                color: colorScheme.textInversed,
              ),
            ),
            surfaceTintColor: Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 6,
              bottom: 24,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
