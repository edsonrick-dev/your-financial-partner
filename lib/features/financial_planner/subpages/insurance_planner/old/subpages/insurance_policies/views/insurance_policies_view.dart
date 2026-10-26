import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/show_add_policy_form.dart';
import 'package:getx_drift_app/features/widgets/fields/shared/field_container.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePoliciesView extends StatelessWidget {
  const InsurancePoliciesView({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Insurance Policies', style: AppTextStyle.headlineL),
        actions: [_AddPolicyButton()],
        actionsPadding: EdgeInsets.only(right: 16),
      ),
      body: SingleChildScrollView(child: Column(children: [          ],
        )),
    );
  }
}

class _AddPolicyButton extends StatelessWidget {
  const _AddPolicyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptivePressable(
      onTap: () {
        showAddPolicyForm();
      },
      child: Icon(PhosphorIconsRegular.plus),
    );
  }
}
