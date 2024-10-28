import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blue_controller.dart';

class BluetoothHome extends StatelessWidget {
  const BluetoothHome({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BlueController>(context);

    return Center(
      child: controller.connectedDevice == null
          ? ListView.builder(
              itemCount: controller.devices.length,
              itemBuilder: (context, index) {
                final device = controller.devices[index];
                if (device.name != null && device.name!.toLowerCase().contains('esp32')) {
                  return ListTile(
                    title: Text(device.name ?? "Desconocido"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        controller.connectToDevice(device);
                      },
                      child: const Text('Conectar'),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Conectado a: ${controller.connectedDevice?.name ?? "Desconocido"}'),
                const Icon(Icons.bluetooth_connected, size: 50),
                ElevatedButton(
                  onPressed: () {
                    controller.disconnect();
                  },
                  child: const Text('Desconectar'),
                ),
                if (controller.isConnected) // Mostrar mensaje si la conexión fue exitosa
                  const Text('Conexión exitosa!', style: TextStyle(color: Colors.green)),
                if (!controller.isConnected) // Mostrar mensaje de error si no se pudo conectar
                  const Text('No se pudo conectar', style: TextStyle(color: Colors.red)),
              ],
            ),
    );
  }
}
