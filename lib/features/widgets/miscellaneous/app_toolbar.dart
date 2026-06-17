import 'package:flutter/material.dart';

class AppToolbar extends StatelessWidget {
  final bool isDark;
  final String title;
  final VoidCallback? trailingOnPressed;
  final VoidCallback? leadingOnPressed;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final bool showLeading;
  final bool showTrailing;
  const AppToolbar({
    super.key,
    this.isDark = false,
    required this.title,
    this.trailingOnPressed,
    this.leadingOnPressed,
    this.leadingIcon = Icons.close,
    this.trailingIcon = Icons.check,
    this.showLeading = true,
    this.showTrailing = true,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 0),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                height: 24 / 17,
                fontWeight: FontWeight(600),
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Row(
              children: [
                if (leadingOnPressed != null)
                  IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(leadingIcon, size: 20),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        isDark ? Colors.grey[400] : Colors.grey[200],
                      ),
                    ),
                  ),
                Spacer(),
                if (trailingOnPressed != null)
                  IconButton(
                    onPressed: trailingOnPressed,
                    icon: Icon(trailingIcon, size: 20),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        isDark ? Colors.grey[400] : Colors.grey[200],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
