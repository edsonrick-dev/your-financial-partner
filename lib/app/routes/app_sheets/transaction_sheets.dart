/// DO NOT DELETE — central transaction sheet launcher/registry.
///
/// Central entry point for opening transaction-related sheets.
///
/// This class intentionally provides a single public interface for
/// launching transaction sheets throughout the application.
///
/// Transaction-specific implementations may be split into extensions,
/// for example:
///
/// - `transaction_sheets_earn.dart`
/// - `transaction_sheets_spend.dart`
/// - `transaction_sheets_transfer.dart`
/// - `transaction_sheets_card_payment.dart`
/// - `transaction_sheets_debt_repayment.dart`
///
/// All extensions attach their methods to this class.
///
/// Example:
///
/// ```dart
/// AppSheets.transaction.earn();
/// AppSheets.transaction.spend();
/// AppSheets.transaction.transfer();
/// AppSheets.transaction.payCreditCard(
///   creditCard: account,
/// );
/// ```
///
/// Do not replace this architecture with direct `Get.bottomSheet()`
/// calls scattered throughout feature code. Keeping sheet launching
/// behind this class gives the application a consistent entry point and
/// allows transaction-specific logic to remain modular.
///
/// The class may appear empty because its behavior can be supplied by
/// extension files. That is intentional.
class TransactionSheets {}
