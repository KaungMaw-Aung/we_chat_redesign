import 'package:flutter/foundation.dart';

import '../data/models/authentication_model.dart';
import '../data/models/authentication_model_impl.dart';

class ProfileBloc extends ChangeNotifier {

  /// State Variables
  String? name;
  String? profileUrl;
  String? qrCode;
  bool isDisposed = false;

  /// Models
  final AuthenticationModel _authModel = AuthenticationModelImpl();

  ProfileBloc() {

    /// Get User Data
    _authModel.getLoggedInUser().listen((user) {
      name = user.name;
      profileUrl = user.profilePicture;
      qrCode = user.qrCode;
      safelyNotifyListener();
    }).onError((error) {
      debugPrint(error.toString());
    });

  }

  Future<void> logout() {
    return _authModel.logout();
  }

  void safelyNotifyListener() {
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