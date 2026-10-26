import 'package:flutter/foundation.dart';
// import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
// import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/premium_payment_type.dart';

extension SavePolicyControllerX on InsurancePolicyController {
  String? validateBenefits() {
    final missingBenefits = <String>[];

    for (final benefit in productBenefits) {
      if (!benefit.isRequired) continue;

      final draft = benefitDrafts.firstWhereOrNull(
        (item) => item.insuranceBenefitId == benefit.id,
      );

      if (draft == null || draft.coverageAmount <= 0) {
        final benefitName = benefit.name?.trim().isNotEmpty == true
            ? benefit.name!.trim()
            : benefit.benefitType.label;

        missingBenefits.add(benefitName);
      }
    }

    if (missingBenefits.isNotEmpty) {
      return 'Please enter a coverage amount for these required beneits: '
          '${missingBenefits.join(', ')}.';
    }

    return null;
  }

  String? validatePolicyForm() {
    debugPrint("Selected Insurer: ${selectedInsurer.value!.displayName}");
    debugPrint("Selected Product:${selectedProduct.value!.displayName}");
    debugPrint("Selected :${validateBenefits()}");
    debugPrint(
      "Selected Policy Number:${policyNumberTextController.text.trim()}",
    );
    debugPrint("Selected Date:${issueDate.value}");
    debugPrint("Selected :");
    // if (selectedInsurer.value == null) {
    //   return 'Please select an insurance company.';
    // }

    // if (selectedProduct.value == null) {
    //   return 'Please select an insurance product.';
    // }
    final benefitError = validateBenefits();
    if (benefitError != null) {
      return benefitError;
    }
    if (policyNumberTextController.text.trim().isEmpty) {
      return 'Please enter the policy number.';
    }
    if (issueDate.value == null) {
      return 'Please select the policy issue date.';
    }

    // if (!paymentSchedule.contains(selectedFrequency.value)) {
    //   return 'Please select a valid payment frequency.';
    // }

    if (!premiumAmount.value.isFinite || premiumAmount.value <= 0) {
      return 'Please enter a premium amount greater than zero.';
    }

    // if (nextPaymentDate.value == null) {
    //   return 'Please select the next payment date.';
    // }

    return null;
  }

  Future<void> savePolicy() async {
    if (isSavingPolicy.value) return;

    isSavingPolicy.value = true;

    try {
      // 1. Validate the form.
      final validationError = validatePolicyForm();

      if (validationError != null) {
        AppSnackbar.show(
          title: 'Check policy details',
          message: validationError,
        );
        return;
      }

      final product = selectedProduct.value;

      if (product == null) {
        AppSnackbar.show(
          title: 'Select a product',
          message: 'Please select an insurance product.',
        );
        return;
      }

      // 2. Prepare the policy data.
      final policyNumber = policyNumberTextController.text.trim();
      final dateIssued = issueDate.value!;
      final frequency = selectedFrequency.value;
      final amount = premiumAmount.value;

      final isSinglePay = product.isUserGenerated
          ? selectedPremiumPaymentType.value == 0
          : selectedPaymentTerm.value?.paymentType ==
                PremiumPaymentType.singlePay;

      final effectiveFrequency = isSinglePay
          ? BillsFrequency.annual
          : frequency;

      final localProductId = product.id;

      if (localProductId == null) {
        AppSnackbar.show(
          title: 'Product not saved locally',
          message:
              'Please save the insurance product locally before adding a policy.',
        );
        return;
      }

      // 3. Save through the DAO.
      final policyId = await database.userInsurancePolicyDao
          .savePolicyWithDetails(
            productId: localProductId,
            policyNumber: policyNumber.isEmpty ? null : policyNumber,
            dateIssued: dateIssued,
            frequency: effectiveFrequency,
            amount: amount,
            benefits: benefitDrafts.toList(),
          );

      debugPrint('Saved insurance policy ID: $policyId');

      // 4. Close the bottom sheet, then show the success message.
      Get.back();

      AppSnackbar.show(
        title: 'Policy saved',
        message: 'Your insurance policy has been saved successfully.',
      );
    } on StateError catch (e) {
      AppSnackbar.show(title: 'Unable to save policy', message: e.message);
    } catch (e, stackTrace) {
      debugPrint('Failed to save insurance policy: $e');
      debugPrintStack(stackTrace: stackTrace);

      AppSnackbar.show(
        title: 'Unable to save policy',
        message:
            'An error occurred while saving your policy. Please try again.',
      );
    } finally {
      isSavingPolicy.value = false;
    }
  }

  Future<void> savePolicy1() async {
    final validationError = validatePolicyForm();
    final product = selectedProduct.value;
    final productId = product?.id ?? 0;
    final paymentSchedule = selectedFrequency.value;
    final policyNumber = policyNumberTextController.text.trim();
    final dateIssued = issueDate.value ?? DateTime.now();
    if (validationError != null) {
      AppSnackbar.show(title: 'Check policy details', message: validationError);
      return;
    }
    debugPrint('Product ID: $productId');
    debugPrint('Product Name: ${product!.name}');
    debugPrint('Payment Schedule: $paymentSchedule');
    debugPrint('Policy Number: $policyNumber');
    debugPrint('Date Issued: $dateIssued');
    // try {
    //   final policyNumber = policyNumberTextController.text.trim();
    //   final dateIssued = issueDate.value;
    //   final frequency = selectedFrequency.value;
    //   final amount = premiumAmount.value;

    //   // Build the policy record.
    //   final policy = UserInsurancePolicyTableCompanion.insert(
    //     productId: product.id,
    //     policyNumber: Value(policyNumber),
    //     dateIssued: Value(dateIssued),
    //     paymentSchedule: frequency,
    //   );

    //   // Build benefit records using the selected benefit drafts.
    //   final benefits = <UserInsuranceBenefitsTableCompanion>[];

    //   for (final draft in benefitDrafts) {
    //     final benefitId = draft.insuranceBenefitId;

    //     // New benefits on user-generated products may not yet have
    //     // a persisted benefit definition.
    //     if (benefitId == null) {
    //       throw StateError(
    //         'A benefit definition must be saved before its coverage '
    //         'can be attached to the policy.',
    //       );
    //     }

    //     benefits.add(
    //       UserInsuranceBenefitsTableCompanion.insert(
    //         benefitId: benefitId,
    //         userPolicyId: 0, // Replaced by the DAO transaction.
    //         amount: draft.coverageAmount,
    //       ),
    //     );
    //   }

    //   // Persist policy, premium, and benefits atomically.
    //   final policyId = await database.userInsurancePolicyDao
    //       .savePolicyWithDetails(
    //         policy: policy,
    //         frequency: frequency,
    //         amount: amount,
    //         benefits: benefits,
    //       );

    //   debugPrint('Insurance policy saved. Local ID: $policyId');

    //   AppSnackbar.show(
    //     title: 'Policy saved',
    //     message: 'Your insurance policy has been saved successfully.',
    //   );

    //   Get.back();
    // } catch (error, stackTrace) {
    //   debugPrint('Failed to save insurance policy: $error');
    //   debugPrintStack(stackTrace: stackTrace);

    //   AppSnackbar.show(
    //     title: 'Unable to save policy',
    //     message:
    //         'An error occurred while saving your policy. Please try again.',
    //   );
    // }
    // return;

    // await database.insurancePoliciesDao.insertUserInsurancePolicy(
    //   productId: productId,
    //   paymentSchedule: paymentSchedule,
    //   policyNumber: policyNumber,
    //   dateIssued: dateIssued,
    // );
    // Persistence comes next.
  }
}
