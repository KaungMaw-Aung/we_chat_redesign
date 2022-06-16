import 'dart:io';

import 'package:flutter/material.dart';

class ConversationBloc extends ChangeNotifier {

  /// State Variables
  bool isChatFeaturesShown = false;
  bool isDisposed = false;
  File? chosenMedia;

  /// Data
  String typedMessage = "";

  void onTypingMessage(String message) {
    typedMessage = message;
  }

  void onTapChatFeaturesToggle() {
    isChatFeaturesShown = !isChatFeaturesShown;
    safelyNotifyListeners();
  }

  void onChooseMedia(File chosenFile) {
    chosenMedia = chosenFile;
    safelyNotifyListeners();
  }

  void removeMedia() {
    chosenMedia = null;
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