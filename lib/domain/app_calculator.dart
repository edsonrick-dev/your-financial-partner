// ignore_for_file: unused_element_parameter

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class AppCalculator extends GetView<AppCalculatorController> {
  const AppCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final gridSpacing = 8.0;
    return AppSheet(
      adaptiveHeight: true,
      minHeight: 0,
      title: 'Amount',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(
                  () => Text(
                    controller.expression.value,
                    style: AppTextStyle.bodyM.copyWith(
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    controller.display.value.toCurrency(
                      symbol: '',
                      decimalDigits: controller.decimalDigits,
                    ),
                    style: AppTextStyle.amountXL,
                  ),
                ),
              ],
            ),
          ),
          Divider(indent: 16, endIndent: 16, color: colorScheme.appBorderMuted),
          AppSection(
            child: Column(
              spacing: gridSpacing,
              children: [
                Row(
                  spacing: gridSpacing,
                  children: [
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appErrorSoft,
                        color: colorScheme.appError,
                        text: 'C',
                        onTap: () => controller.clear(),
                      ),
                    ),
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appNeutralSoft,
                        color: colorScheme.appText,
                        onTap: () => controller.backspace(),
                        isIcon: true,
                        icon: Icons.backspace_outlined,
                      ),
                    ),
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appNeutralSoft,
                        color: colorScheme.appText,
                        text: '%',
                        onTap: () => controller.input('%'),
                      ),
                    ),
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appInfoSoft,
                        color: colorScheme.appInfo,
                        text: '÷',
                        onTap: () => controller.input('÷'),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: gridSpacing,
                  children: [
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appNeutralSoft,
                        color: colorScheme.appText,
                        text: '7',
                        onTap: () => controller.input('7'),
                      ),
                    ),
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appNeutralSoft,
                        color: colorScheme.appText,
                        text: '8',
                        onTap: () => controller.input('8'),
                      ),
                    ),
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appNeutralSoft,
                        color: colorScheme.appText,
                        text: '9',
                        onTap: () => controller.input('9'),
                      ),
                    ),
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appInfoSoft,
                        color: colorScheme.appInfo,
                        text: 'x',
                        onTap: () => controller.input('x'),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: gridSpacing,
                  children: [
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appNeutralSoft,
                        color: colorScheme.appText,
                        text: '4',
                        onTap: () => controller.input('4'),
                      ),
                    ),
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appNeutralSoft,
                        color: colorScheme.appText,
                        text: '5',
                        onTap: () => controller.input('5'),
                      ),
                    ),
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appNeutralSoft,
                        color: colorScheme.appText,
                        text: '6',
                        onTap: () => controller.input('6'),
                      ),
                    ),
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appInfoSoft,
                        color: colorScheme.appInfo,
                        text: '-',
                        onTap: () => controller.input('-'),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: gridSpacing,
                  children: [
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appNeutralSoft,
                        color: colorScheme.appText,
                        text: '1',
                        onTap: () => controller.input('1'),
                      ),
                    ),
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appNeutralSoft,
                        color: colorScheme.appText,
                        text: '2',
                        onTap: () => controller.input('2'),
                      ),
                    ),
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appNeutralSoft,
                        color: colorScheme.appText,
                        text: '3',
                        onTap: () => controller.input('3'),
                      ),
                    ),
                    Expanded(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appInfoSoft,
                        color: colorScheme.appInfo,
                        text: '+',
                        onTap: () => controller.input('+'),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: gridSpacing,
                  children: [
                    Flexible(
                      flex: 2,
                      child: _CalculatorButton(
                        bgColor: colorScheme.appNeutralSoft,
                        color: colorScheme.appText,
                        text: '0',
                        onTap: () => controller.input('0'),
                      ),
                    ),

                    Flexible(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appNeutralSoft,
                        color: colorScheme.appText,
                        text: '.',
                        onTap: () => controller.input('.'),
                      ),
                    ),
                    Flexible(
                      child: _CalculatorButton(
                        bgColor: colorScheme.appInflow,
                        color: colorScheme.bg,
                        icon: Icons.check_rounded,
                        isIcon: true,
                        onTap: () {
                          final amount = controller.confirm();

                          Get.back(result: amount);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CalculatorButton extends StatelessWidget {
  final Color color;
  final Color bgColor;
  final String? text;
  final VoidCallback? onTap;
  final bool isIcon;
  final IconData? icon;
  const _CalculatorButton({
    required this.bgColor,
    required this.color,
    this.text,
    this.isIcon = false,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: isIcon
              ? Icon(icon, size: 20, color: color)
              : Text(text!, style: AppTextStyle.amountM.copyWith(color: color)),
        ),
      ),
    );
  }
}

class AppCalculatorController extends GetxController {
  final display = 0.0.obs;
  final expression = ''.obs;

  double _currentValue = 0;
  double? _storedValue;

  String? _operator;

  bool _isEnteringNewValue = false;
  bool _isDecimal = false;
  int _decimalPlaces = 0;
  void initialize(double value) {
    _currentValue = value;
    display.value = value;
    expression.value = '';

    _storedValue = null;
    _operator = null;

    // If user starts typing a digit, replace the existing amount.
    _isEnteringNewValue = value != 0;

    _isDecimal = value % 1 != 0;
    _decimalPlaces = _isDecimal ? value.toString().split('.').last.length : 0;
  }

  void input(String value) {
    if (_isOperator(value)) {
      _setOperator(value);
      return;
    }

    if (value == '%') {
      _percentage();
      return;
    }

    if (value == '.') {
      _decimal();
      return;
    }

    if (_isDigit(value)) {
      _digit(value);
    }
  }

  void clear() {
    display.value = 0;
    expression.value = '';

    _currentValue = 0;
    _storedValue = null;
    _operator = null;

    _isEnteringNewValue = false;
    _isDecimal = false;
    _decimalPlaces = 0;
  }

  void backspace() {
    if (_isEnteringNewValue) {
      return;
    }

    if (_isDecimal) {
      if (_decimalPlaces > 0) {
        final multiplier = pow(10, _decimalPlaces - 1);
        _currentValue =
            (_currentValue * multiplier).truncateToDouble() / multiplier;

        _decimalPlaces--;

        display.value = _currentValue;

        if (_decimalPlaces == 0) {
          _isDecimal = false;
        }

        return;
      }

      _isDecimal = false;
      display.value = _currentValue;
      return;
    }

    _currentValue = (_currentValue / 10).floorToDouble();

    display.value = _currentValue;
  }

  double confirm() {
    if (_operator != null && _storedValue != null) {
      _calculate();
    }

    return _currentValue;
  }

  bool _isDigit(String value) {
    return RegExp(r'^\d$').hasMatch(value);
  }

  bool _isOperator(String value) {
    return value == '+' || value == '-' || value == 'x' || value == '÷';
  }

  void _digit(String value) {
    final digit = int.parse(value);

    if (_isEnteringNewValue) {
      _currentValue = digit.toDouble();

      _isEnteringNewValue = false;
      _isDecimal = false;
      _decimalPlaces = 0;

      _updateDisplay();

      return;
    }

    if (_isDecimal) {
      _decimalPlaces++;

      _currentValue += digit / pow(10, _decimalPlaces);

      _updateDisplay();

      return;
    }

    if (_currentValue == 0) {
      _currentValue = digit.toDouble();
    } else {
      _currentValue = _currentValue * 10 + digit;
    }

    _updateDisplay();
  }

  void _updateDisplay() {
    if (_storedValue != null && _operator != null) {
      display.value = _calculatePreview();
    } else {
      display.value = _currentValue;
    }

    _updateExpression();
  }

  void _updateExpression() {
    if (_storedValue == null || _operator == null) {
      expression.value = '';
      display.value = _currentValue;
      return;
    }

    expression.value =
        '${_formatNumber(_storedValue!)} $_operator ${_formatNumber(_currentValue)}';

    display.value = _calculatePreview();
  }

  double _calculatePreview() {
    final first = _storedValue!;
    final second = _currentValue;

    switch (_operator) {
      case '+':
        return first + second;

      case '-':
        return first - second;

      case 'x':
        return first * second;

      case '÷':
        if (second == 0) {
          return 0;
        }

        return first / second;

      default:
        return second;
    }
  }

  String _formatNumber(double value) {
    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }

    return value.toString();
  }

  void _decimal() {
    if (_isEnteringNewValue) {
      display.value = 0;
      _currentValue = 0;

      _isEnteringNewValue = false;
    }

    if (_isDecimal) {
      return;
    }

    _isDecimal = true;
    _decimalPlaces = 0;
  }

  void _setOperator(String operator) {
    if (_operator != null && !_isEnteringNewValue) {
      _calculate();
    }

    _storedValue = _currentValue;
    _operator = operator;

    expression.value = '${_formatNumber(_storedValue!)} $operator';

    _isEnteringNewValue = true;
    _isDecimal = false;
    _decimalPlaces = 0;
  }

  void _percentage() {
    _currentValue /= 100;

    _updateExpression();
  }

  void _calculate() {
    if (_storedValue == null || _operator == null) {
      return;
    }

    final first = _storedValue!;
    final second = _currentValue;
    final operator = _operator!;

    switch (operator) {
      case '+':
        _currentValue = first + second;
        break;

      case '-':
        _currentValue = first - second;
        break;

      case 'x':
        _currentValue = first * second;
        break;

      case '÷':
        if (second == 0) {
          clear();
          return;
        }

        _currentValue = first / second;
        break;
    }

    expression.value =
        '${_formatNumber(first)} $operator ${_formatNumber(second)}';

    display.value = _currentValue;

    _storedValue = _currentValue;
    _operator = null;

    _isEnteringNewValue = true;
    _isDecimal = false;
    _decimalPlaces = 0;
  }

  int get decimalDigits {
    final value = display.value.abs();

    if (value == value.truncateToDouble()) {
      return 0;
    }

    final text = value.toString();

    final decimalIndex = text.indexOf('.');

    if (decimalIndex == -1) {
      return 0;
    }

    final decimals = text.length - decimalIndex - 1;

    return decimals.clamp(2, 8);
  }
}
