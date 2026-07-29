import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';

class PersonCard extends StatefulWidget {
  final EntitiesTableData person;
  final bool isSelected;
  final VoidCallback? onTap;
  const PersonCard({
    super.key,
    required this.person,
    this.isSelected = false,
    this.onTap,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PersonCardState createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (_isPressed == value) return;

    setState(() {
      _isPressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      behavior: HitTestBehavior.opaque,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: _isPressed ? 0.5 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.bgLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: colorScheme.appText,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  widget.person.name.trim()[0].toUpperCase(),
                  style: TextStyle(color: colorScheme.surface),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.person.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, height: 20 / 15),
                ),
              ),
              if (widget.isSelected) ...[
                const SizedBox(width: 12),

                Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                  child: const Icon(Icons.check, size: 10, color: Colors.white),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
