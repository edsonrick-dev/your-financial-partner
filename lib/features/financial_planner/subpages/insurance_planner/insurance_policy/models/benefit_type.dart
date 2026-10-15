enum BenefitType {
  death,
  majorCI,
  minorCI,
  adb,
  genderSpecific,
  medicalReimbursement,
  disability,
  dailyHospitalIncome,
  others,
}

extension BenefitTypeX on BenefitType {
  String get label {
    switch (this) {
      case BenefitType.death:
        return 'Death Benefit';
      case BenefitType.majorCI:
        return 'Major Critical Illness Benefit';
      case BenefitType.minorCI:
        return 'Minor Critical Illness Benefit';
      case BenefitType.adb:
        return 'Accidental Death Benefit';
      case BenefitType.genderSpecific:
        return 'Gender-Specific Cancer Benefit';
      case BenefitType.medicalReimbursement:
        return 'Medical Reimbursement';
      case BenefitType.disability:
        return 'Disability Benefit';
      case BenefitType.dailyHospitalIncome:
        return 'Daily Hospital Income';
      case BenefitType.others:
        return 'Other Benefits';
    }
  }

  String get description {
    switch (this) {
      case BenefitType.death:
        return 'Benefit payable upon the insured’s death.';
      case BenefitType.majorCI:
        return 'Coverage for specified major critical illnesses.';
      case BenefitType.minorCI:
        return 'Coverage for specified minor or early-stage critical illnesses.';
      case BenefitType.adb:
        return 'Additional coverage for death caused by an accident.';
      case BenefitType.genderSpecific:
        return 'Coverage for specified cancers and related conditions.';
      case BenefitType.medicalReimbursement:
        return 'Reimbursement of eligible medical expenses.';
      case BenefitType.disability:
        return 'Benefits for qualifying disability.';
      case BenefitType.dailyHospitalIncome:
        return 'Daily cash benefits during eligible hospital confinement.';
      case BenefitType.others:
        return 'Other benefits not listed above.';
    }
  }
}
