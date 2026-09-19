import 'package:getx_drift_app/core/constants/icons/app_category_icon.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/category_icons.dart';
import 'package:getx_drift_app/core/constants/icons/icon_groups/icon_groups.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension RealPropertyIcons on CategoryIcons {
  List<AppCategoryIcon> get realPropertyIcons => const [
    AppCategoryIcon(
      key: 'building',
      icon: PhosphorIconsRegular.buildingOffice,
      group: IconGroup.realProperty,
    ),
    AppCategoryIcon(
      key: 'house',
      icon: PhosphorIconsRegular.houseLine,
      group: IconGroup.realProperty,
    ),
  ];
}
