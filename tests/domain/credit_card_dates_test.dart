import 'package:flutter_test/flutter_test.dart';
import 'package:getx_drift_app/domain/credit_card/credit_card_dates.dart';

void main() {
  group('CreditCardDates.nextStatementDate', () {
    test('uses the statement day when it has not passed', () {
      final result = CreditCardDates.nextStatementDate(
        fromDate: DateTime(2026, 9, 10),
        statementDay: 15,
      );

      expect(result, DateTime(2026, 9, 15));
    });

    test('uses the statement date when today is the statement day', () {
      final result = CreditCardDates.nextStatementDate(
        fromDate: DateTime(2026, 9, 15),
        statementDay: 15,
      );

      expect(result, DateTime(2026, 9, 15));
    });

    test('moves to next month when statement day has passed', () {
      final result = CreditCardDates.nextStatementDate(
        fromDate: DateTime(2026, 9, 20),
        statementDay: 15,
      );

      expect(result, DateTime(2026, 10, 15));
    });

    test('rolls from December into January', () {
      final result = CreditCardDates.nextStatementDate(
        fromDate: DateTime(2026, 12, 20),
        statementDay: 15,
      );

      expect(result, DateTime(2027, 1, 15));
    });

    test('clamps statement day to the last day of a short month', () {
      final result = CreditCardDates.nextStatementDate(
        fromDate: DateTime(2026, 2, 1),
        statementDay: 31,
      );

      expect(result, DateTime(2026, 2, 28));
    });
  });

  group('CreditCardDates.paymentDueDate', () {
    test('uses the same month when due day is after statement day', () {
      final result = CreditCardDates.paymentDueDate(
        statementDate: DateTime(2026, 9, 15),
        paymentDueDay: 20,
      );

      expect(result, DateTime(2026, 9, 20));
    });

    test('uses the same month when due day equals statement day', () {
      final result = CreditCardDates.paymentDueDate(
        statementDate: DateTime(2026, 9, 15),
        paymentDueDay: 15,
      );

      expect(result, DateTime(2026, 9, 15));
    });

    test('moves to the next month when due day is before statement day', () {
      final result = CreditCardDates.paymentDueDate(
        statementDate: DateTime(2026, 9, 20),
        paymentDueDay: 10,
      );

      expect(result, DateTime(2026, 10, 10));
    });

    test('rolls from December into January', () {
      final result = CreditCardDates.paymentDueDate(
        statementDate: DateTime(2026, 12, 20),
        paymentDueDay: 10,
      );

      expect(result, DateTime(2027, 1, 10));
    });

    test('clamps due day to the last day of a short month', () {
      final result = CreditCardDates.paymentDueDate(
        statementDate: DateTime(2026, 2, 10),
        paymentDueDay: 31,
      );

      expect(result, DateTime(2026, 2, 28));
    });
  });

  group('CreditCardDates.advanceStatementDate', () {
    test('advances to the next month', () {
      final result = CreditCardDates.advanceStatementDate(
        currentStatementDate: DateTime(2026, 9, 23),
        statementDay: 23,
      );

      expect(result, DateTime(2026, 10, 23));
    });

    test('rolls December into January', () {
      final result = CreditCardDates.advanceStatementDate(
        currentStatementDate: DateTime(2026, 12, 23),
        statementDay: 23,
      );

      expect(result, DateTime(2027, 1, 23));
    });

    test('clamps day 31 to February 28', () {
      final result = CreditCardDates.advanceStatementDate(
        currentStatementDate: DateTime(2027, 1, 31),
        statementDay: 31,
      );

      expect(result, DateTime(2027, 2, 28));
    });

    test('returns to day 31 after February', () {
      final result = CreditCardDates.advanceStatementDate(
        currentStatementDate: DateTime(2027, 2, 28),
        statementDay: 31,
      );

      expect(result, DateTime(2027, 3, 31));
    });

    test('handles leap year February', () {
      final result = CreditCardDates.advanceStatementDate(
        currentStatementDate: DateTime(2028, 1, 31),
        statementDay: 31,
      );

      expect(result, DateTime(2028, 2, 29));
    });
  });

  group('CreditCardDates.advancePaymentDueDate', () {
    test('uses the same month when due day follows statement day', () {
      final result = CreditCardDates.advancePaymentDueDate(
        nextStatementDate: DateTime(2026, 9, 23),
        paymentDueDay: 24,
      );

      expect(result, DateTime(2026, 9, 24));
    });

    test('uses the following month when due day precedes statement day', () {
      final result = CreditCardDates.advancePaymentDueDate(
        nextStatementDate: DateTime(2026, 9, 23),
        paymentDueDay: 5,
      );

      expect(result, DateTime(2026, 10, 5));
    });

    test('clamps due day 31 in a short month', () {
      final result = CreditCardDates.advancePaymentDueDate(
        nextStatementDate: DateTime(2026, 9, 23),
        paymentDueDay: 31,
      );

      expect(result, DateTime(2026, 9, 30));
    });
  });
}
