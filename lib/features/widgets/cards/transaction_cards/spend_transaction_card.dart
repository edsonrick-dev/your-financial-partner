import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/delete_functions.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/features/widgets/container/category_icon_container.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SpendTransactionCard extends GetView<TransactionController> {
  final TransactionWithDetails item;

  const SpendTransactionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // final othersCount = item.participants.length - 1;
    final colorScheme = context.colors;

    return GestureDetector(
      onTap: () {
        AppSheets.transaction.spend(item);
      },
      onLongPress: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('Delete Transaction'),
              content: const Text('This action cannot be undone.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );

        if (confirmed == true) {
          await controller.deleteTransactionWithBalanceUpdate(item);
        }
      },
      child: Container(
        padding: EdgeInsets.all(8),
        constraints: BoxConstraints(minHeight: 44),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.appOnSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.appBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///TOP SECTION
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                ///Icon Holder
                CategoryIconContainer(item: item, color: colorScheme.appText),

                ///Details Row
                Expanded(
                  child: Column(
                    spacing: 8,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Left Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                item.category?.name ?? 'Unknown',
                                style: TextStyle(fontSize: 17, height: 20 / 17),
                              ),
                              Text(
                                item.account.name,
                                style: TextStyle(
                                  fontSize: 11,
                                  height: 16 / 11,
                                  color: colorScheme.appTextMuted,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),

                          ///Right Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                item.transaction.amount.toCurrency(),
                                style: TextStyle(
                                  fontSize: 17,
                                  height: 20 / 17,
                                  color: colorScheme.appOutflow,
                                  // fontWeight: FontWeight(600),
                                ),
                              ),
                              if (item.isSharedExpense)
                                Icon(
                                  PhosphorIconsRegular.users,
                                  color: colorScheme.appInfo,
                                  size: 16,
                                ),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Icon(
                              //       PhosphorIconsRegular.users,
                              //       color: colorScheme.info,
                              //       size: 12,
                              //     ),
                              //     SizedBox(width: 4),
                              //     Text(
                              //       'Split with '
                              //       '$othersCount ${othersCount == 1 ? 'other' : 'others'}',
                              //       style: TextStyle(
                              //         fontSize: 11,
                              //         height: 16 / 11,
                              //         color: colorScheme.info,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ],
                      ),

                      /// SHARED SUMMARY
                      // if (item.isSharedExpense)
                      //   Container(
                      //     padding: const EdgeInsets.all(8),

                      //     decoration: BoxDecoration(
                      //       color: colorScheme.infoSoft,
                      //       borderRadius: BorderRadius.circular(4),
                      //       border: Border.all(
                      //         color: colorScheme.info,
                      //         width: 0.4,
                      //       ),
                      //     ),

                      //     child: Column(
                      //       spacing: 4,
                      //       children: [
                      //         _SummaryRow(
                      //           label: 'Your share',

                      //           value: item.splitSummary?.myShare ?? 0,

                      //           valueColor: colorScheme.error,
                      //           fontWeight: 600,
                      //         ),

                      //         // const SizedBox(height: 4),
                      //         _SummaryRow(
                      //           label: 'Others owe you',

                      //           value: item.splitSummary?.receivableAmount ?? 0,

                      //           valueColor: Colors.green,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ],
            ),

            ///BOTTOM SECTION
          ],
        ),
      ),
    );
  }
}

// class _SummaryRow extends StatelessWidget {
//   final String label;

//   final double value;

//   final Color? valueColor;

//   final int? fontWeight;
//   const _SummaryRow({
//     required this.label,
//     required this.value,
//     this.valueColor,
//     this.fontWeight = 400,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight(fontWeight!),
//               fontSize: 11,
//               height: 16 / 11,
//             ),
//           ),
//         ),

//         Text(
//           value.toCurrency(),

//           style: TextStyle(
//             fontWeight: FontWeight(fontWeight!),
//             color: valueColor,
//             fontSize: 11,
//             height: 16 / 11,
//           ),
//         ),
//       ],
//     );
//   }
// }
