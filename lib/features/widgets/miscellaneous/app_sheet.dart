import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';

class AppSheet extends StatelessWidget {
  const AppSheet({
    super.key,
    required this.child,
    required this.title,
    this.height = AppSheetHeight.semiFull,
    this.adaptiveHeight = false,
    this.minHeight = 300,
  });

  final String title;
  final Widget child;
  final double height;
  final bool adaptiveHeight;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final content = Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppBorderRadius.sheetTop,
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: adaptiveHeight ? MainAxisSize.min : MainAxisSize.max,
          children: [
            AppGrabber(),
            AppToolbar(title: title),

            if (adaptiveHeight)
              Flexible(fit: FlexFit.loose, child: child)
            else
              Expanded(child: child),
          ],
        ),
      ),
    );

    if (adaptiveHeight) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: minHeight,
          maxHeight: MediaQuery.sizeOf(context).height * height,
        ),
        child: content,
      );
    }

    return FractionallySizedBox(heightFactor: height, child: content);
  }
}
