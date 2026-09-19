import 'package:getx_drift_app/core/constants/icons/app_category_icon.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/category_icons.dart';
import 'package:getx_drift_app/core/constants/icons/icon_groups/icon_groups.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension EducationIcons on CategoryIcons {
  List<AppCategoryIcon> get educationIcons => const [
    AppCategoryIcon(
      key: 'graduation',
      icon: PhosphorIconsRegular.graduationCap,
      group: IconGroup.education,
    ),
    AppCategoryIcon(
      key: 'schoolSupplies',
      icon: PhosphorIconsRegular.pencilRuler,
      group: IconGroup.education,
    ),
    AppCategoryIcon(
      key: 'books',
      icon: PhosphorIconsRegular.books,
      group: IconGroup.education,
    ),
    AppCategoryIcon(
      key: 'paperclip',
      icon: PhosphorIconsRegular.paperclip,
      group: IconGroup.education,
    ),
    AppCategoryIcon(
      key: 'pencil',
      icon: PhosphorIconsRegular.pencil,
      group: IconGroup.education,
    ),
    AppCategoryIcon(
      key: 'babyCarriage',
      icon: PhosphorIconsRegular.babyCarriage,
      group: IconGroup.education,
    ),
  ];
}
