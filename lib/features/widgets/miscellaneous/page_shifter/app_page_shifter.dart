import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AppPageShifter extends StatefulWidget {
  const AppPageShifter({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  State<AppPageShifter> createState() => _AppPageShifterState();
}

class _AppPageShifterState extends State<AppPageShifter> {
  final List<GlobalKey> _itemKeys = [];

  double _indicatorLeft = 0;
  double _indicatorWidth = 0;

  @override
  void initState() {
    super.initState();
    _updateKeys();
  }

  @override
  void didUpdateWidget(covariant AppPageShifter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.items.length != widget.items.length ||
        oldWidget.selectedIndex != widget.selectedIndex) {
      _updateKeys();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateIndicator();
      });
    }
  }

  void _updateKeys() {
    _itemKeys
      ..clear()
      ..addAll(List.generate(widget.items.length, (_) => GlobalKey()));
  }

  void _updateIndicator() {
    if (!mounted ||
        widget.selectedIndex < 0 ||
        widget.selectedIndex >= _itemKeys.length) {
      return;
    }

    final context = _itemKeys[widget.selectedIndex].currentContext;

    if (context == null) return;

    final renderBox = context.findRenderObject() as RenderBox;

    final position = renderBox.localToGlobal(Offset.zero);
    final parentBox = context.findAncestorRenderObjectOfType<RenderBox>();

    if (parentBox == null) return;

    final parentPosition = parentBox.localToGlobal(Offset.zero);

    setState(() {
      _indicatorLeft = position.dx - parentPosition.dx;
      _indicatorWidth = renderBox.size.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateIndicator();
    });

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: colorScheme.pageShifterFillUnselected,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            left: _indicatorLeft,
            width: _indicatorWidth,
            top: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colorScheme.pageShifterFillSelected,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),

          Row(
            children: List.generate(widget.items.length, (index) {
              final selected = widget.selectedIndex == index;

              return GestureDetector(
                key: _itemKeys[index],
                onTap: () => widget.onChanged(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                    child: Text(
                      widget.items[index],
                      style: AppTextStyle.titleL.copyWith(
                        color: selected
                            ? colorScheme.pageShifterTextSelected
                            : colorScheme.pageShifterTextUnselected,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
