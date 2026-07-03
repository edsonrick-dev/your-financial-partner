import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: false),
      body: SingleChildScrollView(
        child: Column(
          spacing: 24,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.all(12),
                constraints: BoxConstraints(minHeight: 44),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.appOnSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colorScheme.appBorder),
                ),
                child: Column(
                  spacing: 12,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 12,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.appText,
                              ),
                            ),
                            Column(
                              spacing: 4,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Edson Rick San Juan'),
                                Text('edsonsanjuan@gmail.com'),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    color: colorScheme.appText,
                                  ),
                                  child: Text(
                                    'Free Account',
                                    style: TextStyle(
                                      color: colorScheme.appOnSurface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(PhosphorIconsRegular.pencilSimple),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      constraints: BoxConstraints(minHeight: 44),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: colorScheme.surface,
                        boxShadow: [BoxShadow(offset: Offset(0, 0.5))],
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 8,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Financial Stability Score'),
                                    Row(
                                      children: [
                                        Text(72.toString()),
                                        Text(' / ${80.toString()}'),
                                      ],
                                    ),
                                  ],
                                ),
                                VerticalDivider(color: colorScheme.appBorder),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text('Good'), Text('Keep going!')],
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(PhosphorIconsRegular.caretRight, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SettingsSection(
              children: [
                SettingsTile(
                  icon: PhosphorIconsRegular.gear,
                  title: 'Preferences',
                  subtitle: 'Currency, language, and more',
                  onTap: () {
                    Get.toNamed(Routes.preferences);
                  },
                  color: Colors.purple,
                ),
                SettingsTile(
                  icon: PhosphorIconsRegular.bell,
                  title: 'Notifications',
                  subtitle: 'Manage your reminders and alert',
                  onTap: () {},
                  color: Colors.orange,
                ),
                SettingsTile(
                  icon: PhosphorIconsRegular.shieldStar,
                  title: 'Security',
                  subtitle: 'App locks, biometrics, privacy, and more',
                  onTap: () {},
                  color: Colors.blueAccent,
                ),
              ],
            ),
            SettingsSection(
              children: [
                SettingsTile(
                  icon: PhosphorIconsRegular.cloud,
                  title: 'Data & Backup',
                  subtitle: 'Backup, restore, export, and import data',
                  onTap: () {},
                  color: Colors.lightBlue,
                ),
                SettingsTile(
                  icon: PhosphorIconsRegular.palette,
                  title: 'Appearance',
                  subtitle: 'Theme, color, text, and display',
                  onTap: () {},
                  color: Colors.deepPurple,
                ),
              ],
            ),

            SettingsSection(
              children: [
                SettingsTile(
                  icon: PhosphorIconsRegular.headset,
                  title: 'Support',
                  subtitle: 'Help center, contact support, and feedback',
                  onTap: () {},
                  color: Colors.green,
                ),
                SettingsTile(
                  icon: PhosphorIconsRegular.bell,
                  title: 'About',
                  subtitle: 'App version, terms, and privacy policy',
                  onTap: () {},
                  color: Colors.orange,
                ),
              ],
            ),

            SettingsSection(
              children: [
                SettingsTile(
                  icon: PhosphorIconsRegular.signOut,
                  title: 'Sign out',
                  subtitle: 'Sign out your account',
                  onTap: () {},
                  color: Colors.red,
                ),
              ],
            ),

            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSection(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: BoxConstraints(minHeight: 44),
          width: double.infinity,
          decoration: BoxDecoration(color: colorScheme.appOnSurface),
          child: Column(
            children: List.generate(children.length, (index) {
              final widgets = <Widget>[children[index]];

              if (index != children.length - 1) {
                widgets.add(
                  Divider(
                    height: 0.5,
                    indent: 60,
                    endIndent: 12,
                    color: colorScheme.appBorderMuted,
                  ),
                );
              }
              return Column(children: widgets);
            }),
          ),
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        width: double.infinity,
        child: Row(
          spacing: 12,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(icon, color: color),
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(height: 20 / 15, fontSize: 15)),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: colorScheme.appTextMuted,
                    height: 16 / 12,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(PhosphorIconsRegular.caretRight, size: 20),
          ],
        ),
      ),
    );
  }
}

class AdaptivePressable extends StatefulWidget {
  const AdaptivePressable({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.borderRadius,
    this.pressedColor,
    this.enableHaptics = true,
    this.duration = const Duration(milliseconds: 100),
  });

  final Widget child;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final BorderRadius? borderRadius;

  final Color? pressedColor;

  final bool enableHaptics;

  final Duration duration;

  @override
  State<AdaptivePressable> createState() => _AdaptivePressableState();
}

class _AdaptivePressableState extends State<AdaptivePressable> {
  bool _pressed = false;
  // final bool _hovered = false;

  bool get _isApplePlatform {
    final platform = Theme.of(context).platform;
    return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
  }

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  void _handleTap() {
    if (widget.enableHaptics) {
      HapticFeedback.selectionClick();
    }

    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return _isApplePlatform ? _buildCupertino() : _buildMaterial();
  }

  Widget _buildCupertino() {
    final pressedColor = widget.pressedColor ?? CupertinoColors.systemGrey5;

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,

        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),

        onTap: _handleTap,
        onLongPress: widget.onLongPress,

        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
          child: AnimatedContainer(
            duration: widget.duration,
            decoration: BoxDecoration(
              color: _pressed ? pressedColor : Colors.transparent,
              borderRadius: widget.borderRadius,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Widget _buildMaterial() {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: widget.borderRadius,
        onTap: _handleTap,
        onLongPress: widget.onLongPress,
        child: widget.child,
      ),
    );
  }
}
