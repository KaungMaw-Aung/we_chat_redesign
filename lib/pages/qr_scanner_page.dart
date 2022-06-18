import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:we_chat_redesign/blocs/qr_scanner_bloc.dart';
import 'package:we_chat_redesign/data/vos/user_vo.dart';
import 'package:we_chat_redesign/pages/contacts_page.dart';
import 'package:we_chat_redesign/pages/host_page.dart';

class QRScannerPage extends StatefulWidget {
  final UserVO userVO;

  QRScannerPage({required this.userVO});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<QRScannerBloc>(
        create: (context) => QRScannerBloc(currentUser: widget.userVO),
        child: Column(
          children: [
            Expanded(
              child: Builder(builder: (context) {
                return QRView(
                  key: qrKey,
                  onQRViewCreated: (qrController) {
                    controller = qrController;
                    qrController.scannedDataStream.listen((scanData) {
                      QRScannerBloc bloc = Provider.of(context, listen: false);
                      bloc.onScannedQRCode(scanData).then((_) {
                        _navigateToContactsScreen(context);
                        controller!.stopCamera();
                      });
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToContactsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HostPage(selectedIndex: 1),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
