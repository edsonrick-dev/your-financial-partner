import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/app_tab_switcher.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ChecksManagementView extends StatelessWidget {
  const ChecksManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Manage Checks', style: AppTextStyle.headlineL),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(PhosphorIconsRegular.plus)),
          SizedBox(width: 6),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSection(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.bg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colorScheme.appBorder),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TabSwitcher(
                          label: 'Issued Checks',
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: TabSwitcher(
                          label: 'Received Checks',
                          isActive: false,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
