import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_status.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content_type.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_context.dart';

final learnContentLibrary = <LearnContent>[
  LearnContent(
    id: 'cashflow_01',
    title: 'What is Cash Flow?',
    description: 'Learn how money moves in and out of your financial life.',
    context: LearnContext.cashFlow,
    type: LearnContentType.article,
    priority: 100,
    isEligible: (state) => true,
    isTriggered: (state) => state.cashflow.status == CashflowStatus.empty,
  ),

  LearnContent(
    id: 'cashflow_02',
    title: 'What is an Income Plan?',
    description:
        'Understand how your income becomes the foundation of your financial plan.',
    context: LearnContext.cashFlow,
    type: LearnContentType.article,
    priority: 90,
    isEligible: (state) => true,
    isTriggered: (state) => state.cashflow.status == CashflowStatus.onlyBudget,
  ),

  LearnContent(
    id: 'cashflow_03',
    title: 'What is a Budget Plan?',
    description: 'Learn how to plan where your income should go.',
    context: LearnContext.cashFlow,
    type: LearnContentType.article,
    priority: 90,
    isEligible: (state) => true,
    isTriggered: (state) => state.cashflow.status == CashflowStatus.onlyIncome,
  ),

  LearnContent(
    id: 'cashflow_04',
    title: 'Understand Your Cash Flow',
    description:
        'Understand what your current income and budget relationship means.',
    context: LearnContext.cashFlow,
    type: LearnContentType.article,
    priority: 80,
    isEligible: (state) => state.cashflow.status == CashflowStatus.complete,
    isTriggered: (state) => state.cashflow.position != null,
  ),

  LearnContent(
    id: 'home_01',
    title: 'Why Financial Planning Matters',
    description:
        'Understand how your financial decisions work together to shape your financial future.',
    context: LearnContext.home,
    type: LearnContentType.article,
    url: 'https://edsonrick.framer.website/why-financial-planning-matters',
    priority: 100,
    isEligible: (state) => true,
    isTriggered: (state) => true,
  ),
  LearnContent(
    id: 'networth_01',
    title: 'Understand Your Net Worth',
    description:
        'Understand how your financial decisions work together to shape your financial future.',
    context: LearnContext.netWorth,
    type: LearnContentType.article,
    priority: 100,
    isEligible: (state) => true,
    isTriggered: (state) => true,
  ),
];
