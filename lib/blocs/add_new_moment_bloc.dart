import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:we_chat_redesign/data/models/we_chat_model_impl.dart';

import '../data/models/we_chat_model.dart';

class AddNewMomentBloc extends ChangeNotifier {
  /// State Variables
  bool isLoading = false;
  bool isDisposed = false;
  bool isPostButtonEnable = false;

  /// App Data
  String momentDescription = "";
  File? chosenMedia;

  /// Models
  final WeChatModel _model = WeChatModelImpl();

  Future<void> onTapPostButton() {
    isLoading = true;
    safelyNotifyListeners();
    return addNewMoment().whenComplete(() {
      isLoading = false;
      safelyNotifyListeners();
    });
  }

  Future<void> addNewMoment() {
    return _model.addNewMoment(momentDescription, chosenMedia);
  }

  void onDescriptionChanged(String text) {
    momentDescription = text;
    isPostButtonEnable = momentDescription.isNotEmpty || chosenMedia != null;
    safelyNotifyListeners();
  }

  void onChooseMedia(File chosenMedia) {
    this.chosenMedia = chosenMedia;
    isPostButtonEnable = true;
    safelyNotifyListeners();
  }

  void onDeleteMedia() {
    chosenMedia = null;
    isPostButtonEnable = momentDescription.isNotEmpty;
    safelyNotifyListeners();
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
