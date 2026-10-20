import 'package:flutter/cupertino.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class InvestmentReturnDisclaimer extends StatelessWidget {
  const InvestmentReturnDisclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: AppSection(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Investment Disclaimer: ',
                style: AppTextStyle.titleM,
              ),
              TextSpan(
                text:
                    'Projected investment returns are estimates based on '
                    'assumed rates of return and are not guaranteed. Actual '
                    'results may differ due to market conditions, fees, '
                    'taxes, and other factors. Investments carry risks, '
                    'including the possible loss of principal. Your suggested '
                    'portfolio is based on your financial goals, time horizon, '
                    'and risk profile and is for educational and planning '
                    'purposes only. It is not a guarantee of future performance '
                    'or personalized investment advice.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
