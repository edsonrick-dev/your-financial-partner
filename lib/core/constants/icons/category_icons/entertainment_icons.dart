import 'package:getx_drift_app/core/constants/icons/app_category_icon.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/category_icons.dart';
import 'package:getx_drift_app/core/constants/icons/icon_groups/icon_groups.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension EntertainmentIcons on CategoryIcons {
  List<AppCategoryIcon> get entertainmentIcons => const [
    AppCategoryIcon(
      key: 'island',
      icon: PhosphorIconsRegular.island,
      group: IconGroup.entertainment,
    ),
    AppCategoryIcon(
      key: 'airplaneInFlight',
      icon: PhosphorIconsRegular.airplaneInFlight,
      group: IconGroup.entertainment,
    ),
    AppCategoryIcon(
      key: 'musicNotes',
      icon: PhosphorIconsRegular.musicNotes,
      group: IconGroup.entertainment,
    ),
    AppCategoryIcon(key: 'basketBall', icon: PhosphorIconsRegular.dribbbleLogo),
    AppCategoryIcon(
      key: 'pawPrint',
      icon: PhosphorIconsRegular.pawPrint,
      group: IconGroup.entertainment,
    ),
  ];
}
