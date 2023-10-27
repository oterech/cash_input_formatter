import 'package:currency_formatter/validators.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CashInputFormatter extends TextInputFormatter {
  final bool useSymbol;

  const CashInputFormatter({this.useSymbol = true});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    late NumberFormat format;
    final NumberFormat thousands = NumberFormat.decimalPattern("en_us");

    format = NumberFormat.currency(
      customPattern: useSymbol ? "\$###,###.0#" : "###,###.0#",
      decimalDigits: 0,
    );

    String formatter(String string) {
      return format.format(
        num.parse(
          thousands
              .format(
                num.parse(
                  string.replaceAll(
                    RegExp(
                      r"\D+",
                    ),
                    "",
                  ),
                ),
              )
              .replaceAll(
                RegExp(
                  r"\D+",
                ),
                "",
              ),
        ),
      );
    }

    String text = newValue.text;

    text = text.replaceAll(
      amountNoSymbol,
      "",
    );

    if (text.isNotEmpty) {
      if (text[text.length - 1] == '.') {
        text = '${formatter(text)}.';
      } else {
        if (text.contains('.')) {
          final List splitAmount = text.split('.');

          final String dollars = splitAmount[0].toString();

          String cents = splitAmount[1].toString();
          if (cents.length > 2) {
            cents = cents.substring(0, 2);
          }

          text = "${formatter(dollars)}.$cents";
        } else {
          if (text.length == 1 && text == r"$") {
            return const TextEditingValue(text: '');
          }
          text = formatter(text);
        }
      }

      return newValue.copyWith(
        text: text,
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: text.length,
          ),
        ),
      );
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(
          offset: text.length,
        ),
      ),
    );
  }
}
