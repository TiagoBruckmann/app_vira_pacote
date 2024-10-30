import 'package:device_info_plus/device_info_plus.dart';
import 'package:teste_app_vira_pacote/acquiring_enum.dart';
import 'package:teste_app_vira_pacote/payment/vero/vero_payment.dart';

class PaymentService {

  static Future<bool> validateDevice( Map<String, dynamic> map ) async {
    print("validateDevice => ");
    try {
      String preferredAcquirer = AcquirerEnum.vero.acquirer;
      if ( map.containsKey("preferred_acquiring_payment") ) {
        preferredAcquirer = map["preferred_acquiring_payment"];
      }

      final deviceInfo = DeviceInfoPlugin();
      print("deviceInfo => $deviceInfo");
      final androidInfo = await deviceInfo.androidInfo;
      print("androidInfo => $androidInfo");
      print("preferredAcquirer => $preferredAcquirer");

      switch( preferredAcquirer ) {
        case "vero":
          return await _veroNativePayment(map, androidInfo);
        case "stone":
        case "cielo":
        case "pagseguro":
        case "rede":
        case "caixa":
        case "bin":
        case "sicredi":
        default:
          print("Sem pagamento padrão!");
          return false;
      }

    } catch ( error ) {
      print("error => ${error.toString()}");
      return false;
    }
  }

  static Future<bool> _veroNativePayment( Map<String, dynamic> map, AndroidDeviceInfo androidInfo ) async {

    bool isValidDevice = false;
    for ( final device in DevicesAcceptedByVero.values ) {
      if ( device.device.contains(androidInfo.device) ) {
        isValidDevice = true;
        break;
      }
    }

    if ( !isValidDevice ) {
      print("dispositivo inválido!");
      return false;
    }

    String paymentType = map["payment_type"];
    final paymentData = map["payment_data"];
    print("paymentData => $paymentData");

    switch( paymentType ) {
      case "vero_credit_card_payment":
        return await VeroPayment.veroCreditCardPayment(paymentData);
      default:
        print("Sem pagamento padrão no nativo!");
        return false;
    }

  }

}