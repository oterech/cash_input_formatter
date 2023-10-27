# currency_formatter

Simple formatter for cash input. Most formatters by default add centers upon input, this formatter will only add decimal places after user inputs a decimal place.

## Usage

``` dart
 TextFormField(
                        textAlign: TextAlign.center,
                        inputFormatters: const [CashInputFormatter()],
                      ),
```