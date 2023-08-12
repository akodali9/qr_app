import 'package:flutter/material.dart';
import 'package:qr_app/screens/qr_generator.dart';
import 'package:qr_app/screens/qr_scanner.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static List screens = const [
    QRScanner(),
    QRGenerator(),
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MainScreen.screens[index],
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          elevation: 1,
          onDestinationSelected: (int i) {
            setState(() {
              index = i;
            });
          },
          selectedIndex: index,
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.qr_code_scanner_outlined,
                ),
                selectedIcon: Icon(
                  Icons.qr_code_scanner_rounded,
                ),
                label: "QR Scanner"),
            NavigationDestination(
              icon: Icon(Icons.qr_code_2_outlined),
              selectedIcon: Icon(Icons.qr_code_2_rounded),
              label: "QR Generator",
            ),
          ],
        ));
  }
}
