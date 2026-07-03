import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key, required this.children, this.title});
  final List<Widget> children;
  final String? title;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSection(
      sectionTitle: title,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: BoxConstraints(minHeight: 44),
          width: double.infinity,
          decoration: BoxDecoration(color: colorScheme.appOnSurface),
          child: Column(
            children: List.generate(children.length, (index) {
              final widgets = <Widget>[children[index]];

              if (index != children.length - 1) {
                widgets.add(
                  Divider(
                    height: 0.5,
                    indent: 12,
                    endIndent: 12,
                    color: colorScheme.appBorderMuted,
                  ),
                );
              }
              return Column(children: widgets);
            }),
          ),
        ),
      ),
    );
  }
}
