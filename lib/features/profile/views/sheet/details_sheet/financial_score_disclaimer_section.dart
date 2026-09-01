import 'package:flutter/cupertino.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class FinancialScoreDisclaimerSection extends StatelessWidget {
  const FinancialScoreDisclaimerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: AppSection(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Disclaimer: ',
                  style: AppTextStyle.titleM.copyWith(),
                ),
                TextSpan(
                  text:
                      'Your financial scores are based on the information in your Cashflow Plan and Net Worth Plan. Keep your financial information accurate and up to date for more reliable scores and insights. Scores are estimates and are not financial advice.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
