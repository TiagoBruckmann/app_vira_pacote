import 'package:teste_app_vira_pacote/acquiring_sdk.dart';

class VeroPayment {

  static Future<bool> veroCreditCardPayment( int amount ) async {
    final map = {
      "amount": amount,
    };
    print("map => $map");
    final response = await AcquiringSdk.veroCreditCardPayment(map);
    print("response veroCreditCardPayment => $response");
    return response;
  }

}