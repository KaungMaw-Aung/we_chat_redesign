import 'dart:io';

import 'package:we_chat_redesign/data/vos/message_vo.dart';
import 'package:we_chat_redesign/data/vos/user_vo.dart';

import '../vos/chat_history_vo.dart';
import '../vos/moment_vo.dart';

abstract class WeChatModel {
  /// Moment
  Stream<List<MomentVO>> getMoments();

  Future<void> addNewMoment(String description, File? chosenMedia,
      String username, String profileUrl);

  Future<void> deleteMoment(String momentId);

  Stream<MomentVO> getMomentById(String momentId);

  Future<void> editMoment(MomentVO? moment, File? chosenMedia);

  /// User
  Stream<UserVO> getProfileData();

  Future<String> addNewToCurrentUserContacts(String newContactUid);

  Future<void> addCurrentUserToScannedUserContacts(
      String otherUserId, UserVO currentUser);

  Stream<List<UserVO>> getContacts();

  /// Messaging
  Future<void> sendMessage(
    String senderId,
    String receiverId,
    File? media,
    String message,
  );

  Stream<List<MessageVO>> getMessages(String senderId, String receiverId);

  Stream<List<Future<ChatHistoryVO>>> getChatHistories(String senderId);

  Future<void> deleteConversation(String senderId, String receiverId);
}
