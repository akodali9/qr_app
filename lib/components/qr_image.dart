import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImageComp extends StatelessWidget {
  const QRImageComp({super.key, required this.linktext});

  final String linktext;

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: linktext,
      backgroundColor: Colors.white,
      size: 250,
    );
  }
}
