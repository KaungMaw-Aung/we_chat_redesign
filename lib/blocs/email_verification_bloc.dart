import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:we_chat_redesign/data/models/authentication_model_impl.dart';
import 'package:we_chat_redesign/data/vos/user_vo.dart';

import '../data/models/authentication_model.dart';

class EmailVerificationBloc extends ChangeNotifier {
  /// State Variables
  bool isDisposed = false;
  bool isOkButtonEnable = false;
  bool isLoading = false;

  /// Page Data
  String email = "";

  /// Models
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();

  void onChangeEmail(String email) {
    this.email = email;
    isOkButtonEnable = this.email.isNotEmpty;
    safelyNotifyListeners();
  }

  Future<void> onTapConfirmButton(UserVO newUser, File? profileImageFile) {
    isLoading = true;
    safelyNotifyListeners();
    newUser.email = email;
    return _authenticationModel
        .registerNewUser(newUser, profileImageFile)
        .whenComplete(() {
      isLoading = false;
      safelyNotifyListeners();
    });
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
