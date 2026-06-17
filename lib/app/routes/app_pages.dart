import 'package:get/get.dart';
import 'package:getx_drift_app/features/accounts/views/accounts_view.dart';
import 'package:getx_drift_app/features/balances/views/people_balances_view.dart';
import 'package:getx_drift_app/features/home/views/home_view.dart';
import 'package:getx_drift_app/features/main_shell/views/main_shell_view.dart';
import 'package:getx_drift_app/features/personal_balance/binding/personal_balance_binding.dart';
import 'package:getx_drift_app/features/personal_balance/screen/personal_balance_details_page.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/root/bindings/root_binding.dart';
import '../../features/root/views/root_view.dart';
import '../../features/transaction/bindings/transaction_binding.dart';
import '../../features/transaction/views/transaction_view.dart';
import 'app_routes.dart';

// import 'package:getx_drift_app/sheets/select_category_sheet.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.PERSONALBALANCE,
      page: () => const PersonalBalanceDetailsPage(),
      binding: PersonalBalanceBinding(),
    ),
    GetPage(
      name: Routes.MAINVIEW,
      page: () => const MainShell(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ROOT,
      page: () => const RootView(),
      binding: RootBinding(),
    ),
    GetPage(
      name: Routes.TRANSACTION,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.PEOPLEBALANCES,
      page: () => const PeopleBalancesView(),
      // binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.ACCOUNTS,
      page: () => const AccountsView(),
      // binding: TransactionBinding(),
    ),
  ];
}
