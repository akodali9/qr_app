import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImageComp extends StatelessWidget {
  const QRImageComp({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(textEditingController.text),
        centerTitle: true,
      ),
      body: Center(
        child: QrImageView(
          data: textEditingController.text,
          backgroundColor: Colors.white,
          size: 250,
        ),
      ),
    );
  }
}
