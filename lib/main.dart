import 'package:flutter/material.dart';
import 'blank_page.dart';
import 'led_control_page.dart';
import 'bluetooth_home.dart';
import 'blue_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BlueController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bluetooth App',
      debugShowCheckedModeBanner: false,
      home: NavigationBar(),
    );
  }
}

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0; // Variable para controlar el índice seleccionado

  final List<Widget> _pages = const [
    BluetoothHome(),
    LedControlPage(),
    BlankPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Actualizar el índice seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blue App'),
      ),
      body: IndexedStack(
        index: _selectedIndex, // Usar IndexedStack para mostrar la página seleccionada
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bluetooth), label: 'Bluetooth'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Control LED'),
          BottomNavigationBarItem(icon: Icon(Icons.pages), label: 'Página en Blanco'),
        ],
        currentIndex: _selectedIndex, // Mantener el índice seleccionado
        onTap: _onItemTapped, // Manejar el toque en la barra de navegación
      ),
    );
  }
}
