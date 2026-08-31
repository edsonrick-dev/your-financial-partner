import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/tables/accounts_table.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class CreditCardAccountCard extends StatelessWidget {
  final AccountsTableData account;
  final VoidCallback? onTap;

  const CreditCardAccountCard({super.key, required this.account, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final availableCredit = account.availableCredit;
    final creditLimit = account.creditLimit;

    final utilization = creditLimit != null && creditLimit > 0
        ? account.currentValue / creditLimit
        : null;

    return AppCard(
      onTap: onTap,
      child: _CardDesign2(
        account: account,
        colorScheme: colorScheme,
        availableCredit: availableCredit,
        creditLimit: creditLimit,
        utilization: utilization,
      ),
    );
  }
}

class _CardDesign2 extends StatelessWidget {
  const _CardDesign2({
    required this.account,
    required this.colorScheme,
    required this.availableCredit,
    required this.creditLimit,
    required this.utilization,
  });

  final AccountsTableData account;
  final ColorScheme colorScheme;
  final double? availableCredit;
  final double? creditLimit;
  final double? utilization;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(AppIcons.categories.resolve(account.icon), size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      account.name,
                      style: AppTextStyle.bodyM,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              account.currentValue.toCurrency(),
              style: AppTextStyle.amountL.copyWith(
                color: colorScheme.appOutflow,
              ),
              softWrap: false,
              maxLines: 1,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ],
    );
  }
}

// ignore: unused_element
class _CardDesign1 extends StatelessWidget {
  const _CardDesign1({
    required this.account,
    required this.colorScheme,
    required this.availableCredit,
    required this.creditLimit,
    required this.utilization,
  });

  final AccountsTableData account;
  final ColorScheme colorScheme;
  final double? availableCredit;
  final double? creditLimit;
  final double? utilization;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Row(
              children: [
                Icon(AppIcons.categories.resolve(account.icon), size: 24),
                const SizedBox(width: 12),
                Text(account.name, style: AppTextStyle.titleM),
              ],
            ),
            Spacer(),
            // Text(
            //   account.currentValue.toCurrency(),
            //   style: AppTextStyle.amountL.copyWith(
            //     color: colorScheme.appOutflow,
            //   ),
            // ),
          ],
        ),

        const SizedBox(height: 16),

        // Current payable
        Text('Current payable', style: AppTextStyle.bodyS),
        const SizedBox(height: 2),
        Text(
          account.currentValue.toCurrency(),
          style: AppTextStyle.amountL.copyWith(color: colorScheme.appOutflow),
        ),

        const SizedBox(height: 16),

        // Available / limit
        Row(
          children: [
            Expanded(
              child: _CreditMetric(
                label: 'Available credit',
                value: availableCredit?.toCurrency() ?? '—',
              ),
            ),
            Expanded(
              child: _CreditMetric(
                label: 'Credit limit',
                value: creditLimit?.toCurrency() ?? '—',
              ),
            ),
          ],
        ),

        if (utilization != null) ...[
          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              color: colorScheme.appOutflow,
              backgroundColor: colorScheme.bgDark,
              borderRadius: BorderRadius.circular(999),
              value: utilization!.clamp(0.0, 1.0),
              minHeight: 6,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            '${(utilization! * 100).toStringAsFixed(1)}% utilized',
            style: AppTextStyle.bodyS,
          ),
        ],
      ],
    );
  }
}

class _CreditMetric extends StatelessWidget {
  final String label;
  final String value;

  const _CreditMetric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.bodyS),
        const SizedBox(height: 2),
        Text(value, style: AppTextStyle.amountM),
      ],
    );
  }
}
