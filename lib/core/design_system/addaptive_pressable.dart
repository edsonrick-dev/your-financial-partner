import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    // final pressedColor = widget.pressedColor ?? CupertinoColors.systemGrey5;

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
          child: AnimatedScale(
            scale: _pressed ? 0.97 : 1,
            duration: widget.duration,
            child: AnimatedOpacity(
              opacity: _pressed ? 0.65 : 1,
              duration: widget.duration,
              child: Container(
                decoration: BoxDecoration(
                  // color: _pressed ? pressedColor : Colors.transparent,
                  borderRadius: widget.borderRadius,
                ),
                child: widget.child,
              ),
            ),
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
