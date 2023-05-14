import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanner extends StatefulWidget {
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController qrViewController) {
    setState(() {
      controller = qrViewController;
    });
    controller.scannedDataStream.listen((scanData) {
      // Extract the address from the QR code data
      String? address = scanData.code;
      // Pass the address back to the calling widget

      Navigator.pop(context, address);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
