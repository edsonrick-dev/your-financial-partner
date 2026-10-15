class InsuranceCompany {
  final String name;
  final bool isUserCreated;

  const InsuranceCompany({required this.name, this.isUserCreated = false});
}

const insuranceCompanies = [
  InsuranceCompany(name: 'AIA Philippines'),
  InsuranceCompany(name: 'AXA'),
  InsuranceCompany(name: 'Insular Life'),
  InsuranceCompany(name: 'Insular Life'),
  InsuranceCompany(name: 'Manulife'),
  InsuranceCompany(name: 'PruLife UK'),
  InsuranceCompany(name: 'SunLife Philippines'),
];
