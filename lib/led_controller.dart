import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // Agrega esta línea

class LedController extends ChangeNotifier {
  final BluetoothDevice device;
  bool isLedOn = false;

  LedController(this.device);

  Future<void> toggleLed() async {
    if (isLedOn) {
      await _sendCommand('LED OFF'); // Comando para apagar el LED
      isLedOn = false;
    } else {
      await _sendCommand('LED ON'); // Comando para encender el LED
      isLedOn = true;
    }
    notifyListeners();
  }

  Future<void> _sendCommand(String command) async {
    // Aquí es donde envías el comando al ESP32
    // Debes establecer la conexión Bluetooth antes de enviar
    // Este es solo un ejemplo; implementa la lógica de conexión según tu necesidad.
    BluetoothConnection connection = await BluetoothConnection.toAddress(device.address);
    connection.output.add(utf8.encode(command + "\r\n")); // Enviar el comando
    await connection.output.allSent; // Esperar que se envíen todos los datos
    connection.dispose(); // Cerrar la conexión
  }
}
