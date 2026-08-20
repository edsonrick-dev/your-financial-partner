import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/core/num_extension.dart';

class SplitAllocationSummary extends GetView<TransactionController> {
  const SplitAllocationSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Color color;

      if (controller.remainingAllocation < 0) {
        color = Colors.red;
      } else if (controller.remainingAllocation.abs() < 0.01) {
        color = Colors.green;
      } else {
        color = Colors.orange;
      }

      final progress = controller.amount.value == 0
          ? 0.0
          : (controller.totalAllocated / controller.amount.value).clamp(
              0.0,
              1.0,
            );

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Allocated ${controller.totalAllocated.toCurrency()} / ${controller.amount.value.toCurrency()}',
              style: TextStyle(fontFeatures: [FontFeature.tabularFigures()]),
            ),

            const SizedBox(height: 8),

            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(value: progress, minHeight: 8),
            ),

            const SizedBox(height: 8),

            Text(
              controller.remainingAllocation < 0
                  ? 'Over allocated by ${controller.remainingAllocation.abs().toCurrency()}'
                  : controller.remainingAllocation.abs() < 0.01
                  ? 'Fully allocated'
                  : 'Remaining ${controller.remainingAllocation.toCurrency()}',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      );
    });
  }
}
