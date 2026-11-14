import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/home/bindings/protection_questionnaire_binding.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/controller/protection_questionnaire_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({super.key});
  pw.Widget dependentContainer(String relationship, bool isMale, int age) {
    return pw.Container(
      // padding: pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: pw.BoxDecoration(
        // border: pw.Border.all(color: PdfColor.fromHex('#eef2f8')),
        // borderRadius: pw.BorderRadius.circular(2),
      ),
      child: pw.RichText(
        text: pw.TextSpan(
          children: [
            pw.TextSpan(text: relationship),
            pw.TextSpan(text: ' | '),
            pw.TextSpan(text: isMale ? 'Male' : 'Female'),
            pw.TextSpan(text: ' | '),
            pw.TextSpan(text: age.toStringAsFixed(0)),
            pw.TextSpan(text: ' y.o.'),
          ],
        ),
      ),
    );
  }

  pw.Widget chapterTitle(String title) {
    return pw.Container(
      padding: pw.EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      width: double.infinity,
      child: pw.Text(
        title,
        style: pw.TextStyle(fontSize: 20, color: PdfColor.fromHex('#EEF2F8')),
      ),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#141c29'),
        borderRadius: pw.BorderRadius.circular(4),
      ),
    );
  }

  Future<Uint8List> generatePdf(PdfPageFormat format) async {
    if (!Get.isRegistered<ProtectionQuestionnaireController>()) {
      ProtectionQuestionnaireBinding().dependencies();
    }
    final questionnaireController =
        Get.find<ProtectionQuestionnaireController>();
    final plans = await questionnaireController.cashflowController
        .watchSavedBudgetPlans()
        .first;
    await questionnaireController.loadContinuitySharesForPlans1(
      plans.map((plan) => plan.planId),
    );
    final budgetRows = plans.map((plan) {
      final annualAmount = plan.budgetPeriod.toAnnual(plan.amount);
      return BudgetRowModel(
        category: plan.category,
        death: annualAmount * questionnaireController.getContinuityShare(
          plan.planId,
          ProtectionType.death,
        ),
        criticalIllness:
            annualAmount *
            questionnaireController.getContinuityShare(
              plan.planId,
              ProtectionType.criticalIllness,
            ),
        disability:
            annualAmount *
            questionnaireController.getContinuityShare(
              plan.planId,
              ProtectionType.disability,
            ),
      );
    }).toList();
    final totalDeath = budgetRows.fold<double>(0, (sum, row) => sum + row.death);
    final totalCriticalIllness = budgetRows.fold<double>(
      0,
      (sum, row) => sum + row.criticalIllness,
    );
    final totalDisability = budgetRows.fold<double>(
      0,
      (sum, row) => sum + row.disability,
    );

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(
                'Comprehensive Protection Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blueGrey800,
                ),
              ),
            ),
            pw.SizedBox(height: 16), chapterTitle('Ascend Client Details'),

            pw.Text('Male'),
            pw.Text('December 06, 1997'),
            pw.Text('Non-Smoker'),

            pw.SizedBox(height: 16), chapterTitle('Client Dependent Details'),
            dependentContainer('Partner', false, 28),
            dependentContainer('Nephew', true, 12),

            pw.Divider(),
            // Table Header
            pw.SizedBox(height: 16),
            chapterTitle('Protection Breakdown Details'),
            pw.SizedBox(height: 12),

            budgetCategoryHeader(),
            pw.Divider(thickness: 0.5),

            ...budgetRows.map(
              (row) => budgetCategoryItem(
                row.category,
                row.death,
                row.criticalIllness,
                row.disability,
              ),
            ),
            pw.Divider(),
            budgetCategoryItem(
              'Annual Continuity Need',
              totalDeath,
              totalCriticalIllness,
              totalDisability,
            ),
            pw.Text(
              'Annualized budget amount adjusted by your saved lifestyle continuity share for each protection type.',
              style: pw.TextStyle(
                fontSize: 10,
                color: PdfColor.fromHex('64748B'),
              ),
            ),

            budgetCategoryItem('Protection Horizon', 10, 20, 65),

            pw.SizedBox(height: 24),
            pw.Row(
              children: [
                pw.Text(
                  'Highest Annual Continuity Total',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blueGrey700,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  [totalDeath, totalCriticalIllness, totalDisability]
                      .reduce((a, b) => a > b ? a : b)
                      .toCompactCurrency(symbol: '', kThreshold: 10000),
                  style: const pw.TextStyle(
                    fontSize: 32,
                    color: PdfColors.grey600,
                  ),
                ),
              ],
            ),
          ];
        },
        footer: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Confidential & Proprietary',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                  pw.Text(
                    'Page ${context.pageNumber} of ${context.pagesCount}',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    pdf.addPage(_coverPage(format));

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Section
              pw.Row(children: [pw.Text('Ascend: Your Financial Partner')]),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Protection Report',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blueGrey800,
                    ),
                  ),
                  pw.Text(
                    'Date: ${DateTime.now().toLocal().toString().split(' ')[0]}',
                    style: const pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.grey700,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 16),
              pw.Divider(color: PdfColors.grey400),
              pw.SizedBox(height: 16),

              // Body Content / Summary
              pw.Text(
                'Executive Summary',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blueGrey700,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Paragraph(
                text:
                    'This document serves as the official protection report detailing the monitored parameters, status evaluations, and recommended actions. All systems have been verified under standard operational guidelines.',
                style: const pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.black,
                  lineSpacing: 4,
                ),
              ),
              pw.SizedBox(height: 24),

              // Data Table or Status Section
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey200,
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(8),
                  ),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatusItem(
                      'System Status',
                      'SECURE',
                      PdfColors.green800,
                    ),
                    _buildStatusItem('Risk Level', 'LOW', PdfColors.blue800),
                    _buildStatusItem(
                      'Audited By',
                      'Automated System',
                      PdfColors.grey800,
                    ),
                  ],
                ),
              ),

              pw.Spacer(),

              // Footer
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Confidential & Proprietary',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                  pw.Text(
                    'Page ${context.pageNumber} of ${context.pagesCount}',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.Row budgetCategoryHeader() {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(child: pw.Text('Budget Category', style: pw.TextStyle())),
        pw.Column(
          children: [
            pw.Container(child: pw.Text('Protection Type')),
            pw.SizedBox(height: 4),
            pw.Row(
              children: [
                protectionTypeContainer(ProtectionType.death),
                protectionTypeContainer(ProtectionType.criticalIllness),
                protectionTypeContainer(ProtectionType.disability),
              ],
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget budgetCategoryItem(
    String cateogry,
    double deathAmount,
    double criticalIllnessAmount,
    double disabilityAmount,
  ) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(cateogry, style: titleL())),

          amountContainer(deathAmount),
          amountContainer(criticalIllnessAmount),
          amountContainer(disabilityAmount),
        ],
      ),
    );
  }

  pw.Container protectionTypeContainer(ProtectionType type) {
    return pw.Container(
      margin: pw.EdgeInsets.only(left: 16),
      width: 80,
      child: pw.Text(
        type.label,
        style: pw.TextStyle(fontSize: 12),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  pw.Container amountContainer(double amount) {
    return pw.Container(
      margin: pw.EdgeInsets.only(left: 16),
      width: 80,
      child: pw.Text(
        amount.toCompactCurrency(symbol: '', kThreshold: 100000),
        style: titleL(),
        textAlign: pw.TextAlign.end,
      ),
    );
  }

  pw.TextStyle titleL() {
    return pw.TextStyle(fontSize: 17);
  }

  pw.Page _coverPage(PdfPageFormat format) {
    return pw.Page(
      pageFormat: format,
      margin: const pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(
            children: [
              pw.Spacer(),
              pw.Text(
                'Protection Needs Analysis',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Spacer(),
              pw.Text(
                'Ascend: Your Financial Partner',
                style: const pw.TextStyle(fontSize: 17),
              ),
              pw.Text(
                'Generated on November 3, 2026',
                style: const pw.TextStyle(fontSize: 17),
              ),
            ],
          ),
        );
      },
    );
  }

  pw.Widget _buildStatusItem(String label, String value, PdfColor color) {
    return pw.Column(
      children: [
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Protection Report', style: AppTextStyle.headlineL),
      ),
      body: PdfPreview(
        build: (format) => generatePdf(format),
        allowPrinting: false,
        allowSharing: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: true,
        initialPageFormat: PdfPageFormat.a4,
      ),
    );
  }
}

Future<pw.SvgImage> loadPhosphorSvg(String iconName, {double size = 16}) async {
  // Asset path for phosphor_flutter icons
  final svgString = await rootBundle.loadString(
    'packages/phosphor_flutter/assets/regular/$iconName.svg',
  );

  return pw.SvgImage(svg: svgString, width: size, height: size);
}

class BudgetRowModel {
  final String category;
  final double death;
  final double criticalIllness;
  final double disability;

  const BudgetRowModel({
    required this.category,
    required this.death,
    required this.criticalIllness,
    required this.disability,
  });
}
