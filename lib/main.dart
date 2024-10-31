import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'add_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final firstNumber = TextEditingController();
  final secondNumber = TextEditingController();

  double? sum;

  bool loading = false;

  void _toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  void dispose() {
    firstNumber.dispose();
    secondNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: firstNumber,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Enter first number',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: secondNumber,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Enter second number',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addNumbersOnTap,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text('Add Numbers'),
              ),
              if (sum != null) ...[
                const SizedBox(height: 20),
                Text('Sum: $sum'),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _addNumbersOnTap() async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      _toggleLoading();
      sum = await add(double.tryParse(firstNumber.text) ?? 0,
          double.tryParse(secondNumber.text) ?? 0);
      _toggleLoading();
    } on PlatformException catch (e) {
      debugPrint('An error occurredL $e');
    }
  }
}
