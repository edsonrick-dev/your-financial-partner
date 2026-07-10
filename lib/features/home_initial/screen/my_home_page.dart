import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/home/views/recent_transactions_section.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/home_initial/widget/transaction_button.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Good morning, Edson Rick!',
          style: TextStyle(
            fontSize: 17,
            height: 24 / 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              AppSheets.endDrawer.openHomeMenu();
            },
            icon: Icon(Icons.menu, size: 24),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          spacing: 12,
          children: [
            ///PAGE SUMMARY & CTA SECTION
            AvailableFundsCard(),

            ///ADS SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                spacing: 8,
                children: [
                  Container(
                    width: double.infinity,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),

                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF141C29),
                          const Color(0xFF1E293B),
                        ],
                      ),
                    ),

                    padding: const EdgeInsets.all(20),

                    child: Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Text(
                                'Reduce Monthly Expenses',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 8),
                              Text(
                                'Track subscriptions and discover recurring charges.',
                                style: TextStyle(
                                  color: Colors.white.withAlpha(180),
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 16),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(999),
                                ),

                                child: const Text(
                                  'Analyze Now',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Icon(
                          Icons.insights,
                          color: Colors.white.withAlpha(220),
                          size: 64,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 2,
                    children: [
                      Container(
                        height: 4,
                        width: 12,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ///Recent Transactions Section
            AppSection(
              sectionTitle: 'Recent Transactions',
              trailingType: SectionTrailingType.textButton,
              trailingText: 'See all',
              onTrailingPressed: () {
                Get.toNamed(Routes.TRANSACTION);
              },
              // showTrailing: true,
              child: Column(
                spacing: 12,
                children: [RecentTransactionsSection()],
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class AvailableFundsCard extends StatelessWidget {
  const AvailableFundsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        spacing: 12,
        children: [
          ///PAGE SUMMARY
          Container(
            // height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: cs.text,
              gradient: LinearGradient(
                colors: [const Color(0xFF141C29), const Color(0xFF1E293B)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'Available Funds',
                      style: TextStyle(color: Colors.white.withAlpha(150)),
                    ),
                    StreamBuilder<double>(
                      stream: database.accountsDao.watchAvailableFunds(),

                      builder: (context, snapshot) {
                        final availableFunds = snapshot.data ?? 0.0;

                        return Text(
                          // '₱${availableFunds.toStringAsFixed(2)}',
                          availableFunds.toCurrency(),

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            height: 40 / 32,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          ///CALL TO ACTION
          Row(
            spacing: 12,
            children: [
              TransactionButton(
                label: 'Earn',
                color: Colors.green,
                icon: Icons.add,
                onTap: () {
                  AppSheets.transaction.earn();
                },
              ),
              TransactionButton(
                color: Colors.red,
                icon: Icons.remove,
                label: 'Spend',
                onTap: () {
                  AppSheets.transaction.spend();
                },
              ),
              TransactionButton(
                color: Colors.orange,
                icon: Icons.sync_alt_sharp,
                label: 'Transfer',
                onTap: () {
                  AppSheets.transaction.transfer();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BudgetReminderCard extends StatelessWidget {
  final String budgetName;
  final double allocation;
  final double used;
  // final double available;
  final double expectedProgress;

  const BudgetReminderCard({
    super.key,
    required this.budgetName,
    required this.allocation,
    required this.used,
    // required this.available,
    required this.expectedProgress,
  });

  @override
  Widget build(BuildContext context) {
    final available = allocation - used;
    final colorScheme = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: context.colors.appBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        spacing: 4,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                budgetName,
                style: TextStyle(
                  fontSize: 17,
                  height: 20 / 17,
                  fontWeight: FontWeight(400),
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Resets on Monday',
                    style: TextStyle(
                      fontSize: 10,
                      height: 12 / 10,
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                  Text(
                    '₱$available',
                    style: TextStyle(
                      fontSize: 15,
                      height: 20 / 15,
                      // fontWeight: FontWeight(500),
                    ),
                  ),
                ],
              ),
            ],
          ),
          //  ` BudgetProgressBar(
          //     allocation: allocation,
          //     used: used,
          //     expectedProgress: expectedProgress,
          //   ),`
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Used',
                    style: TextStyle(
                      fontSize: 11,
                      height: 16 / 11,
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                  Text(
                    '₱$used',
                    style: TextStyle(fontSize: 13, height: 16 / 13),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Allocation',
                    style: TextStyle(
                      fontSize: 11,
                      height: 16 / 11,
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                  Text(
                    '₱$allocation',
                    style: TextStyle(fontSize: 13, height: 16 / 13),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
