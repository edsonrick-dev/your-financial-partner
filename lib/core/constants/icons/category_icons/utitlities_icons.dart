import 'package:getx_drift_app/core/constants/icons/app_category_icon.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/category_icons.dart';
import 'package:getx_drift_app/core/constants/icons/icon_groups/icon_groups.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension UtitlitiesIcons on CategoryIcons {
  List<AppCategoryIcon> get utilitiesIcons => const [
    AppCategoryIcon(
      key: 'wifi',
      icon: PhosphorIconsRegular.wifiHigh,
      group: IconGroup.utilities,
    ),
    AppCategoryIcon(
      key: 'lightning',
      icon: PhosphorIconsRegular.lightning,
      group: IconGroup.utilities,
    ),
    AppCategoryIcon(
      key: 'water',
      icon: PhosphorIconsRegular.drop,
      group: IconGroup.utilities,
    ),
    AppCategoryIcon(
      key: 'device-mobile',
      icon: PhosphorIconsRegular.deviceMobile,
      group: IconGroup.utilities,
    ),
  ];
}
