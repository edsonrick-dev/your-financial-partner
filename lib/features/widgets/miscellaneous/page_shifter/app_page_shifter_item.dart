// import 'package:flutter/material.dart';
// import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
// import 'package:getx_drift_app/core/design_system/app_text_style.dart';
// import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

// class AppPageShifterItem extends StatelessWidget {
//   const AppPageShifterItem({
//     super.key,
//     required this.title,
//     required this.selected,
//     required this.onTap,
//   });

//   final String title;
//   final bool selected;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = context.colors;

//     return AdaptivePressable(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         child: Text(
//           title,
//           style: AppTextStyle.titleL.copyWith(
//             color: selected
//                 ? colorScheme.pageShifterTextSelected
//                 : colorScheme.pageShifterTextUnselected,
//           ),
//         ),
//       ),
//     );
//   }
// }
