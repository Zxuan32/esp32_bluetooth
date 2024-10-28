import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página en Blanco'),
      ),
      body: const Center(
        child: Text('Esta es una página en blanco.'),
      ),
    );
  }
}
