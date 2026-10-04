import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/views/filled_view/sections/portfolio_slide/portfolio_content/portfolio_content_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/views/filled_view/sections/portfolio_slide/portfolio_empty_view.dart';

class PortfolioSlide extends StatelessWidget {
  const PortfolioSlide({super.key});

  @override
  Widget build(BuildContext context) {
    final isEmpty = false;
    final colorScheme = context.colors;

    if (isEmpty) {
      return PortfolioEmptyView();
    }
    return PortfolioContentView();
  }
}
