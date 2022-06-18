import 'dart:io';

import 'package:flutter/material.dart';
import 'package:we_chat_redesign/data/models/we_chat_model_impl.dart';

import '../data/models/we_chat_model.dart';

class ConversationBloc extends ChangeNotifier {

  /// State Variables
  bool isChatFeaturesShown = false;
  bool isDisposed = false;
  File? chosenMedia;
  bool isMessageSent = false;

  /// Models
  final WeChatModel _model = WeChatModelImpl();

  void onMessageSent() {
    isMessageSent = true;
    safelyNotifyListeners();
  }

  void _resetMessageSent() {
    isMessageSent = false;
    safelyNotifyListeners();
  }

  void onTypedMessage() {
    _resetMessageSent();
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

  Future<void> onTapSend(String senderId, String receiverId, String message) {
    return _model.sendMessage(senderId, receiverId, chosenMedia, message);
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