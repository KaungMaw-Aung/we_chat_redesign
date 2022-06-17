import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:we_chat_redesign/data/vos/user_vo.dart';

class GetUserDataBloc extends ChangeNotifier {

  /// State Variables
  File? chosenImage;
  bool isDisposed = false;
  bool areTermsAccepted = false;

  /// Page Data
  String fullName = "";
  String phone = "";
  String password = "";

  void onChooseImage(File image) {
    chosenImage = image;
    safelyNotifyListeners();
  }

  void onDeleteImage() {
    chosenImage = null;
    safelyNotifyListeners();
  }

  void onFullNameTextChanged(String name) {
    fullName = name;
  }

  void onPhoneTextChanged(String number) {
    phone = "+95$number";
  }

  void onPasswordTextChanged(String password) {
    this.password = password;
  }

  void onTapCheckBox(bool isChecked) {
    areTermsAccepted = isChecked;
    safelyNotifyListeners();
  }

  Future<List<dynamic>> craftUserVO() {
    return Future.value(
      [
        UserVO(
          name: fullName,
          phoneNumber: phone,
          password: password,
        ),
        chosenImage
      ]
    );
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void safelyNotifyListeners() {
    if (isDisposed == false) {
      notifyListeners();
    }
  }
}