import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashAndBankReservationView extends StatelessWidget {
  const CashAndBankReservationView({super.key, required this.accountId});

  final int accountId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<GoalReservationWithGoal>>(
      stream: database.goalReservationsDao.watchReservationsWithGoalsForAccount(
        accountId,
      ),
      builder: (context, snapshot) {
        final reservations = snapshot.data ?? [];

        if (reservations.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(PhosphorIconsRegular.target, size: 48),
                const SizedBox(height: 16),
                Text(
                  'No Goal Reservation Yet',
                  style: AppTextStyle.titleL,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'This account isn’t currently reserved '
                  'for any financial goals.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return AppSection(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: reservations.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = reservations[index];

              return GoalReservationCard(
                goal: GoalType.fromName(item.goal.type),
                amount: item.reservation.amount,
              );
            },
          ),
        );
      },
    );
  }
}

class GoalReservationWithGoal {
  const GoalReservationWithGoal({
    required this.reservation,
    required this.goal,
  });

  final GoalReservationsTableData reservation;
  final GoalsTableData goal;
}

class GoalReservationCard extends StatelessWidget {
  const GoalReservationCard({
    super.key,
    required this.goal,
    required this.amount,
    this.onTap,
  });

  final GoalType goal;
  final double amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.appText.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(goal.icon, size: 20),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(goal.title, style: AppTextStyle.titleM),
                const SizedBox(height: 2),
                Text(
                  'Goal reservation',
                  style: AppTextStyle.bodyS.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount.toCurrency(), style: AppTextStyle.amountM),
              const SizedBox(height: 2),
              Text(
                'Reserved',
                style: AppTextStyle.bodyS.copyWith(
                  color: colorScheme.appTextMuted,
                ),
              ),
            ],
          ),

          if (onTap != null) ...[
            const SizedBox(width: 8),
            Icon(
              PhosphorIconsRegular.caretRight,
              size: 18,
              color: colorScheme.appTextMuted,
            ),
          ],
        ],
      ),
    );
  }
}
