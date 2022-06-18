import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../data/models/we_chat_model.dart';
import '../data/models/we_chat_model_impl.dart';
import '../data/vos/user_vo.dart';

class QRScannerBloc extends ChangeNotifier {
  /// State Variables
  bool isDisposed = false;
  Barcode? barcode;
  UserVO currentUser;

  QRScannerBloc({required this.currentUser});

  /// Models
  final WeChatModel _model = WeChatModelImpl();

  Future<void> onScannedQRCode(Barcode result) {
    barcode = result;
    if (barcode?.code?.isNotEmpty == true) {
      return _model
          .addNewToCurrentUserContacts(barcode!.code!)
          .then((otherUserId) => _model.addCurrentUserToScannedUserContacts(
                otherUserId,
                currentUser,
              ));
    } else {
      return Future.error("Error");
    }
  }

  void safelyNotifyListeners() {
    if (isDisposed == false) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
