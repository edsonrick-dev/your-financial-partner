import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
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
        Get.bottomSheet(_ChooseProductSheet(), isScrollControlled: true);
      },
      child: Icon(PhosphorIconsRegular.plus),
    );
  }
}

class _ChooseProductSheet extends StatelessWidget {
  const _ChooseProductSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSheet(
      title: 'Choose Product',
      child: AppSection(
        child: Column(
          children: [
            AppFieldContainer(
              onTap: () {},
              fixedHeight: false,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: TextEditingController(),
                      focusNode: FocusNode(),
                      keyboardType: TextInputType.text,
                      maxLength: 250,
                      textInputAction: TextInputAction.done,
                      style: AppTextStyle.bodyL,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: AppTextStyle.titleL.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                      buildCounter:
                          (
                            context, {
                            required currentLength,
                            required isFocused,
                            required maxLength,
                          }) => null,
                    ),
                  ),

                  SizedBox(width: 16),
                  Icon(PhosphorIconsRegular.magnifyingGlass, size: 20),
                  SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
