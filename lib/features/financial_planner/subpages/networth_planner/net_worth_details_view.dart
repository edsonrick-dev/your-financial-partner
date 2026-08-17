import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_page_action_section.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class NetWorthDetailsView extends GetView<NetWorthController> {
  const NetWorthDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      body: Column(
        children: [
          AppDetailsHeader(
            title: 'Net Worth',
            child: Column(
              children: [
                Text(
                  controller.netWorth.abs().toCurrency(),
                  style: AppTextStyle.amountXL.copyWith(
                    color: controller.netWorth <= 0
                        ? colorScheme.appOutflow
                        : colorScheme.appInflow,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            controller.totalAssets.toCurrency(),
                            style: AppTextStyle.amountL.copyWith(
                              color: colorScheme.appInflow,
                            ),
                          ),
                          Text(
                            'Assets',
                            style: AppTextStyle.titleM.copyWith(
                              color: colorScheme.inversePrimary.withAlpha(150),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            controller.totalLiabilities.toCurrency(),
                            style: AppTextStyle.amountL.copyWith(
                              color: colorScheme.appOutflow,
                            ),
                          ),
                          Text(
                            'Liabilities',
                            style: AppTextStyle.titleM.copyWith(
                              color: colorScheme.inversePrimary.withAlpha(150),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppDetailsPageActionSection(
            selectedIndex: controller.seletectedDetailsTabIndex,
            actions: const [
              'Assets', 'Liabilities',
              // AppDetailsPageAction(title: 'Assets', page: _AssetsContent()),
              // AppDetailsPageAction(
              //   title: 'Liabilities',
              //   page: _LiabilitiesContent(),
              // ),
            ],
            onAdd: () {},
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.seletectedDetailsTabIndex.value,
                children: const [_AssetsContent(), _LiabilitiesContent()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssetsContent extends StatelessWidget {
  const _AssetsContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [Text('Needs content goes here.')]),
    );
  }
}

class _LiabilitiesContent extends StatelessWidget {
  const _LiabilitiesContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [Text('Sources content goes here.')]),
    );
  }
}
