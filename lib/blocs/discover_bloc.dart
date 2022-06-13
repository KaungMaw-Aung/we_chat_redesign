import 'package:flutter/material.dart';

import '../data/models/we_chat_model.dart';
import '../data/models/we_chat_model_impl.dart';
import '../data/vos/moment_vo.dart';

class DiscoverBloc extends ChangeNotifier {
  /// State Variables
  List<MomentVO>? moments;
  bool isDisposed = false;

  /// Models
  final WeChatModel _model = WeChatModelImpl();

  DiscoverBloc() {

    /// Get Moments
    _model.getMoments().listen((moments) {
      this.moments = moments;
      safelyNotifyListeners();
    }).onError((error) => debugPrint(error.toString()));

  }

  void deleteMoment(String momentId) {
    _model.deleteMoment(momentId);
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
