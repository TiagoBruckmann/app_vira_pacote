import 'package:flutter/services.dart';

class AcquiringSdk {

  static const _printerPlatform = MethodChannel("acquiring_sdk");

  static Future<void> veroNativePrinter() async {
    final response = await _printerPlatform.invokeMethod<dynamic>("vero_printer");
    print("veroNativePrinter dart => $response");
    return;
  }

  static Future<bool> veroCreditCardPayment( Map<String, dynamic> json ) async {
    final response = await _printerPlatform.invokeMethod<bool>("vero_credit_card_payment", json);
    print("veroCreditCardPayment dart => $response");
    return response ?? false;
  }

}