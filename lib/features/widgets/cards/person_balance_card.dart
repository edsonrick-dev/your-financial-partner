import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/personal_balance/screen/personal_balance_details_sheet.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/person_balance_summary_model.dart';

class PersonBalanceCard extends StatelessWidget {
  final PersonBalanceSummary item;

  const PersonBalanceCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppCard(
      onTap: () {
        Get.bottomSheet(
          PersonalBalanceDetailsSheet(entityId: item.entity.id),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
        );
      },
      child: Row(
        children: [
          /// NAME + STATUS
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: colorScheme.appText,
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        colors: [colorScheme.text, colorScheme.gradient2],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),

                  Text(
                    item.entity.name.trim()[0].toUpperCase(),
                    style: AppTextStyle.labelS.copyWith(
                      color: colorScheme.appInversedtext,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Text(item.entity.name, style: AppTextStyle.titleM),
            ],
          ),
          Spacer(),

          /// BALANCE
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.balanceAmount.toCurrency(),

                style: AppTextStyle.amountL.copyWith(
                  color: item.iOwe
                      ? colorScheme.appOutflow
                      : colorScheme.appInflow,
                ),
              ),

              // Text(
              //   item.isSettled
              //       ? 'Settled'
              //       : item.owesMe
              //       ? 'Collectible'
              //       : 'Payable',

              //   style: TextStyle(
              //     fontSize: 12,
              //     fontWeight: FontWeight.w600,
              //     // color: Colors.grey.shade600,
              //     color: item.isSettled
              //         ? colorScheme.appTextMuted
              //         : item.owesMe
              //         ? colorScheme.appInflow
              //         : colorScheme.appOutflow,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
