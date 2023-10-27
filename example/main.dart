import 'package:cash_input_formatter/cash_input_formatter.dart';
import 'package:flutter/material.dart';

void main() {
  // To run the example from the root directory, flutter run example
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cash Input Formatter Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Cash Input Formatter Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /// Shows widget with symbol
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("With symbol:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        const Text("Enter amount here"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                          ),
                          child: TextFormField(
                            textAlign: TextAlign.center,

                            /// To use formatter simply add it as an input formatter.
                            inputFormatters: const [
                              CashInputFormatter(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Padding between elements.
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
              ),

              /// Shows widget without symbol
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Without symbol:"),
                        ),
                        const Text("Enter amount here"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            inputFormatters: const [
                              /// To use formatter simply add it as an input formatter.
                              CashInputFormatter(useSymbol: false)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
