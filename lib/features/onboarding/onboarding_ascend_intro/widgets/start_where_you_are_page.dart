import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_ascend_intro/widgets/intro_message_card.dart';

class StartWhereYouArePage extends StatelessWidget {
  const StartWhereYouArePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'However you manage your finances today, Ascend starts where you are.',
            style: AppTextStyle.displayM,
          ),

          const SizedBox(height: 16),

          Text(
            'Whether you use spreadsheets, apps, notes, or nothing at all—Ascend is built to fit you.',
            style: AppTextStyle.bodyL,
          ),

          const SizedBox(height: 32),

          // // Your illustration goes here.
          // Container(
          //   padding: EdgeInsets.all(24),
          //   decoration: BoxDecoration(
          //     color: colorScheme.appInfoSoft,
          //     borderRadius: BorderRadius.circular(24),
          //   ),
          //   child: Column(
          //     children: [
          //       const _ManagementMethods(),

          //       // const SizedBox(height: 32),
          //       IntroMessageCard(
          //         child: Text(
          //           'Looking at one part alone won’t give you the full picture.',
          //           style: AppTextStyle.bodyM,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const _ManagementMethods(),

          // const SizedBox(height: 24),
          IntroMessageCard(
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    'No matter where you are today, Ascend helps you build a clearer path forward.',
                    style: AppTextStyle.bodyM,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ManagementMethods extends StatelessWidget {
  const _ManagementMethods();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/onboarding_financial_management_methods.png',
      width: double.infinity,
      fit: BoxFit.contain,
    );
  }
}
