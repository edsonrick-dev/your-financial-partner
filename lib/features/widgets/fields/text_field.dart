import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/widgets/fields/shared/field_container.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String label;
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool multiLine;
  final bool optional;

  const AppTextField({
    super.key,
    this.hintText = '',
    this.multiLine = false,
    this.optional = false,
    required this.label,
    required this.focusNode,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppFieldContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label ${optional ? '(Optional)' : ''}'),
          TextField(
            controller: controller,
            focusNode: focusNode,

            keyboardType: multiLine
                ? TextInputType.multiline
                : TextInputType.text,

            minLines: multiLine ? 2 : 1,
            maxLines: multiLine ? 4 : 1,
            maxLength: 250,

            style: const TextStyle(fontSize: 17, height: 24 / 17),
            decoration: InputDecoration(
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
          ),
        ],
      ),
      onTap: () {
        focusNode.requestFocus();
      },
    );
  }
}
