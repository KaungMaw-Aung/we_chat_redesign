import 'package:flutter/foundation.dart';
import 'package:we_chat_redesign/data/models/authentication_model_impl.dart';

import '../data/models/authentication_model.dart';

class LoginBloc extends ChangeNotifier {

  /// State Variables
  bool isDisposed = false;
  bool isLoginButtonEnable = false;
  bool isLoading = false;

  /// Page Data
  String email = "";
  String password = "";

  /// Models
  final AuthenticationModel _authModel = AuthenticationModelImpl();

  void onEmailTextChange(String text) {
    email = text;
    isLoginButtonEnable = (email.isNotEmpty && password.isNotEmpty);
    safelyNotifyListeners();
  }

  void onPasswordTextChange(String text) {
    password = text;
    isLoginButtonEnable = (email.isNotEmpty && password.isNotEmpty);
    safelyNotifyListeners();
  }

  Future<void> onTapLogin() {
    isLoading = true;
    safelyNotifyListeners();
    return _authModel.login(email, password).whenComplete(() {
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