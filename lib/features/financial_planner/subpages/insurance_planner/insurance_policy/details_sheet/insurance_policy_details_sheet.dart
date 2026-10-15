import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/details_sheet/beneficiary_slide.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/widgets/policy_benefit_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePolicyDetailSheet extends StatelessWidget {
  const InsurancePolicyDetailSheet({
    super.key,
    required this.name,
    required this.issuer,
  });
  final String name;
  final String issuer;
  @override
  Widget build(BuildContext context) {
    final RxInt selectedIndex = 0.obs;
    final double faceValue = 1500000.0;
    return AppSheet(
      height: AppSheetHeight.full,
      title: "Insurance Policy",
      child: Padding(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: Column(
          children: [
            AppSection(
              child: Column(
                spacing: 16,
                children: [
                  PolicyDetailSection(
                    issuer: issuer,
                    name: name,
                    faceValue: faceValue,
                  ),
                  // AppButton(text: 'Pay Policy', onTap: () {}),
                ],
              ),
            ),

            AppDetailsPageActionSection(
              selectedIndex: selectedIndex,
              actions: const [
                'Benefits',
                'Beneficiaries',
                'Advisor',
                'Payment History',
              ],
            ),
            Expanded(
              child: Obx(
                () => IndexedStack(
                  index: selectedIndex.value,
                  children: [
                    BenefitSlide(),
                    BeneficiarySlide(faceValue: faceValue),
                    AdvisorSlide(),
                    Text('Payment History'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdvisorSlide extends StatelessWidget {
  const AdvisorSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: Column(
        children: [
          AppSectionBody(
            padding: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Advisor Details',
                        style: AppTextStyle.titleM,
                      ),
                    ),
                    Text('007605531', style: AppTextStyle.labelM),
                  ],
                ),
                SizedBox(height: 16),
                Text('Edson Rick R. San Juan', style: AppTextStyle.titleL),
              ],
            ),
          ),
          AppSectionBody(
            padding: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Contact Details',
                        style: AppTextStyle.titleM,
                      ),
                    ),
                    // Text('007605531', style: AppTextStyle.labelM),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  spacing: 8,
                  children: [
                    Row(
                      children: [
                        Icon(PhosphorIconsRegular.deviceMobile, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Mobile Number',
                            style: AppTextStyle.bodyM,
                          ),
                        ),
                        Text('0927-281-4973', style: AppTextStyle.titleM),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(PhosphorIconsRegular.envelope, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text('Email', style: AppTextStyle.bodyM),
                        ),
                        Text(
                          'edsurance.ed@gmail.com',
                          style: AppTextStyle.titleM,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  spacing: 12,
                  children: [
                    AppButton(
                      text: 'Send text',
                      onTap: () {},
                      leadingIcon: PhosphorIconsRegular.chat,
                    ),
                    AppButton(
                      text: 'Call phone',
                      onTap: () {},
                      type: ButtonType.outline,
                      leadingIcon: PhosphorIconsRegular.phone,
                    ),
                    AppButton(
                      text: 'Send email',
                      onTap: () {},
                      type: ButtonType.outline,
                      leadingIcon: PhosphorIconsRegular.envelope,
                    ),
                    AppButton(
                      text: 'Set meeting',
                      onTap: () {},
                      type: ButtonType.outline,
                      leadingIcon: PhosphorIconsRegular.calendar,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BenefitSlide extends StatelessWidget {
  const BenefitSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
      child: Column(
        spacing: 20,
        children: [
          AppSection(
            sectionTitle: 'Principal Benefit',
            child: Column(
              spacing: 20,
              children: [
                PolicyBenefitCard(type: BenefitType.majorCI, amount: 1000000),
              ],
            ),
          ),
          AppSection(
            sectionTitle: 'Rider Benefits',
            child: Column(
              spacing: 20,
              children: [
                PolicyBenefitCard(type: BenefitType.minorCI, amount: 250000),
                PolicyBenefitCard(
                  type: BenefitType.genderSpecific,
                  amount: 50000,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PolicyDetailSection extends StatelessWidget {
  const PolicyDetailSection({
    super.key,
    required this.issuer,
    required this.name,
    required this.faceValue,
  });

  final String issuer;
  final String name;
  final double faceValue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppGradientCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  issuer,
                  style: AppTextStyle.titleM.copyWith(
                    color: colorScheme.appInversedtextMuted,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              AdaptivePressable(
                child: SizedBox(
                  // height: 44,
                  width: 44,
                  child: Icon(
                    Icons.more_horiz,
                    color: colorScheme.appInversedtext,
                  ),
                ),
              ),
            ],
          ),
          Text(
            name,
            style: AppTextStyle.headlineM.copyWith(
              color: colorScheme.appInversedtextMuted,
            ),
          ),
          Text(
            faceValue.toCurrency(),
            style: AppTextStyle.amountL.copyWith(
              color: colorScheme.appInversedtextMuted,
            ),
          ),
          SizedBox(height: 8),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Term',
                      style: AppTextStyle.labelS.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),

                    Text(
                      '20-Year Pay',
                      style: AppTextStyle.bodyS.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next Due',
                      style: AppTextStyle.labelS.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),

                    Text(
                      'December 6, 1997',
                      style: AppTextStyle.bodyS.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
