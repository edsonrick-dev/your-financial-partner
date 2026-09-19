import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/icons/app_category_icon.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/category_icons.dart';
import 'package:getx_drift_app/core/constants/icons/icon_groups/icon_groups.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension SystemIcons on CategoryIcons {
  List<AppCategoryIcon> get systemIcons => const [
    AppCategoryIcon(
      key: 'user',
      icon: PhosphorIconsRegular.user,
      group: IconGroup.system,
    ),
    AppCategoryIcon(
      key: 'calendar',
      icon: PhosphorIconsRegular.calendarBlank,
      group: IconGroup.system,
    ),
    AppCategoryIcon(
      key: 'deposit',
      icon: PhosphorIconsRegular.handDeposit,
      group: IconGroup.system,
    ),
    AppCategoryIcon(
      key: 'withdraw',
      icon: PhosphorIconsRegular.handWithdraw,
      group: IconGroup.system,
    ),
    AppCategoryIcon(
      key: 'sync_alt_sharp',
      icon: Icons.sync_alt_sharp,
      group: IconGroup.system,
    ),
  ];
}
