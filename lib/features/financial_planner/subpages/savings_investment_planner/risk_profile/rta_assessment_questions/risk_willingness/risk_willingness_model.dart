class RiskWillingnessQuestion {
  static const String question =
      'What amount of financial risk are you willing to take when you invest?';

  static const options = RiskWillingness.values;
}

enum RiskWillingness { belowAverage, average, aboveAverage }

extension RiskWillingnessX on RiskWillingness {
  String get label {
    switch (this) {
      case RiskWillingness.belowAverage:
        return 'Take lower than average risks expecting to earn lower than average returns.';

      case RiskWillingness.average:
        return 'Take average risks expecting to earn average returns.';

      case RiskWillingness.aboveAverage:
        return 'Take above average risk expecting to earn above average returns.';
    }
  }

  int get score {
    switch (this) {
      case RiskWillingness.belowAverage:
        return 1;

      case RiskWillingness.average:
        return 2;

      case RiskWillingness.aboveAverage:
        return 3;
    }
  }
}
