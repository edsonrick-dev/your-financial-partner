import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_ascend_intro/widgets/intro_message_card.dart';

class FinancialPicturePage extends StatelessWidget {
  const FinancialPicturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your finances are more connected than you think.',
            style: AppTextStyle.displayM,
          ),

          const SizedBox(height: 16),

          Text(
            'Every financial decision you make affects something else.',
            style: AppTextStyle.bodyL,
          ),

          const SizedBox(height: 32),

          // Temporary illustration area.
          // Replace this with your actual illustration.
          Column(
            children: [
              const _FinancialRelationshipDiagram(),

              const SizedBox(height: 32),

              IntroMessageCard(
                child: Text(
                  'Looking at one part alone won’t give you the full picture.',
                  style: AppTextStyle.bodyM,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FinancialRelationshipDiagram extends StatelessWidget {
  const _FinancialRelationshipDiagram();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/onboarding_financial_planners2.png',
      width: double.infinity,
      fit: BoxFit.contain,
    );
  }
}
