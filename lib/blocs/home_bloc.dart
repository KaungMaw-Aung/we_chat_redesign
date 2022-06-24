import 'package:flutter/foundation.dart';
import 'package:we_chat_redesign/data/models/authentication_model.dart';
import 'package:we_chat_redesign/data/vos/chat_history_vo.dart';

import '../data/models/authentication_model_impl.dart';
import '../data/models/we_chat_model.dart';
import '../data/models/we_chat_model_impl.dart';

class HomeBloc extends ChangeNotifier {

  /// State Variables
  bool isDisposed = false;
  List<ChatHistoryVO>? temp = [];
  List<ChatHistoryVO>? chatHistories;

  /// Models
  final WeChatModel _chatModel = WeChatModelImpl();
  final AuthenticationModel _authModel = AuthenticationModelImpl();

  HomeBloc() {

    /// Get Chat Histories
    _chatModel.getChatHistories(_authModel.getCurrentUserId()).listen((values) {
      temp?.clear();
      chatHistories?.clear();
      if (values.isEmpty) {
        temp?.clear();
        chatHistories = temp;
        safelyNotifyListeners();
      } else {
        values.forEach((value) {
          value.then((chatHistory) {
            temp?.add(chatHistory);
            chatHistories = temp;
            safelyNotifyListeners();
          });
        });
      }
    });

  }

  String getCurrentUid() {
    return _authModel.getCurrentUserId();
  }

  Future<void> deleteConversations(String receiverId) {
    return _chatModel.deleteConversation(getCurrentUid(), receiverId);
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