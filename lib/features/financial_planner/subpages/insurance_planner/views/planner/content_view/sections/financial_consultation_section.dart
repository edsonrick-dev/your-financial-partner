import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/app_day.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class FinancialConsultationSection extends StatelessWidget {
  const FinancialConsultationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppSection(
      sectionTitle: 'Talk to a Financial Planner',
      child: AppSectionBody(
        padding: 24,
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text('Your Schedule', style: AppTextStyle.titleL),
                ),
                const SizedBox(width: 12),
                Icon(PhosphorIconsRegular.calendar, color: colors.appAccent),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('October 24, 2026', style: AppTextStyle.titleL),
                    Text('3:00PM - 3:45PM', style: AppTextStyle.bodyM),
                  ],
                ),
                SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(child: Text('Status:', style: AppTextStyle.bodyL)),
                    Text('Submitted', style: AppTextStyle.bodyL),
                  ],
                ),
                Divider(color: colors.appTextMuted),
                Text(
                  'Our team is just confirming receipt of your payment. We will update the status soonest.',
                  style: AppTextStyle.bodyS,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ConsultationEmptyView extends StatelessWidget {
  const _ConsultationEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Get objective guidance on your protection plan',
                style: AppTextStyle.titleL,
              ),
            ),
            const SizedBox(width: 12),
            Icon(PhosphorIconsRegular.chatsCircle, color: colors.appAccent),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          "Understand your coverage and your family's protection needs with an Ascend financial planner.",
          style: AppTextStyle.bodyM.copyWith(),
        ),
        const SizedBox(height: 16),
        AppButton(
          text: 'Schedule a consultation',
          onTap: () {
            // scheduleConsultation();
            Get.bottomSheet(isScrollControlled: true, _ConsultationFeeSheet());
          },

          leadingIcon: PhosphorIconsRegular.calendarBlank,
        ),
      ],
    );
  }
}

class _ConsultationFeeSheet extends StatefulWidget {
  const _ConsultationFeeSheet();

  @override
  State<_ConsultationFeeSheet> createState() => _ConsultationFeeSheetState();
}

class _ConsultationFeeSheetState extends State<_ConsultationFeeSheet> {
  final ImagePicker _picker = ImagePicker();
  XFile? _paymentProof;

  Future<void> _pickPaymentProof() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image == null || !mounted) return;
    setState(() => _paymentProof = image);
  }

  void _removePaymentProof() => setState(() => _paymentProof = null);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Consultation',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: context.bottomPaddingSub,
          left: 16,
          right: 16,
        ),
        child: Column(
          spacing: 20,
          children: [
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Talk to a Financial Planner',
                  style: AppTextStyle.headlineS,
                ),
                Text(
                  'Get personalized guidance on your financial protection needs with Ascend.',
                  style: AppTextStyle.bodyL,
                ),
              ],
            ),
            AppSectionBody(
              padding: 20,
              child: Column(
                spacing: 8,
                children: [
                  Column(
                    spacing: 4,
                    children: [
                      Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: Text(
                              'Protection Assessment',
                              style: AppTextStyle.titleL.copyWith(),
                            ),
                          ),
                          Icon(PhosphorIconsRegular.clock),
                        ],
                      ),
                      Text(
                        'Understand your needs, review coverage gaps, and explore your options.',
                        style: AppTextStyle.bodyM.copyWith(),
                      ),
                    ],
                  ),
                  Divider(color: colors.appTextMuted),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Duration', style: AppTextStyle.bodyL),
                      ),
                      Text('45 min.', style: AppTextStyle.amountL),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Format', style: AppTextStyle.bodyL),
                      ),
                      Text('Zoom meet', style: AppTextStyle.amountL),
                    ],
                  ),
                ],
              ),
            ),

            AppSectionBody(
              padding: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Column(
                    spacing: 4,
                    children: [
                      Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: Text(
                              'Consultation Fee',
                              style: AppTextStyle.titleL.copyWith(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(500.toCurrency(), style: AppTextStyle.amountXL),
                  Text(
                    'for every 45 min or a fraction thereof',
                    style: AppTextStyle.bodyL,
                  ),
                ],
              ),
            ),
            AppSectionBody(
              padding: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select your schedule', style: AppTextStyle.titleL),
                  SizedBox(height: 16),
                  AppButton(text: 'Reserve slot', onTap: () {}),
                  Divider(),
                  Text(
                    'Your slot will be reserved until you pay and we confirm your payment. If no payment is received after 2 hours, the slot will be released.',
                  ),
                ],
              ),
            ),
            AppSectionBody(
              padding: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Text('Payment Method', style: AppTextStyle.titleL),

                  Row(
                    spacing: 8,
                    children: [Text('GCash', style: AppTextStyle.headlineM)],
                  ),

                  Divider(color: colors.appTextMuted),

                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/consultation_qr_code.JPG',
                        width: 240,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  Center(
                    child: Column(
                      spacing: 4,
                      children: [
                        Text('AscendYFP', style: AppTextStyle.titleL),
                        Text(500.toCurrency(), style: AppTextStyle.amountXL),
                      ],
                    ),
                  ),

                  Text(
                    'Scan the QR code using GCash to pay the consultation fee.',
                    style: AppTextStyle.bodyM,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            AppSectionBody(
              padding: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Proof of Payment',
                          style: AppTextStyle.titleL,
                        ),
                      ),
                      if (_paymentProof != null)
                        Row(
                          children: [
                            IconButton(
                              tooltip: 'Remove proof of payment',
                              onPressed: _removePaymentProof,
                              icon: const Icon(PhosphorIconsRegular.trash),
                            ),
                            IconButton(
                              tooltip: 'Change uploaded image',
                              onPressed: _pickPaymentProof,
                              icon: const Icon(
                                PhosphorIconsRegular.pencilSimple,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),

                  if (_paymentProof == null)
                    AppButton(
                      text: 'Upload Proof of Payment',
                      leadingIcon: PhosphorIconsRegular.uploadSimple,
                      onTap: _pickPaymentProof,
                      type: ButtonType.ghost,
                    )
                  else ...[
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_paymentProof!.path),
                          width: 240,
                          // height: 220,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Column(
              spacing: 8,
              children: [
                AppButton(
                  text: 'Complete my reservation',
                  onTap: () {
                    Get.back();
                    AppSnackbar.show(
                      title: 'Your',
                      message: 'message',
                      type: AppSnackType.success,
                    );
                  },
                ),
                Text(
                  'We will notify you once our team confirm receipt of your payment.',
                  style: AppTextStyle.labelM.copyWith(
                    color: colors.appTextMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ConsultationSheet extends StatefulWidget {
  const _ConsultationSheet();

  @override
  State<_ConsultationSheet> createState() => _ConsultationSheetState();
}

class _ConsultationSheetState extends State<_ConsultationSheet> {
  final Set<String> _selectedTopics = {};
  bool _showSchedule = false;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dates = List.generate(14, (index) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      return today.add(Duration(days: index));
    });

    return AppSheet(
      adaptiveHeight: true,
      title: _showSchedule
          ? 'Schedule your consultation'
          : 'Schedule a consultation',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: context.bottomPaddingSub,
          left: 16,
          right: 16,
        ),
        child: _showSchedule
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () => setState(() => _showSchedule = false),
                    icon: const Icon(PhosphorIconsRegular.arrowLeft, size: 18),
                    label: const Text('Back to topics'),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Your selected topics', style: AppTextStyle.headlineS),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _selectedTopics
                        .map((topic) => _TopicChip(topic))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  Text('Choose a date', style: AppTextStyle.headlineS),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 76,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final date = dates[index];
                        final selected = _selectedDate == date;
                        return ChoiceChip(
                          label: SizedBox(
                            width: 42,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(AppDay.values[date.weekday - 1].shortName),
                                Text('${date.day}', style: AppTextStyle.titleL),
                              ],
                            ),
                          ),
                          selected: selected,
                          onSelected: (_) =>
                              setState(() => _selectedDate = date),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Available times', style: AppTextStyle.headlineS),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.bgLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.appBorder),
                    ),
                    child: Text(
                      _selectedDate == null
                          ? 'Select a date to check available appointment times.'
                          : 'There are no appointment times to show yet. Please check back later.',
                      style: AppTextStyle.bodyM.copyWith(
                        color: colors.appTextMuted,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _InfoRow(
                    icon: PhosphorIconsRegular.videoCamera,
                    label: 'Online consultation',
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: PhosphorIconsRegular.clock,
                    label: '30 minutes',
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    text: 'Continue to booking details',
                    onTap: null,
                    trailingIcon: PhosphorIconsRegular.arrowRight,
                  ),
                ],
              )
            : _buildTopicSelection(colors),
      ),
    );
  }

  Widget _buildTopicSelection(ColorScheme colors) {
    final topics = [
      'Review my existing coverage',
      'Understand my protection needs',
      'Discuss insurance options',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppGradientCard(
          padding: 20,
          child: Text(
            'Get personalized guidance on your financial protection needs. Choose what you’d like to discuss, then find a time that works for you.',
            style: AppTextStyle.bodyM.copyWith(color: colors.appInversedtext),
          ),
        ),
        const SizedBox(height: 20),
        Text('What would you like help with?', style: AppTextStyle.headlineS),
        const SizedBox(height: 12),
        Column(
          children: topics.map((topic) {
            final selected = _selectedTopics.contains(topic);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _Selection(
                title: topic,
                isSelected: selected,
                onTap: () => setState(() {
                  if (selected) {
                    _selectedTopics.remove(topic);
                  } else {
                    _selectedTopics.add(topic);
                  }
                }),
              ),
            );
          }).toList(),
        ),

        AppGradientCard(child: Column(children: [])),
        const SizedBox(height: 10),
        AppButton(
          text: 'Continue',
          onTap: _selectedTopics.isEmpty
              ? null
              : () => setState(() => _showSchedule = true),
          trailingIcon: PhosphorIconsRegular.arrowRight,
        ),
      ],
    );
  }
}

class _TopicChip extends StatelessWidget {
  const _TopicChip(this.topic);
  final String topic;

  @override
  Widget build(BuildContext context) => Chip(
    avatar: Icon(
      PhosphorIconsRegular.checkCircle,
      size: 18,
      color: context.colors.appAccent,
    ),
    label: Text(topic),
  );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 18, color: context.colors.appTextMuted),
      const SizedBox(width: 8),
      Text(label, style: AppTextStyle.bodyM),
    ],
  );
}

class _Selection extends StatelessWidget {
  const _Selection({
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(child: Text(title, style: AppTextStyle.titleL)),
          Icon(
            isSelected
                ? PhosphorIconsFill.checkSquare
                : PhosphorIconsRegular.square,
          ),
        ],
      ),
    );
  }
}

Future<void> scheduleConsultation() async {
  final uri = Uri.parse(
    'https://calendly.com/edsurance-dev/ascend_protection_needs_analysis',
  );

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not open the booking page.');
  }
}
