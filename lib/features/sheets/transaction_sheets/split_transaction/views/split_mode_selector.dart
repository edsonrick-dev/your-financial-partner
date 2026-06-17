import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/split_transaction_ext.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/data/enums/split_mode_enum.dart';

class SplitModeSelector extends GetView<TransactionController> {
  const SplitModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(() {
      final selectedIndex = SplitMode.values.indexOf(
        controller.splitMode.value,
      );

      return Container(
        height: 44,

        decoration: BoxDecoration(
          color: colorScheme.appOnSurface,
          borderRadius: BorderRadius.circular(8),
        ),

        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / SplitMode.values.length;

            return Stack(
              children: [
                /// Animated pill
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 220),

                  curve: Curves.easeOutCubic,

                  left: selectedIndex * itemWidth,

                  top: 0,
                  bottom: 0,

                  width: itemWidth,

                  child: Padding(
                    padding: const EdgeInsets.all(4),

                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.appText,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),

                /// Labels
                Row(
                  children: SplitMode.values.map((mode) {
                    final isSelected = controller.splitMode.value == mode;

                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,

                        // onTap: () {
                        //   controller.splitMode.value = mode;

                        //   /// collapse all participant cards
                        //   for (final participant in controller.participants) {
                        //     participant.isActive.value = false;
                        //     participant.focusNode.unfocus();
                        //   }
                        //   debugPrint(controller.splitMode.value.name);
                        //   if (mode == SplitMode.equal) {
                        //     controller.recalculateEqualSplit();
                        //   }

                        // },
                        onTap: () {
                          /// collapse + unfocus
                          for (final participant in controller.participants) {
                            participant.isActive.value = false;
                            participant.focusNode.unfocus();
                          }

                          controller.splitMode.value = mode;

                          controller.recalculateParticipants();

                          for (final participant in controller.participants) {
                            controller.syncTextController(participant);
                          }
                        },
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 180),

                            curve: Curves.easeOut,

                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,

                              fontWeight: FontWeight.w600,
                            ),

                            child: Text(mode.name.capitalize!),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
