import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:we_chat_redesign/pages/qr_scanner_page.dart';
import 'package:we_chat_redesign/resources/colors.dart';
import 'package:we_chat_redesign/resources/dimens.dart';
import 'package:we_chat_redesign/utils/extensions.dart';

import '../resources/strings.dart';

class QRCodeAndScannerPage extends StatelessWidget {
  final String qrCode;

  QRCodeAndScannerPage({required this.qrCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white70,
          size: MARGIN_LARGE,
        ),
        title: const Text(
          QR_CODE,
          style: TextStyle(
            color: Colors.white70
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          navigateToScreen(context, const QRScannerPage());
        },
        child: const Icon(
          Icons.qr_code_scanner,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: QrImage(
          data: qrCode,
          version: QrVersions.auto,
          size: 300.0,
        ),
      ),
    );
  }
}
