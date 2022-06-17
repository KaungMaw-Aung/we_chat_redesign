import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:we_chat_redesign/data/vos/user_vo.dart';

class EmailVerificationBloc extends ChangeNotifier {

  /// State Variables
  bool isDisposed = false;
  bool isOkButtonEnable = false;

  /// Page Data
  String email = "";

  void onChangeEmail(String email) {
    this.email = email;
    isOkButtonEnable = this.email.isNotEmpty;
    safelyNotifyListeners();
  }

  void onTapConfirmButton(UserVO newUser, File? profileImageFile) {
    newUser.email = email;
    print("New user ===> ${newUser.toString()}");
    print("Profile image file ===> ${profileImageFile?.path}");
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