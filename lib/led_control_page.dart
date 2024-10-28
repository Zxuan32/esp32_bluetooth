import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blue_controller.dart';
import 'led_controller.dart';

class LedControlPage extends StatelessWidget {
  const LedControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blueController = Provider.of<BlueController>(context);
    
    if (blueController.connectedDevice == null) {
      return const Center(
        child: Text('No hay dispositivo conectado'),
      );
    }

    final ledController = LedController(blueController.connectedDevice!);

    return ChangeNotifierProvider(
      create: (context) => ledController,
      child: Consumer<LedController>(
        builder: (context, ledController, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Control de LED'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ledController.isLedOn ? 'LED Encendido' : 'LED Apagado',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ledController.toggleLed();
                    },
                    child: Text(ledController.isLedOn ? 'Apagar LED' : 'Encender LED'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
