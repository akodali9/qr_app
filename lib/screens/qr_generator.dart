import 'package:flutter/material.dart';
import 'package:qr_app/components/qr_image.dart';

class QRGenerator extends StatefulWidget {
  const QRGenerator({super.key});

  @override
  State<QRGenerator> createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  TextEditingController qrtextcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: TextField(
                controller: qrtextcontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter your link or text",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (qrtextcontroller.text != "") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return QRImageComp(
                            textEditingController: qrtextcontroller);
                      },
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("Enter link or text"),
                    ),
                  );
                }
              },
              style: const ButtonStyle(
                enableFeedback: true,
                splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Generate QR Code",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
