import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  static String _scanBarcoderes = "";
  Future<void> scanBarcodeNormal() async {
    String barcodeScanresult;
    try {
      barcodeScanresult = FlutterBarcodeScanner.scanBarcode(
        '#ff666',
        "Cancel",
        true,
        ScanMode.DEFAULT,
      ) as String;
    } on PlatformException {
      barcodeScanresult = "Failed to get Platform version";
    }
    if (!mounted) return;
    setState(() {
      _scanBarcoderes = barcodeScanresult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
          alignment: Alignment.center,
          child: Flex(
            direction: Axis.vertical,
            children: [
              ElevatedButton(
                onPressed: scanBarcodeNormal,
                child: const Text("Scan Barcode"),
              ),
              // Text(_scanBarcoderes),
            ],
          ),
        ),
      ),
    );
  }
}
