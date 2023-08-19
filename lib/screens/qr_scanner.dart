import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  static String _scancoderes = "";
  TextEditingController rescontroller = TextEditingController();
  Future<void> scanBarcodeNormal() async {
    String barcodeScanresult;
    try {
      barcodeScanresult = await FlutterBarcodeScanner.scanBarcode(
        '#ff3300',
        "Cancel",
        true,
        ScanMode.DEFAULT,
      );
    } on PlatformException {
      barcodeScanresult = "Failed to get Platform version";
    }
    if (!mounted) return;
    setState(() {
      _scancoderes = barcodeScanresult;
      rescontroller.text = _scancoderes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                child: TextFormField(
                  readOnly: true,
                  controller: rescontroller,
                  decoration: InputDecoration(
                    suffixIcon: rescontroller.text != ""
                        ? IconButton(
                            onPressed: () async {
                              await Clipboard.setData(
                                      ClipboardData(text: _scancoderes))
                                  .then((res) {
                                const copysnackbar = SnackBar(
                                    content: Text('Copied to clipboard'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(copysnackbar);
                              });
                            },
                            icon: const Icon(Icons.copy))
                        : const SizedBox(),
                    border: const OutlineInputBorder(),
                    label: const Text("Scan result"),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => scanBarcodeNormal(),
                child: const Text(
                  "Scan Barcode / Qr",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
