import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/icons/app_category_icon.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/car_icons.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/education_icons.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/entertainment_icons.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/financial_icons.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/groceries_category_icons.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/real_property_icons.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/shopping_category_icons.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/system_icons.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/utitlities_icons.dart';
import 'package:getx_drift_app/core/constants/icons/icon_groups/icon_groups.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';

class CategoryIcons {
  List<AppCategoryIcon> get availableIcons => [
    ...financialIcons,
    ...realPropertyIcons,
    ...shoppingIcons,
    ...entertainmentIcons,
    ...utilitiesIcons,
    ...carIcons,
    ...educationIcons,
    ...groceriesIcons,
    ...systemIcons,

    ///SHOPPING ICONS
    AppCategoryIcon(key: 'stack', icon: PhosphorIconsRegular.stack),

    AppCategoryIcon(key: 'handCoins', icon: PhosphorIconsRegular.handCoins),
    AppCategoryIcon(key: 'coins', icon: PhosphorIconsRegular.coins),

    AppCategoryIcon(
      key: 'arrowsClockwise',
      icon: PhosphorIconsRegular.arrowsClockwise,
    ),

    AppCategoryIcon(key: 'usersThree', icon: PhosphorIconsRegular.usersThree),

    AppCategoryIcon(key: 'heartbeat', icon: PhosphorIconsRegular.heartbeat),

    ///OFFICE ICONS
    const AppCategoryIcon(
      key: AppIcons.fallbackKey,
      icon: Icons.category_outlined,
    ),
  ];

  // late final Map<String, IconData> resolver = {
  //   for (final item in availableIcons) item.key: item.icon,
  // };

  // IconData resolve(String key) {
  //   return resolver[key] ?? AppIcons.fallback;
  // }

  late final Map<String, AppCategoryIcon> _resolver = {
    for (final item in availableIcons) item.key: item,
  };

  IconData resolve(String key) {
    return _resolver[key]?.icon ?? AppIcons.fallback;
  }

  AppCategoryIcon? find(String key) {
    return _resolver[key];
  }

  List<AppCategoryIcon> byGroup(IconGroup group) {
    return availableIcons
        .where((icon) => icon.group == group)
        .toList(growable: false);
  }
}
