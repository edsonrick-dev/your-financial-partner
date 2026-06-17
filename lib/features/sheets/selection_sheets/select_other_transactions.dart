import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class SelectOtherTransactionSheet extends StatelessWidget {
  const SelectOtherTransactionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      constraints: BoxConstraints(maxHeight: Get.height * 0.75, minHeight: 500),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(38)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                AppGrabber(),
                AppToolbar(title: 'Select Transaction'),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  AppSection(
                    child: Column(
                      spacing: 12,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            Get.back();
                            debugPrint('Receive Money Clicked');
                            await AppSheets.transaction.receiveMoney();
                          },
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(minHeight: 44),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: colorScheme.appOnSurface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: colorScheme.appBorder,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              spacing: 12,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Opacity(
                                      opacity: 0.2,
                                      child: Container(
                                        height: 36,
                                        width: 36,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                          color: colorScheme.appInflow,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      AppIcons.categories.resolve('handCoins'),
                                      size: 20,
                                      color: colorScheme.appInflow,
                                    ),
                                  ],
                                ),
                                // Container(
                                //   padding: EdgeInsets.all(6),
                                //   width: 36,
                                //   height: 36,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(999),
                                //     color: colorScheme.appSuccess,
                                //   ),
                                //   child: Icon(
                                //     AppIcons.categories.resolve('handCoins'),
                                //     size: 20,
                                //     color: colorScheme.surface,
                                //   ),
                                // ),
                                Text(
                                  'Receive Money',
                                  style: TextStyle(
                                    fontSize: 17,
                                    height: 20 / 17,
                                    // color: colorScheme.te,
                                    // fontWeight: FontWeight(600),
                                    // fontFeatures: [FontFeature.tabularFigures()],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            Get.back();
                            debugPrint('Receive Money Clicked');
                            await AppSheets.transaction.giveMoney();
                          },
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(minHeight: 44),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: colorScheme.appOnSurface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: colorScheme.appBorder,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              spacing: 12,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Opacity(
                                      opacity: 0.2,
                                      child: Container(
                                        height: 36,
                                        width: 36,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                          color: colorScheme.appOutflow,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      AppIcons.categories.resolve(
                                        'handDeposit',
                                      ),
                                      size: 20,
                                      color: colorScheme.appOutflow,
                                    ),
                                  ],
                                ),

                                Text(
                                  'Give Money',
                                  style: TextStyle(
                                    fontSize: 17,
                                    height: 20 / 17,
                                    // color: colorScheme.te,
                                    // fontWeight: FontWeight(600),
                                    // fontFeatures: [FontFeature.tabularFigures()],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
