import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
