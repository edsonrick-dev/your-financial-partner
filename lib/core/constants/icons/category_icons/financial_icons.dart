import 'package:getx_drift_app/core/constants/icons/app_category_icon.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/category_icons.dart';
import 'package:getx_drift_app/core/constants/icons/icon_groups/icon_groups.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension FinancialIcons on CategoryIcons {
  List<AppCategoryIcon> get financialIcons => const [
    AppCategoryIcon(
      key: 'money',
      icon: PhosphorIconsRegular.money,
      group: IconGroup.finance,
    ),
    AppCategoryIcon(
      key: 'creditCard',
      icon: PhosphorIconsRegular.creditCard,
      group: IconGroup.finance,
    ),
    AppCategoryIcon(
      key: 'wallet',
      icon: PhosphorIconsRegular.wallet,
      group: IconGroup.finance,
    ),
    AppCategoryIcon(
      key: 'withdraw',
      icon: PhosphorIconsRegular.handWithdraw,
      group: IconGroup.finance,
    ),
    AppCategoryIcon(
      key: 'shieldPlus',
      icon: PhosphorIconsRegular.shieldPlus,
      group: IconGroup.finance,
    ),
    AppCategoryIcon(
      key: 'suitCase',
      icon: PhosphorIconsRegular.suitcase,
      group: IconGroup.finance,
    ),

    AppCategoryIcon(
      key: 'piggyBank',
      icon: PhosphorIconsRegular.piggyBank,
      group: IconGroup.finance,
    ),
    AppCategoryIcon(
      key: 'bank',
      icon: PhosphorIconsRegular.bank,
      group: IconGroup.finance,
    ),
    AppCategoryIcon(
      key: 'chartLine',
      icon: PhosphorIconsRegular.chartLine,
      group: IconGroup.finance,
    ),
    AppCategoryIcon(
      key: 'chartLineDown',
      icon: PhosphorIconsRegular.chartLineDown,
      group: IconGroup.finance,
    ),
    AppCategoryIcon(
      key: 'chartLineUp',
      icon: PhosphorIconsRegular.chartLineUp,
      group: IconGroup.finance,
    ),
  ];
}
