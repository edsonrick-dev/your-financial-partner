import 'package:getx_drift_app/core/constants/icons/app_category_icon.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/category_icons.dart';
import 'package:getx_drift_app/core/constants/icons/icon_groups/icon_groups.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension CarIcons on CategoryIcons {
  List<AppCategoryIcon> get carIcons => const [
    AppCategoryIcon(
      key: 'car',
      icon: PhosphorIconsRegular.car,
      group: IconGroup.mobilityTravel,
    ),
    AppCategoryIcon(
      key: 'bus',
      icon: PhosphorIconsRegular.bus,
      group: IconGroup.mobilityTravel,
    ),
    AppCategoryIcon(
      key: 'train',
      icon: PhosphorIconsRegular.train,
      group: IconGroup.mobilityTravel,
    ),
    AppCategoryIcon(
      key: 'boat',
      icon: PhosphorIconsRegular.boat,
      group: IconGroup.mobilityTravel,
    ),
    AppCategoryIcon(
      key: 'plane',
      icon: PhosphorIconsRegular.airplane,
      group: IconGroup.mobilityTravel,
    ),
    AppCategoryIcon(
      key: 'fuel',
      icon: PhosphorIconsRegular.gasPump,
      group: IconGroup.mobilityTravel,
    ),
    AppCategoryIcon(
      key: 'electricCharge',
      icon: PhosphorIconsRegular.chargingStation,
      group: IconGroup.mobilityTravel,
    ),
  ];
}
