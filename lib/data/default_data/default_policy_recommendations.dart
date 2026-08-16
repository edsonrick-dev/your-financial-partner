class InsurancePolicyRecommendation {
  final String insuranceCompany;
  final String policyName;
  final String? companyLogo;
  final String description;

  const InsurancePolicyRecommendation({
    required this.insuranceCompany,
    required this.policyName,
    this.companyLogo,
    required this.description,
  });
}

const dummyInsurancePolicyRecommendations = [
  InsurancePolicyRecommendation(
    insuranceCompany: 'AIA',
    policyName: 'Health Invest Plus',
    companyLogo: 'assets/images/aia_logo.png',
    description:
        'Life protection with critical illness coverage and investment potential.',
  ),
  InsurancePolicyRecommendation(
    insuranceCompany: 'Sun Life',
    policyName: 'Sun Fit and Well',
    companyLogo: 'assets/images/sunlife_logo.png',
    description:
        'Health insurance designed to provide financial support for major illnesses and medical needs.',
  ),
  InsurancePolicyRecommendation(
    insuranceCompany: 'FWD',
    policyName: 'Set for Health',
    companyLogo: 'assets/images/fwd_logo.png',
    description:
        'Critical illness protection that provides financial support when you need it most.',
  ),
  InsurancePolicyRecommendation(
    insuranceCompany: 'Manulife',
    policyName: 'HealthFlex',
    companyLogo: 'assets/images/manulife_logo.png',
    description:
        'Flexible health protection designed to help cover expenses from serious illnesses.',
  ),
  InsurancePolicyRecommendation(
    insuranceCompany: 'AXA',
    policyName: 'Health Start',
    companyLogo: 'assets/images/axa_logo.png',
    description:
        'Health coverage focused on protecting your finances against critical illness expenses.',
  ),
  InsurancePolicyRecommendation(
    insuranceCompany: 'Pru Life UK',
    policyName: 'PRUHealth Prime',
    companyLogo: 'assets/images/prulife_logo.png',
    description:
        'Health protection designed to provide financial assistance during serious medical conditions.',
  ),
  InsurancePolicyRecommendation(
    insuranceCompany: 'Generali',
    policyName: 'Health Protect',
    companyLogo: 'assets/images/generali_logo.png',
    description:
        'Protection against major health events with benefits designed to support long-term financial security.',
  ),
  InsurancePolicyRecommendation(
    insuranceCompany: 'BPI AIA',
    policyName: 'Critical Protect',
    companyLogo: 'assets/images/bpiaia_logo.png',
    description:
        'Critical illness protection designed to provide financial support during major health events.',
  ),
];
