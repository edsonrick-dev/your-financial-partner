import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum IconGroup {
  general,
  people,
  groceries,
  clothing,
  shopping,
  office,
  workProfession,
  financeInsurance,
  leisure,
  health,
  sports,
  animals,
  electronicsCommunication,
  education,
  mobilityTravel,
  beauty,
  musicEntertainment,
  friendsFamily,
  household,
  buildings,
  nature,
  brands,
  others,
}

class AppIcons {
  AppIcons._();

  static const fallbackKey = 'fallback';

  static const fallback = Icons.help_outline;

  static final categories = _CategoryIcons();
  static final system = _SystemIcons();

  static const Map<String, IconData> icons = {
    // 'calendar': Icons.calendar_today_outlined,
    // 'wallet': Icons.account_balance_wallet_outlined,
    // 'category': Icons.category_outlined,
  };
  static IconData get(String key) {
    return icons[key] ?? Icons.help_outline;
  }
}

class AppCategoryIcon {
  final String key;
  final IconData icon;
  final IconGroup? group;

  const AppCategoryIcon({
    required this.key,
    required this.icon,
    this.group = IconGroup.general,
  });
}

class _SystemIcons {
  final List<AppCategoryIcon> availableIcons = [
    const AppCategoryIcon(key: 'calendar', icon: Icons.calendar_month),
  ];

  late final Map<String, IconData> resolver = {
    for (final item in availableIcons) item.key: item.icon,
  };
  IconData resolve(String key) {
    return resolver[key] ?? AppIcons.fallback;
  }
}

class _CategoryIcons {
  final List<AppCategoryIcon> availableIcons = [
    ///SHOPPING ICONS
    AppCategoryIcon(
      key: 'stack',
      icon: PhosphorIconsRegular.stack,
      group: IconGroup.others,
    ),
    AppCategoryIcon(
      key: 'caretDown',
      icon: PhosphorIconsRegular.caretDown,
      group: IconGroup.others,
    ),
    AppCategoryIcon(
      key: 'stack',
      icon: PhosphorIconsRegular.stack,
      group: IconGroup.others,
    ),
    AppCategoryIcon(
      key: 'calendar',
      icon: PhosphorIconsRegular.calendarBlank,
      group: IconGroup.others,
    ),
    AppCategoryIcon(
      key: 'user',
      icon: PhosphorIconsRegular.user,
      group: IconGroup.others,
    ),
    AppCategoryIcon(
      key: 'gift',
      icon: PhosphorIconsRegular.gift,
      group: IconGroup.others,
    ),
    AppCategoryIcon(
      key: 'handCoins',
      icon: PhosphorIconsRegular.handCoins,
      group: IconGroup.others,
    ),
    AppCategoryIcon(
      key: 'coins',
      icon: PhosphorIconsRegular.coins,
      group: IconGroup.others,
    ),
    AppCategoryIcon(
      key: 'forkKnife',
      icon: PhosphorIconsRegular.forkKnife,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'bowlFood',
      icon: PhosphorIconsRegular.bowlFood,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'bowlSteam',
      icon: PhosphorIconsRegular.bowlSteam,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'fish',
      icon: PhosphorIconsRegular.fish,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'shrimp',
      icon: PhosphorIconsRegular.shrimp,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'hamburger',
      icon: PhosphorIconsRegular.hamburger,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'business',
      icon: PhosphorIconsRegular.buildingOffice,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'pizza',
      icon: PhosphorIconsRegular.pizza,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'beerBottle',
      icon: PhosphorIconsRegular.beerBottle,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'beerStein',
      icon: PhosphorIconsRegular.beerStein,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'brandy',
      icon: PhosphorIconsRegular.brandy,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'champagne',
      icon: PhosphorIconsRegular.champagne,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'cheers',
      icon: PhosphorIconsRegular.cheers,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'martini',
      icon: PhosphorIconsRegular.martini,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'coffee',
      icon: PhosphorIconsRegular.coffee,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'airplaneInFlight',
      icon: PhosphorIconsRegular.airplaneInFlight,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'arrowsClockwise',
      icon: PhosphorIconsRegular.arrowsClockwise,
      group: IconGroup.others,
    ),
    AppCategoryIcon(
      key: 'island',
      icon: PhosphorIconsRegular.island,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'gasPump',
      icon: PhosphorIconsRegular.gasPump,
      group: IconGroup.groceries,
    ),

    AppCategoryIcon(
      key: 'books',
      icon: PhosphorIconsRegular.books,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'pawPrint',
      icon: PhosphorIconsRegular.pawPrint,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'cookingPot',
      icon: PhosphorIconsRegular.cookingPot,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'babyCarriage',
      icon: PhosphorIconsRegular.babyCarriage,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'car',
      icon: PhosphorIconsRegular.car,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'musicNotes',
      icon: PhosphorIconsRegular.musicNotes,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'usersThree',
      icon: PhosphorIconsRegular.usersThree,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'dribbbleLogo',
      icon: PhosphorIconsRegular.dribbbleLogo,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'graduationCap',
      icon: PhosphorIconsRegular.graduationCap,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'shieldPlus',
      icon: PhosphorIconsRegular.shieldPlus,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'heartbeat',
      icon: PhosphorIconsRegular.heartbeat,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'jar',
      icon: PhosphorIconsRegular.jar,
      group: IconGroup.groceries,
    ),

    AppCategoryIcon(
      key: 'coffeeBean',
      icon: PhosphorIconsRegular.coffeeBean,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'cheese',
      icon: PhosphorIconsRegular.cheese,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'bread',
      icon: PhosphorIconsRegular.bread,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'onigiri',
      icon: PhosphorIconsRegular.onigiri,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'popocorn',
      icon: PhosphorIconsRegular.popcorn,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'bread',
      icon: PhosphorIconsRegular.bread,
      group: IconGroup.groceries,
    ),

    AppCategoryIcon(
      key: 'cookie',
      icon: PhosphorIconsRegular.cookie,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'egg',
      icon: PhosphorIconsRegular.egg,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'carrot',
      icon: PhosphorIconsRegular.carrot,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'cherries',
      icon: PhosphorIconsRegular.cherries,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'orange',
      icon: PhosphorIconsRegular.orange,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'orangeSlice',
      icon: PhosphorIconsRegular.orangeSlice,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'avocado',
      icon: PhosphorIconsRegular.avocado,
      group: IconGroup.groceries,
    ),
    AppCategoryIcon(
      key: 'iceCream',
      icon: PhosphorIconsRegular.iceCream,
      group: IconGroup.groceries,
    ),

    ///SHOPPING ICONS
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
      key: 'tag',
      icon: PhosphorIconsRegular.tag,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'barcode',
      icon: PhosphorIconsRegular.barcode,
      group: IconGroup.shopping,
    ),

    ///OFFICE ICONS
    AppCategoryIcon(
      key: 'paperclip',
      icon: PhosphorIconsRegular.paperclip,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'pencil',
      icon: PhosphorIconsRegular.pencil,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'chartLine',
      icon: PhosphorIconsRegular.chartLine,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'chartLineDown',
      icon: PhosphorIconsRegular.chartLineDown,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'chartLineUp',
      icon: PhosphorIconsRegular.chartLineUp,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'suitCase',
      icon: PhosphorIconsRegular.suitcase,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'money',
      icon: PhosphorIconsRegular.money,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'houseLine',
      icon: PhosphorIconsRegular.houseLine,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'house',
      icon: PhosphorIconsRegular.house,
      group: IconGroup.shopping,
    ),

    AppCategoryIcon(
      key: 'sync_alt_sharp',
      icon: Icons.sync_alt_sharp,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'handDeposit',
      icon: PhosphorIconsRegular.handDeposit,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(
      key: 'handWithdraw',
      icon: PhosphorIconsRegular.handWithdraw,
      group: IconGroup.shopping,
    ),
    AppCategoryIcon(key: 'wallet', icon: PhosphorIconsRegular.wallet),
    AppCategoryIcon(key: 'creditCard', icon: PhosphorIconsRegular.creditCard),
    AppCategoryIcon(key: 'piggyBank', icon: PhosphorIconsRegular.piggyBank),
    const AppCategoryIcon(
      key: AppIcons.fallbackKey,
      icon: Icons.category_outlined,
    ),

    const AppCategoryIcon(
      key: AppIcons.fallbackKey,
      icon: Icons.category_outlined,
    ),

    const AppCategoryIcon(
      key: 'default',
      icon: Icons.account_balance_wallet_outlined,
    ),
  ];

  late final Map<String, IconData> resolver = {
    for (final item in availableIcons) item.key: item.icon,
  };

  IconData resolve(String key) {
    return resolver[key] ?? AppIcons.fallback;
  }
}
