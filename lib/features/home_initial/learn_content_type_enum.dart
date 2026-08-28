enum LearnContentType {
  setup,
  explain,
  interpret,
  insight,
  improve,
  milestone,
  nextStep;

  String get label {
    return switch (this) {
      LearnContentType.setup => 'Setup',
      LearnContentType.explain => 'Explain',
      LearnContentType.interpret => 'Interpret',
      LearnContentType.insight => 'Insight',
      LearnContentType.improve => 'Improve',
      LearnContentType.milestone => 'Milestone',
      LearnContentType.nextStep => 'Next Step',
    };
  }
}
