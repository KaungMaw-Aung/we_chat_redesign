import 'dart:io';

import 'package:we_chat_redesign/data/models/we_chat_model.dart';
import 'package:we_chat_redesign/data/vos/message_vo.dart';
import 'package:we_chat_redesign/data/vos/moment_vo.dart';
import 'package:we_chat_redesign/data/vos/user_vo.dart';
import 'package:we_chat_redesign/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_redesign/network/contacts_and_messages_data_agent.dart';
import 'package:we_chat_redesign/network/realtime_database_data_agent_impl.dart';

import '../../network/we_chat_data_agent.dart';

class WeChatModelImpl extends WeChatModel {
  static final WeChatModelImpl _singleton = WeChatModelImpl._internal();

  factory WeChatModelImpl() => _singleton;

  WeChatModelImpl._internal();

  /// DataAgents
  final WeChatDataAgent _dataAgent = CloudFirestoreDataAgentImpl();
  final ContactsAndMessagesDataAgent _messageDataAgent =
      RealtimeDatabaseDataAgentImpl();

  @override
  Stream<List<MomentVO>> getMoments() {
    return _dataAgent.getMoments();
  }

  @override
  Future<void> addNewMoment(String description, File? chosenMedia,
      String username, String profileUrl) {
    if (chosenMedia != null) {
      return _dataAgent
          .uploadFileToStorage(chosenMedia)
          .then((downloadUrl) =>
              craftNewMoment(description, downloadUrl, username, profileUrl))
          .then((value) => _dataAgent.addNewMoment(value));
    } else {
      return craftNewMoment(description, "", username, profileUrl)
          .then((moment) => _dataAgent.addNewMoment(moment));
    }
  }

  Future<MomentVO> craftNewMoment(String description, String chosenMediaUrl,
      String username, String profileUrl) {
    return Future.value(
      MomentVO(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        description: description,
        profilePicture: profileUrl,
        username: username,
        postMedia: chosenMediaUrl,
      ),
    );
  }

  @override
  Future<void> deleteMoment(String momentId) {
    return _dataAgent.deleteMoment(momentId);
  }

  @override
  Stream<MomentVO> getMomentById(String momentId) {
    return _dataAgent.getMomentById(momentId);
  }

  @override
  Future<void> editMoment(MomentVO? moment, File? chosenMedia) {
    if (chosenMedia != null) {
      return _dataAgent.uploadFileToStorage(chosenMedia).then((downloadUrl) {
        moment?.postMedia = downloadUrl;
        return moment;
      }).then((value) {
        if (value != null) {
          _dataAgent.addNewMoment(value);
        } else {
          return Future.error("Error");
        }
      });
    } else {
      if (moment != null) {
        return _dataAgent.addNewMoment(moment);
      } else {
        return Future.error("Error");
      }
    }
  }

  @override
  Future<String> addNewToCurrentUserContacts(String newContactUid) async {
    var newContact = await _dataAgent.getUserById(newContactUid).first;
    return _dataAgent
        .addContact(_dataAgent.getCurrentUserId(), newContact)
        .then((value) => newContact.id ?? "");
  }

  @override
  Future<void> addCurrentUserToScannedUserContacts(
      String otherUserId, UserVO currentUser) {
    return _dataAgent.addContact(otherUserId, currentUser);
  }

  @override
  Stream<List<UserVO>> getContacts() {
    return _dataAgent.getContacts();
  }

  @override
  Stream<UserVO> getProfileData() {
    return _dataAgent.getUserById(_dataAgent.getCurrentUserId());
  }

  @override
  Future<void> sendMessage(
    String senderId,
    String receiverId,
    File? media,
    String message,
  ) {
    return craftMessageVO(senderId, message, media).then((newMessage) {
      return _messageDataAgent.addMessageToContacts(
        senderId,
        receiverId,
        newMessage,
      );
    });
  }

  Future<MessageVO> craftMessageVO(
    String userId,
    String message,
    File? media,
  ) async {
    var newMessage = MessageVO(
        userId, "", message, "", "", DateTime.now().millisecondsSinceEpoch
    );
    var currentUser = await getProfileData().first;
    newMessage.username = currentUser.name ?? "";
    newMessage.profileUrl = currentUser.profilePicture ?? "";
    if (media != null) {
      newMessage.mediaUrl = await _dataAgent.uploadFileToStorage(media);
    }
    return Future.value(newMessage);
  }
}
