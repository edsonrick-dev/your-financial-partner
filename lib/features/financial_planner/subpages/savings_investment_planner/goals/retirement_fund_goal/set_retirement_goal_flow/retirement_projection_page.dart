import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

class RetirementProjectionPage extends StatefulWidget {
  const RetirementProjectionPage({super.key});

  @override
  State<RetirementProjectionPage> createState() =>
      _RetirementProjectionPageState();
}

class _RetirementProjectionPageState extends State<RetirementProjectionPage> {
  @override
  void initState() {
    super.initState();
    _setLandscape();
  }

  Future<void> _setLandscape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FinancialProfileController>();
    final colorScheme = context.colors;

    return Scaffold(
      appBar: AppBar(
        title: Text('How your fund may last', style: AppTextStyle.headlineL),
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        bottom: false,
        child: Obx(() {
          final projections = controller.retirementProjection.toList();

          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                      child: Text(
                        'This projection shows how your retirement fund '
                        'could change each year, including withdrawals, '
                        'investment growth, and the remaining balance.',
                        style: AppTextStyle.bodyL,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                        ),
                        child: Center(
                          child: DataTable(
                            columnSpacing: 24,
                            horizontalMargin: 16,
                            columns: [
                              DataColumn(
                                label: Text('Age', style: AppTextStyle.titleL),
                              ),
                              DataColumn(
                                label: Text(
                                  'Beginning',
                                  style: AppTextStyle.titleL,
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text(
                                  'Withdrawal',
                                  style: AppTextStyle.titleL,
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text(
                                  'Remaining',
                                  style: AppTextStyle.titleL,
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text(
                                  'Return',
                                  style: AppTextStyle.titleL,
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text(
                                  'Growth',
                                  style: AppTextStyle.titleL,
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text(
                                  'Ending',
                                  style: AppTextStyle.titleL,
                                ),
                                numeric: true,
                              ),
                            ],
                            rows: projections.map((projection) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      projection.age.toString(),
                                      style: AppTextStyle.amountL,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      projection.beginningBalance
                                          .toCompactCurrency(
                                            kThreshold: 1000000,
                                          ),
                                      style: AppTextStyle.bodyL,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      '-${projection.withdrawal.toCompactCurrency(kThreshold: 1000000)}',
                                      style: AppTextStyle.bodyL.copyWith(
                                        color: colorScheme.appOutflow,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      projection.remainingBalance
                                          .toCompactCurrency(
                                            kThreshold: 1000000,
                                          ),
                                      style: AppTextStyle.bodyL,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      '+${(projection.returnRate * 100).toStringAsFixed(1)}%',
                                      style: AppTextStyle.bodyL,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      '+${projection.interestEarned.toCompactCurrency(kThreshold: 10000)}',
                                      style: AppTextStyle.bodyL.copyWith(
                                        color: colorScheme.appInflow,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      projection.endBalance.toCompactCurrency(
                                        kThreshold: 1000000,
                                      ),
                                      style: AppTextStyle.bodyL,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
