import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:teste_app_vira_pacote/acquiring_enum.dart';
import 'package:teste_app_vira_pacote/acquiring_sdk.dart';

class PrinterService {

  static Future<void> validateDevice() async {
    print("validateDevice => ");
    try {
      final deviceInfo = DeviceInfoPlugin();
      print("deviceInfo => $deviceInfo");
      final androidInfo = await deviceInfo.androidInfo;
      print("androidInfo => $androidInfo");

      String acquirer = "";
      for ( final item in AcquirerEnum.values ) {
        if ( androidInfo.display.toLowerCase().contains(item.acquirer) ) {
          acquirer = item.acquirer;
          break;
        }
      }
      
      print("acquirer => $acquirer");

      if ( acquirer.trim().isEmpty ) {
        for ( final device in DevicesAcceptedByVero.values ) {
          if ( device.device.contains(androidInfo.device) ) {
            acquirer = AcquirerEnum.vero.acquirer;
            break;
          }
        }
      }
      print("acquirer 2 => $acquirer");

      switch( acquirer ) {
        case "vero":
          _veroNativePrinter(androidInfo);
          break;
        case "stone":
        case "cielo":
        case "pagseguro":
        case "rede":
        case "caixa":
        case "bin":
        case "sicredi":
        default:
          _validateBluetoothConnection();
          break;
      }
    } catch ( error ) {
      print("error => ${error.toString()}");
    }
  }

  static Future<void> _veroNativePrinter( AndroidDeviceInfo androidInfo ) async {
    bool isValidDevice = false;
    for ( final device in DevicesAcceptedByVero.values ) {
      if ( device.device.contains(androidInfo.device) ) {
        isValidDevice = true;
        break;
      }
    }

    if ( !isValidDevice ) {
      print("dispositivo inválido!");
      return;
    }

    await AcquiringSdk.veroNativePrinter();
    print("response _veroNativePrinter => ");
    return;
  }

  static Future<void> _validateBluetoothConnection() async {

    final isBluetoothEnable = await PrintBluetoothThermal.bluetoothEnabled;
    if ( !isBluetoothEnable ) {
      print("Ative o Bluetooth para prosseguir!");
      return;
    }

    final isBluetoothAccepted = await PrintBluetoothThermal.isPermissionBluetoothGranted;
    if ( !isBluetoothAccepted ) {
      print("Aceite as permissões Bluetooth para prosseguir!");
      return;
    }

    final pairedDevices = await PrintBluetoothThermal.pairedBluetooths;
    print("pairedDevices => $pairedDevices");

    if ( pairedDevices.isEmpty ) {
      print("nenhum dispositivo pareado!");
      return;
    }

    BluetoothInfo connectedDevice = pairedDevices.first;

    for ( final device in pairedDevices ) {
      print("device.macAdress => ${device.macAdress}");
      print("device.name => ${device.name}");
      if ( device.name.toLowerCase().contains("fb-") ) {
        connectedDevice = device;
        break;
      }
    }

    print("connectedDevice.macAdress => ${connectedDevice.macAdress}");
    print("connectedDevice.name => ${connectedDevice.name}");

    final connectionStatus = await PrintBluetoothThermal.connectionStatus;
    print("connectionStatus => $connectionStatus");
    if ( !connectionStatus ) {
      final isConnected = await PrintBluetoothThermal.connect(macPrinterAddress: connectedDevice.macAdress);

      if ( !isConnected ) {
        print("conecte-se a um dispositivo para prosseguir!");
        return;
      }
    }

    return await _printOrder();

  }

  static Future<void> _printOrder() async {

    String enter = '\n';
    await PrintBluetoothThermal.writeBytes(enter.codeUnits);

    // responsavel por fazer a impressão!
    await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 1, text: "size 1"));
    await PrintBluetoothThermal.writeBytes(enter.codeUnits);
    await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 2, text: "size 2"));
    await PrintBluetoothThermal.writeBytes(enter.codeUnits);
    await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 3, text: "size 3"));
    await PrintBluetoothThermal.writeBytes(enter.codeUnits);
    await PrintBluetoothThermal.writeBytes(enter.codeUnits);

  }

}