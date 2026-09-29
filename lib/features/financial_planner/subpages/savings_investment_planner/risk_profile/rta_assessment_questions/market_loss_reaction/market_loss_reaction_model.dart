class MarketLossReactionQuestion {
  static const String question =
      'Consider the scenario: Imagine that in the past three months, '
      'the overall stock market lost 25% of its value. An individual '
      'stock you own also lost 25% of its value. What would you do?';

  static const options = MarketLossReaction.values;
}

enum MarketLossReaction { sellAll, sellSome, doNothing, buyMore }

extension MarketLossReactionX on MarketLossReaction {
  String get label {
    switch (this) {
      case MarketLossReaction.sellAll:
        return 'Sell all of my shares.';

      case MarketLossReaction.sellSome:
        return 'Sell some of my shares.';

      case MarketLossReaction.doNothing:
        return 'Do nothing.';

      case MarketLossReaction.buyMore:
        return 'Buy more shares.';
    }
  }

  int get score {
    switch (this) {
      case MarketLossReaction.sellAll:
        return 1;

      case MarketLossReaction.sellSome:
        return 2;

      case MarketLossReaction.doNothing:
        return 3;

      case MarketLossReaction.buyMore:
        return 4;
    }
  }
}
