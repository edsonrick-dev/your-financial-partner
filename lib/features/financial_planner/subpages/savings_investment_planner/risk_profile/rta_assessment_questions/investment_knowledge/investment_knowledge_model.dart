class InvestmentKnowledgeQuestion {
  static const String question =
      'I would describe my knowledge of investments as:';

  static const options = InvestmentKnowledge.values;
}

enum InvestmentKnowledge { none, limited, good, extensive }

extension InvestmentKnowledgeX on InvestmentKnowledge {
  String get label {
    switch (this) {
      case InvestmentKnowledge.none:
        return 'None';

      case InvestmentKnowledge.limited:
        return 'Limited';

      case InvestmentKnowledge.good:
        return 'Good';

      case InvestmentKnowledge.extensive:
        return 'Extensive';
    }
  }

  int get score {
    switch (this) {
      case InvestmentKnowledge.none:
        return 0;

      case InvestmentKnowledge.limited:
        return 2;

      case InvestmentKnowledge.good:
        return 4;

      case InvestmentKnowledge.extensive:
        return 6;
    }
  }
}
