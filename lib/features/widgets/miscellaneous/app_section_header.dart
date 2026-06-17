import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';

class AppSectionHeader extends StatelessWidget {
  final String sectionTitle;
  final String? trailingText;
  final SectionTrailingType? trailingType;
  final VoidCallback? onTrailingPressed;
  final Color textColor;
  const AppSectionHeader({
    super.key,
    required this.sectionTitle,
    this.textColor = Colors.black,
    // this.showTrailing = false,
    this.onTrailingPressed,
    this.trailingText,
    this.trailingType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            Text(
              sectionTitle,
              style: TextStyle(fontSize: 15, height: 20 / 15, color: textColor),
            ),
            Spacer(),

            if (trailingType != null)
              switch (trailingType) {
                SectionTrailingType.text => Text(
                  trailingText ?? 'trailingText',
                  style: TextStyle(
                    fontSize: 15,
                    height: 20 / 15,
                    color: colorScheme.primary,
                  ),
                ),

                SectionTrailingType.textButton => TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.appText,
                  ),
                  onPressed: onTrailingPressed,
                  child: Text(
                    trailingText ?? 'See all',
                    style: TextStyle(fontSize: 15, height: 20 / 15),
                  ),
                ),

                _ => SizedBox.shrink(),
                // null => SizedBox.shrink(),
              },

            // switch (trailingType) {
            //   _ => SizedBox.shrink(),
            // case null => SizedBox.shrink(),
            // case SectionTrailingType.text:
            //   Text(
            //     'See all',
            //     style: TextStyle(
            //       fontSize: 15,
            //       height: 20 / 15,
            //       color: colorScheme.primary,
            //     ),
            //   ),
            // case SectionTrailingType.textButton:
            //   TextButton(
            //     onPressed: () {},
            //     child: Text(
            //       'See all',
            //       style: TextStyle(fontSize: 15, height: 20 / 15),
            //     ),
            //   ),
            // case SectionTrailingType.segmentedButton:
            //   Container(
            //     height: 36,
            //     decoration: BoxDecoration(
            //       color: Colors.grey[200],
            //       borderRadius: BorderRadius.circular(999),
            //     ),
            //     padding: EdgeInsets.all(3),
            //     child: Row(
            //       children: [
            //         GestureDetector(
            //           child: Container(
            //             // height: 32,
            //             decoration: BoxDecoration(
            //               color: Colors.black,
            //               borderRadius: BorderRadius.circular(999),
            //             ),
            //             padding: EdgeInsets.only(
            //               left: 16,
            //               right: 16,
            //               // top: 8,
            //               // bottom: 8,
            //             ),

            //             alignment: Alignment.center,
            //             child: Text(
            //               'Budget',
            //               style: TextStyle(
            //                 fontSize: 15,
            //                 height: 20 / 15,
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ),
            //         ),
            //         GestureDetector(
            //           child: Container(
            //             // height: 32,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(999),
            //             ),
            //             padding: EdgeInsets.only(
            //               left: 8,
            //               right: 12,
            //               // top: 8,
            //               // bottom: 8,
            //             ),
            //             alignment: Alignment.center,
            //             child: Text(
            //               'Payments',
            //               style:
            //                   TextStyle(fontSize: 15, height: 20 / 15),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // case SectionTrailingType.iconButton:
            //   IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
            // },
            // if (showTrailing)
            //   // SegmentedButton<String>(
            //   //   segments: const [
            //   //     ButtonSegment(value: 'budget', label: Text('Budget')),
            //   //     ButtonSegment(value: 'payments', label: Text('Payments')),
            //   //   ],
            //   //   selected: {'budget'},
            //   //   onSelectionChanged: (Set<String> value) {
            //   //     // handle selection
            //   //   },
            //   // ),
            //   Container(
            //     height: 36,
            //     decoration: BoxDecoration(
            //       color: Colors.grey[200],
            //       borderRadius: BorderRadius.circular(999),
            //     ),
            //     padding: EdgeInsets.all(3),
            //     child: Row(
            //       children: [
            //         GestureDetector(
            //           child: Container(
            //             // height: 32,
            //             decoration: BoxDecoration(
            //               color: Colors.black,
            //               borderRadius: BorderRadius.circular(999),
            //             ),
            //             padding: EdgeInsets.only(
            //               left: 16,
            //               right: 16,
            //               // top: 8,
            //               // bottom: 8,
            //             ),

            //             alignment: Alignment.center,
            //             child: Text(
            //               'Budget',
            //               style: TextStyle(
            //                 fontSize: 15,
            //                 height: 20 / 15,
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ),
            //         ),
            //         GestureDetector(
            //           child: Container(
            //             // height: 32,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(999),
            //             ),
            //             padding: EdgeInsets.only(
            //               left: 8,
            //               right: 12,
            //               // top: 8,
            //               // bottom: 8,
            //             ),
            //             alignment: Alignment.center,
            //             child: Text(
            //               'Payments',
            //               style: TextStyle(fontSize: 15, height: 20 / 15),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
