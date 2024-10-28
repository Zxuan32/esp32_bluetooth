import 'package:flutter/material.dart';
import 'blue_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BlueController(),
      child: const MaterialApp(
        title: 'Bluetooth App',
        debugShowCheckedModeBanner: false,
        home: BluetoothHome(),
      ),
    );
  }
}

class BluetoothHome extends StatelessWidget {
  const BluetoothHome({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BlueController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispositivos Bluetooth'),
        actions: [
          IconButton(
            icon: Icon(controller.bluetoothState == BluetoothState.STATE_ON
                ? Icons.bluetooth_connected
                : Icons.bluetooth_disabled),
            onPressed: () {
              controller.toggleBluetooth();
            },
          ),
        ],
      ),
      body: Center(
        child: controller.connectedDevice == null
            ? ListView.builder(
                itemCount: controller.devices.length,
                itemBuilder: (context, index) {
                  final device = controller.devices[index];
                  return ListTile(
                    title: Text(device.name ?? "Desconocido"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        controller.connectToDevice(device);
                      },
                      child: const Text('Conectar'),
                    ),
                  );
                },
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Conectado a: ${controller.connectedDevice?.name ?? "Desconocido"}'),
                  const Icon(Icons.bluetooth_connected, size: 50), // Ícono de conexión
                  ElevatedButton(
                    onPressed: () {
                      controller.disconnect();
                    },
                    child: const Text('Desconectar'),
                  ),
                ],
              ),
      ),
    );
  }
}
