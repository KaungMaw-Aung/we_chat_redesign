import 'package:flutter/material.dart';
import 'package:we_chat_redesign/data/vos/user_vo.dart';

import '../data/models/we_chat_model.dart';
import '../data/models/we_chat_model_impl.dart';
import '../data/vos/moment_vo.dart';

class DiscoverBloc extends ChangeNotifier {
  /// State Variables
  List<MomentVO>? moments;
  bool isDisposed = false;
  UserVO? profileData;
  bool isCommandTextBoxOverlayShowing = true;

  /// Models
  final WeChatModel _model = WeChatModelImpl();

  DiscoverBloc() {

    /// Get User Profile
    _model.getProfileData().listen((profile) {
      print("profile ==> ${profile.toString()}");
      profileData = profile;
      safelyNotifyListeners();
    }).onError((error) => debugPrint(error.toString()));

    /// Get Moments
    _model.getMoments().listen((moments) {
      this.moments = moments;
      safelyNotifyListeners();
    }).onError((error) => debugPrint(error.toString()));

  }

  void deleteMoment(String momentId) {
    _model.deleteMoment(momentId);
  }

  void showCommandTextBoxOverlay() {
    isCommandTextBoxOverlayShowing = true;
    safelyNotifyListeners();
  }

  void hideCommandTextBoxOverlay() {
    isCommandTextBoxOverlayShowing = false;
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
