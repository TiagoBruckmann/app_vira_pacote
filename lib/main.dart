import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_app_vira_pacote/payment/payment_service.dart';
import 'package:teste_app_vira_pacote/printer/printer_service.dart';

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
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<void> _printer() async {

    try {
      await PrinterService.validateDevice();

    } on PlatformException catch (e) {
      print("Failed to check printer: '${e.message}'.");
      return;
    }

  }

  Future<void> _creditCardPayment() async {
    try {
      final map = {
        "payment_type": "vero_credit_card_payment",
        "payment_data": 2,
      };

      await PaymentService.validateDevice(map);
    } on PlatformException catch ( error ) {
      print("Failed to _creditCardPayment => ${error.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextButton(
              onPressed: () => _printer(),
              child: const Text(
                "Imprimir comanda!",
              ),
            ),

            TextButton(
              onPressed: () => _creditCardPayment(),
              child: const Text(
                "Pagamento Cartão de crédito!",
              ),
            ),

          ],
        ),
      ),
    );
  }
}
