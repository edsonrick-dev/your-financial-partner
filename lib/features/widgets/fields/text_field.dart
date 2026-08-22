import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/widgets/fields/shared/field_container.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String label;
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool multiLine;
  final bool optional;
  final ValueChanged<String>? onChanged;
  final String? prefixText;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    this.hintText = '',
    this.multiLine = false,
    this.optional = false,
    this.keyboardType,
    this.prefixText,
    this.onChanged,
    required this.label,
    required this.focusNode,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppFieldContainer(
      fixedHeight: !multiLine,
      onTap: () {
        focusNode.requestFocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ${optional ? '(Optional)' : ''}',
            style: AppTextStyle.titleM,
          ),
          TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType:
                keyboardType ??
                (multiLine ? TextInputType.multiline : TextInputType.text),
            minLines: multiLine ? 3 : 1,
            maxLines: multiLine ? 6 : 1,
            maxLength: 250,
            textInputAction: multiLine
                ? TextInputAction.newline
                : TextInputAction.done,
            style: AppTextStyle.titleM,
            decoration: InputDecoration(
              prefixText: prefixText ?? '',
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: hintText,
            ),
            buildCounter:
                (
                  context, {
                  required currentLength,
                  required isFocused,
                  required maxLength,
                }) => null,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
