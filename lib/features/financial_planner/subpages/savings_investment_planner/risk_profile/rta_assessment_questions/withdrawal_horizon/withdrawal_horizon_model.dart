class WithdrawalHorizonQuestion {
  static const String question =
      'Once I begin withdrawing funds from my investments, I plan to spend all the funds in:';

  static const String description = '';

  static const options = WithdrawalHorizon.values;
}

enum WithdrawalHorizon {
  lessThan2Years,
  twoTo5Years,
  sixTo10Years,
  elevenYearsOrMore,
}

extension WithdrawalHorizonX on WithdrawalHorizon {
  String get label {
    switch (this) {
      case WithdrawalHorizon.lessThan2Years:
        return 'Less than 2 Years';

      case WithdrawalHorizon.twoTo5Years:
        return '2–5 Years';

      case WithdrawalHorizon.sixTo10Years:
        return '6–10 Years';

      case WithdrawalHorizon.elevenYearsOrMore:
        return '11 Years or more';
    }
  }

  int get score {
    switch (this) {
      case WithdrawalHorizon.lessThan2Years:
        return 0;

      case WithdrawalHorizon.twoTo5Years:
        return 1;

      case WithdrawalHorizon.sixTo10Years:
        return 4;

      case WithdrawalHorizon.elevenYearsOrMore:
        return 8;
    }
  }
}
