import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/features/widgets/fields/shared/field_container.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/person_balance_summary_model.dart';

class PersonBalanceCard extends StatelessWidget {
  final PersonBalanceSummary item;

  const PersonBalanceCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppFieldContainer(
      trailingPadding: 12,
      onTap: () {
        Get.toNamed(Routes.PERSONALBALANCE, arguments: item.entity.id);
      },
      child: Row(
        children: [
          /// NAME + STATUS
          Expanded(
            child: Row(
              spacing: 8,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: colorScheme.appText,
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    Text(
                      item.entity.name.trim()[0].toUpperCase(),
                      style: TextStyle(color: colorScheme.surface),
                    ),
                  ],
                ),
                Text(
                  item.entity.name,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          /// BALANCE
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.balanceAmount.toCurrency(),

                // isReceivable
                //     ? net.toCurrency()
                //     : '-${net.abs().toCurrency()}',
                style: TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.w700,
                  fontFeatures: [FontFeature.tabularFigures()],
                  color: colorScheme.appText,
                ),
              ),

              Text(
                item.isSettled
                    ? 'Settled'
                    : item.owesMe
                    ? 'Collectible'
                    : 'Payable',

                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  // color: Colors.grey.shade600,
                  color: item.isSettled
                      ? colorScheme.appTextMuted
                      : item.owesMe
                      ? colorScheme.appInflow
                      : colorScheme.appOutflow,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
