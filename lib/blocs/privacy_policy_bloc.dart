import 'package:flutter/foundation.dart';

class PrivacyPolicyBloc extends ChangeNotifier {

  /// State Variables
  bool areTermsAccepted = false;
  bool isDisposed = false;

  void onTapCheckBox(bool isChecked) {
    areTermsAccepted = isChecked;
    safelyNotifyListeners();
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