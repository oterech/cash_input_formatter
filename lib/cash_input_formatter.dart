import 'package:cash_input_formatter/validators.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// Currently only supports USD.
class CashInputFormatter extends TextInputFormatter {
  // Pass false to remove the dollar symbol placed.
  final bool useSymbol;

  const CashInputFormatter({this.useSymbol = true});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    late NumberFormat format;
    final NumberFormat thousands = NumberFormat.decimalPattern("en_us");

// Shows the dollar sign by default, with option to remove value using useSymbol
    format = NumberFormat.currency(
      customPattern: useSymbol ? "\$###,###.0#" : "###,###.0#",
      // Removes decimal digits by default.
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

// Removes symbols from text.
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
            // Does not allow for more than two digits after the cents place.
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
            // Sets the cursor to the end of the field
            offset: text.length,
          ),
        ),
      );
    }
    // If text is empty return text, with cursor at the end of the field.
    return newValue.copyWith(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(
          // Sets the cursor to the end of the field
          offset: text.length,
        ),
      ),
    );
  }
}
