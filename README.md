# cash_input_formatter

Simple formatter for cash input. Most formatters by default add centers upon input, this formatter will only add decimal places after user inputs a decimal place. To run the example app from the root flutter use 'flutter pub run example'

## Usage

``` dart
 TextFormField(
                        textAlign: TextAlign.center,
                        inputFormatters: const [CashInputFormatter()],
                      ),
```