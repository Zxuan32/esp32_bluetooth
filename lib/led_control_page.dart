import 'package:flutter/material.dart';

class LedControlPage extends StatelessWidget {
  const LedControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de LED'),
      ),
      body: const Center(
        child: Text('Página de Control de LED'),
      ),
    );
  }
}
