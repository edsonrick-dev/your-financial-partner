import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_card_factory.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_group/account_group_summary.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class AccountGroupSection extends StatelessWidget {
  final AccountGroupSummary summary;

  const AccountGroupSection({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      sectionTitle: summary.group.label,
      trailingWidget: Text(
        summary.total.toCurrency(),
        style: AppTextStyle.amountM,
      ),
      trailingType: SectionTrailingType.custom,
      child: AppSectionBody(
        child: Column(
          children: [
            for (final account in summary.accounts) ...[
              AccountCardFactory.build(account),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
