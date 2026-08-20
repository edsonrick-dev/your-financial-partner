import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/split_transaction_ext.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/enums/split_mode_enum.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/participant_model.dart';

class ParticipantCard extends GetView<TransactionController> {
  final ParticipantModel participant;

  final int index;

  const ParticipantCard({
    super.key,
    required this.participant,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Obx(() {
      final isActive = participant.isActive.value;

      return GestureDetector(
        onTap: () {
          /// close others
          for (final p in controller.participants) {
            p.isActive.value = false;

            p.focusNode.unfocus();
          }

          participant.isActive.value = true;

          participant.focusNode.requestFocus();
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? colorScheme.bgLight : Colors.transparent,
            ),
            color: isActive ? colorScheme.bgLight : Colors.transparent,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                child: Text(participant.name[0].toUpperCase()),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      participant.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),

                    Obx(() {
                      return controller.splitMode.value == SplitMode.percentage
                          ? Text(
                              (participant.amount.value).toCurrency(),
                              style: const TextStyle(fontSize: 12),
                            )
                          : Text(
                              '${(participant.percentage.value * 100).toStringAsFixed(2)}%',
                              style: const TextStyle(fontSize: 12),
                            );
                    }),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),

                child: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    if (controller.splitMode.value != SplitMode.equal)
                      SizedBox(
                        width:
                            controller.splitMode.value == SplitMode.percentage
                            ? 70
                            : 90,
                        child: IgnorePointer(
                          ignoring: isActive ? false : true,
                          child: TextFormField(
                            focusNode: participant.focusNode,
                            controller: participant.textController,

                            // initialValue:
                            //     controller.splitMode.value ==
                            //         SplitMode.percentage
                            //     ? (participant.percentage.value * 100)
                            //           .toStringAsFixed(2)
                            //     : participant.amount.value.toStringAsFixed(2),
                            textAlign: TextAlign.end,

                            keyboardType: TextInputType.number,

                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              suffixText:
                                  controller.splitMode.value ==
                                      SplitMode.percentage
                                  ? '%'
                                  : null,
                              prefix:
                                  controller.splitMode.value == SplitMode.custom
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Text('₱'),
                                    )
                                  : null,

                              // prefixText:
                              //     controller.splitMode.value == SplitMode.custom
                              //     ? '₱'
                              //     : null,
                            ),

                            onChanged: (value) {
                              final parsed = double.tryParse(value) ?? 0;

                              if (controller.splitMode.value ==
                                  SplitMode.percentage) {
                                controller.updateParticipantPercentage(
                                  participant: participant,
                                  percentage: parsed / 100,
                                );
                              } else {
                                controller.updateParticipantAmount(
                                  participant: participant,
                                  amount: parsed,
                                );
                              }
                            },
                          ),
                        ),
                      )
                    else
                      Text(
                        participant.amount.value.toCurrency(),

                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),

                    AnimatedSize(
                      duration: const Duration(milliseconds: 180),

                      child:
                          isActive &&
                              participant.entityId !=
                                  controller.currentUserEntityId.value
                          ? IconButton(
                              onPressed: () {
                                controller.removeParticipant(
                                  participant.entityId,
                                );

                                if (controller.splitMode.value ==
                                    SplitMode.equal) {
                                  controller.recalculateEqualSplit();
                                }
                              },

                              icon: Icon(
                                Icons.delete_forever_outlined,
                                color: colorScheme.appAccent,
                                size: 20,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              // AnimatedSwitcher(
              //   duration: const Duration(milliseconds: 180),

              //   child: isActive
              //       ? Row(
              //           key: const ValueKey('active'),

              //           mainAxisSize: MainAxisSize.min,

              //           children: [
              //             if (controller.splitMode.value != SplitMode.equal)
              //               SizedBox(
              //                 width: 90,
              //                 child:
              //               )
              //             else
              //

              //             if (participant.entityId !=
              //                 controller.currentUserEntityId.value)

              //           ],
              //         )
              //       : Text(
              //           participant.amount.value.toCurrency(),

              //           key: const ValueKey('collapsed'),

              //           style: const TextStyle(
              //             fontWeight: FontWeight.w700,
              //             fontFeatures: [FontFeature.tabularFigures()],
              //           ),
              //         ),
              // ),
            ],
          ),
        ),
      );
    });
  }
}
