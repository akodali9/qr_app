import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_app/components/qr_image.dart';
import 'package:screenshot/screenshot.dart';

class QRGenerator extends StatefulWidget {
  const QRGenerator({super.key});

  @override
  State<QRGenerator> createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  TextEditingController qrtextcontroller = TextEditingController();
  ScreenshotController qrscreenshot = ScreenshotController();
  static String urltext = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              if (qrtextcontroller.text != "")
                Screenshot(
                  controller: qrscreenshot,
                  child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          QRImageComp(linktext: urltext),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              urltext,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )),
                ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: qrtextcontroller,
                  onChanged: (val) {
                    setState(() {
                      urltext = val;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter your link or text",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        qrtextcontroller.clear();
                      });
                    },
                    child: const Text(
                      "Clear",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (qrtextcontroller.text != "") {
                        await [Permission.storage].request();
                        final image = await qrscreenshot.capture();
                        if (image == null) return;
                        final time = DateTime.now()
                            .toIso8601String()
                            .replaceAll('.', '-')
                            .replaceAll(":", "-");
                        final name = '$urltext-$time';
                        await ImageGallerySaver.saveImage(image, name: name);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text("Saved to device"),
                            ),
                          );
                        }
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
                      splashFactory:
                          InkSparkle.constantTurbulenceSeedSplashFactory,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        "Download QR",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
