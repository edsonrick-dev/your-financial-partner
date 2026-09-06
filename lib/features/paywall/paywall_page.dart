import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSection(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    '''Build your professional financial plan''',
                    style: AppTextStyle.displayM,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Today', style: AppTextStyle.headlineM),
                                Text(
                                  'Unlock access to all the Ascend features',
                                  style: AppTextStyle.bodyL,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'In 2 Days - Reminder',
                                  style: AppTextStyle.headlineM,
                                ),
                                Text(
                                  '''We'll send you a reminder that your trial is ending soon''',
                                  style: AppTextStyle.bodyL,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'In 3 Days - Billing Starts',
                                  style: AppTextStyle.headlineM,
                                ),
                                Text(
                                  '''You'll be charged on Sep 7, 2026''',
                                  style: AppTextStyle.bodyL,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TrialCard(title: 'Free Trial', description: '3-day trial'),
                  TrialCard(
                    title: '30-Day Discounted Plan',
                    description: 149.toCurrency(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrialCard extends StatelessWidget {
  const TrialCard({super.key, required this.title, required this.description});
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(color: colorScheme.bgLight),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyle.titleL),
              Text(description, style: AppTextStyle.labelM),
            ],
          ),
        ],
      ),
    );
  }
}

class PaywallController extends GetxController {}
