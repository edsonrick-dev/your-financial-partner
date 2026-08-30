import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/forms/spend_transaction_form.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/split_transaction/views/add_participant_button.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/split_transaction/views/split_allocation_summary.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/split_transaction/views/split_mode_selector.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/split_transaction/views/split_participants_list.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SplitExpenseSection extends GetView<TransactionController> {
  const SplitExpenseSection({super.key, this.onExpand});
  final VoidCallback? onExpand;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Obx(() {
      final isPaidBySelf = controller.paidBy.value == PaidBy.self;
      return isPaidBySelf
          ? AnimatedContainer(
              duration: Duration(milliseconds: 180),
              // curve: Curves.easeIn,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.appInfoSoft,
                borderRadius: BorderRadius.circular(
                  controller.isSharedExpense.value == true ? 24 : 12,
                ),
                border: Border.all(color: colorScheme.appInfo),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 4,
                              children: [
                                Icon(
                                  PhosphorIconsRegular.users,
                                  color: colorScheme.appInfo,
                                  // size: 20,
                                ),
                                Text(
                                  'Share Expense',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.appInfo,
                                  ),
                                ),
                              ],
                            ),

                            Text(
                              controller.participants.isEmpty
                                  ? 'Split this expense with others'
                                  : '${controller.participants.length} participants',
                              style: TextStyle(
                                color: colorScheme.appInfo,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Opacity(
                        opacity: controller.canEnableSharedExpense ? 1 : .4,
                        child: IgnorePointer(
                          ignoring: !controller.canEnableSharedExpense,
                          child: CupertinoSwitch(
                            value: controller.isSharedExpense.value,
                            onChanged: (value) {
                              controller.isSharedExpense.value = value;

                              if (value) {
                                final currentUserId =
                                    controller.currentUserEntityId.value;

                                if (currentUserId == null) return;

                                final alreadyExists = controller.participants
                                    .any(
                                      (participant) =>
                                          participant.entityId == currentUserId,
                                    );

                                if (!alreadyExists) {
                                  controller.addParticipant(
                                    entityId: currentUserId,
                                    name: 'Me',
                                  );
                                }
                              } else {
                                controller.participants.clear();
                              }
                              // controller.isSharedExpense.value = value;

                              // if (!value) {
                              //   controller.participants.clear();
                              // }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (controller.isSharedExpense.value) ...[
                    const SizedBox(height: 16),

                    const SplitModeSelector(),

                    const SizedBox(height: 16),

                    const SplitAllocationSummary(),

                    const SizedBox(height: 16),

                    const ParticipantList(),

                    const SizedBox(height: 12),

                    AddParticipantButton(onExpand: onExpand),
                  ],
                ],
              ),
            )
          : SizedBox.shrink();
    });
  }
}
