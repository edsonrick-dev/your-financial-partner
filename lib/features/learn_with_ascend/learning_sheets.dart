import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/features/learn_with_ascend/article_block.dart';
import 'package:getx_drift_app/features/learn_with_ascend/article_block_type.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class LearningSheets {
  Future<void> whyFinancialPlanningMatters() async {
    return await Get.bottomSheet(
      AppSheet(
        height: AppSheetHeight.full,
        title: 'Why Financial Planning Matters',
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //OPENING
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "Financial planning isn't about having a perfect amount of money or knowing exactly what will happen in the future. It's about understanding where you are today, deciding where you want to go, and creating a plan for how your money can help you get there.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "Without a plan, it's easy to earn money, spend money, pay bills, and save occasionally without knowing whether all of those decisions are moving you in the same direction.",
              ),

              //What financial planning actually means
              ArticleBlock(
                type: ArticleBlockType.heading,
                content: 'What financial planning actually means',
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "At its simplest, financial planning is the process of organizing the important parts of your financial life so you can make informed decisions about your money.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "That means understanding what you own, what you owe, what you earn, how you spend, and what you are able to set aside for the future.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "These pieces are connected. Changing one can affect the others.",
              ),

              ArticleBlock(
                type: ArticleBlockType.callout,
                content:
                    "Financial planning is not a one-time calculation. It's an ongoing process.",
              ),
              ArticleBlock(
                type: ArticleBlockType.heading,
                content: "Your financial picture starts with where you are",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "Before you can decide what to do with your money, you need to understand your current position.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "What do you own? What do you owe? How much money do you expect to receive? How much do you plan to allocate toward your expenses and debt? How much room do you have left for saving and building wealth?",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content: "These questions give you a starting point.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "In Ascend, this begins with building your financial picture. Your accounts help establish what you own and what you owe, while your income plans and budget help describe how you expect your money to move.",
              ),
              ArticleBlock(
                type: ArticleBlockType.heading,
                content: "A plan gives your money direction",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "Knowing where you are is only the beginning. The next question is where you want your money to go.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "An income plan helps you estimate the money you expect to receive. A budget plan gives that income a purpose by allocating it across your planned expenses, debt repayment, savings, and investments.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "Instead of simply reacting to money as it comes in, you create an intentional plan for it.",
              ),
              ArticleBlock(
                type: ArticleBlockType.callout,
                content:
                    "A budget isn't just a record of what you spent. It's a plan for what your money is supposed to do.",
              ),
              ArticleBlock(
                type: ArticleBlockType.heading,
                content: "Your plan is a starting point, not a prediction",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content: "Real life rarely follows a plan perfectly.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "Your income can change. Your expenses can be higher than expected. Bills can appear. Your priorities can shift. You may spend differently from what you originally planned.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content: "That doesn't mean the plan failed.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "A useful financial plan gives you something to compare reality against. The difference between what you planned and what actually happened can tell you where your assumptions were realistic, where they need adjustment, and where your financial habits may need attention.",
              ),
              // ArticleBlock(
              //   type: ArticleBlockType.callout,
              //   content:
              //       "A budget isn't just a record of what you spent. It's a plan for what your money is supposed to do.",
              // ),
              ArticleBlock(
                type: ArticleBlockType.heading,
                content: "This is where Ascend comes in",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "Ascend is designed to help you connect your financial plan with your real-world financial behavior.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "First, you build your financial picture. Then you create your income plan and budget. As you use Ascend to track your transactions, the app can compare what you planned with what actually happened.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "Over time, this gives you more than a collection of numbers. It gives you a clearer view of how your financial decisions are affecting your overall position.",
              ),
              // ArticleBlock(
              //   type: ArticleBlockType.paragraph,
              //   content:
              //       "A useful financial plan gives you something to compare reality against. The difference between what you planned and what actually happened can tell you where your assumptions were realistic, where they need adjustment, and where your financial habits may need attention.",
              // ),
              ArticleBlock(
                type: ArticleBlockType.callout,
                content:
                    '''Ascend doesn't just ask, "What is your financial situation?" It also helps you understand what is happening and what to focus on next.''',
              ),
              ArticleBlock(
                type: ArticleBlockType.heading,
                content: "Your financial position will change",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content: "Your financial position isn't fixed.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "Your assets can grow or decline. Your liabilities can increase or decrease. Your income can change. Your spending can change. Your savings can change.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "Because these things change, your financial picture will change too.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "That's why Ascend is built around tracking progress over time rather than treating your current numbers as a permanent label.",
              ),
              // ArticleBlock(
              //   type: ArticleBlockType.paragraph,
              //   content:
              //       "A useful financial plan gives you something to compare reality against. The difference between what you planned and what actually happened can tell you where your assumptions were realistic, where they need adjustment, and where your financial habits may need attention.",
              // ),
              // ArticleBlock(
              //   type: ArticleBlockType.callout,
              //   content:
              //       '''Ascend doesn't just ask, "What is your financial situation?" It also helps you understand what is happening and what to focus on next.''',
              // ),
              ArticleBlock(
                type: ArticleBlockType.heading,
                content: "The goal isn't to make every number perfect",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "Financial planning isn't about forcing every month to look exactly the same.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "It's about making deliberate decisions, understanding the consequences of those decisions, and adjusting when reality gives you new information.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "Sometimes the right move may be to reduce spending. Sometimes it may be to increase savings. Sometimes it may be to focus on debt. And sometimes your plan simply needs to reflect your actual circumstances more accurately.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "The purpose of planning is not perfection. It's clarity and direction.",
              ),
              ArticleBlock(
                type: ArticleBlockType.heading,
                content:
                    "Financial planning becomes more useful as Ascend learns your situation",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "The more complete and consistent your financial information becomes, the more useful your financial picture can become.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "At first, Ascend may only know the information you have entered. As you build your accounts, create your plans, and track your transactions, Ascend can develop a clearer view of how your finances are actually working.",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    "That information can then help identify areas that need attention and guide you toward the next part of your financial journey.",
              ),
              ArticleBlock(
                type: ArticleBlockType.heading,
                content: "What you're building in Ascend",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content: "Your journey in Ascend starts with the basics:",
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    'Build your financial picture.  Know what you own and what you owe.',
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    'Plan your cash flow. Understand what you expect to receive and where you intend to allocate it.',
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    'Track what actually happens. Record your financial activity and compare it with your plans.',
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    'Understand your financial position. See how your financial picture changes over time.',
              ),
              ArticleBlock(
                type: ArticleBlockType.paragraph,
                content:
                    '''Know what to focus on next. Use what you've built and what you've experienced to make better financial decisions.''',
              ),
              ArticleBlock(
                type: ArticleBlockType.callout,
                content:
                    "You don't need a perfect financial situation to start planning. You need a clear starting point.",
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
