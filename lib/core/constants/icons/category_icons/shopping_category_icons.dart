import 'package:getx_drift_app/core/constants/icons/app_category_icon.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/category_icons.dart';
import 'package:getx_drift_app/core/constants/icons/icon_groups/icon_groups.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension ShoppingCategoryIcons on CategoryIcons {
  List<AppCategoryIcon> get shoppingIcons => const [
    AppCategoryIcon(
      key: 'shoppingCart',
      icon: PhosphorIconsRegular.shoppingCart,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'basket',
      icon: PhosphorIconsRegular.basket,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'gift',
      icon: PhosphorIconsRegular.gift,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'shirt',
      icon: PhosphorIconsRegular.tShirt,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'dress',
      icon: PhosphorIconsRegular.dress,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'sneakers',
      icon: PhosphorIconsRegular.sneaker,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'heels',
      icon: PhosphorIconsRegular.highHeel,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'underWear',
      icon: PhosphorIconsRegular.sock,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'pants',
      icon: PhosphorIconsRegular.pants,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'tag',
      icon: PhosphorIconsRegular.tag,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'hanger',
      icon: PhosphorIconsRegular.coatHanger,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'barcode',
      icon: PhosphorIconsRegular.barcode,
      group: IconGroup.shopping,
    ),
  ];
}
