import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class BlueController extends ChangeNotifier {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? connectedDevice;

  BlueController() {
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    if (await _requestPermissions()) {
      _bluetoothState = await FlutterBluetoothSerial.instance.state;
      notifyListeners();

      if (_bluetoothState == BluetoothState.STATE_ON) {
        await _getPairedDevices();
      }
    }
  }

  Future<bool> _requestPermissions() async {
    final bluetoothStatus = await Permission.bluetooth.request();
    final locationStatus = await Permission.location.request();
    return bluetoothStatus.isGranted && locationStatus.isGranted;
  }

  Future<void> _getPairedDevices() async {
    // Obtiene solo dispositivos que contengan "esp32" en el nombre
    _devices = (await FlutterBluetoothSerial.instance.getBondedDevices())
        .where((device) => device.name?.toLowerCase().contains('esp32') ?? false)
        .toList();
    notifyListeners();
  }

  List<BluetoothDevice> get devices => _devices;

  BluetoothState get bluetoothState => _bluetoothState;

  Future<void> toggleBluetooth() async {
    if (_bluetoothState == BluetoothState.STATE_ON) {
      await FlutterBluetoothSerial.instance.requestDisable();
    } 
    else {
      await FlutterBluetoothSerial.instance.requestEnable();
    }
    _bluetoothState = await FlutterBluetoothSerial.instance.state;
    notifyListeners();
    await _getPairedDevices();
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    connectedDevice = device;
    notifyListeners();
  }

  void disconnect() {
    connectedDevice = null;
    notifyListeners();
  }
}