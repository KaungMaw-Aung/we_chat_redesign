import 'package:firebase_database/firebase_database.dart';
import 'package:we_chat_redesign/data/vos/message_vo.dart';
import 'package:we_chat_redesign/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_redesign/network/contacts_and_messages_data_agent.dart';

import '../data/vos/chat_history_vo.dart';

const contactsAndMessagesPath = "contactsAndMessages";

class RealtimeDatabaseDataAgentImpl extends ContactsAndMessagesDataAgent {
  static final RealtimeDatabaseDataAgentImpl _singleton =
      RealtimeDatabaseDataAgentImpl._internal();

  factory RealtimeDatabaseDataAgentImpl() => _singleton;

  RealtimeDatabaseDataAgentImpl._internal();

  /// Realtime Database
  var databaseRef = FirebaseDatabase.instance.ref();

  /// FireStore
  final _cloudFireStoreDataAgentImpl = CloudFirestoreDataAgentImpl();

  @override
  Future<void> addMessageToContacts(
    String senderId,
    String receiverId,
    MessageVO message,
  ) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(senderId)
        .child(receiverId)
        .child(message.sentAt?.toString() ?? "")
        .set(message.toJson())
        .then((_) {
      databaseRef
          .child(contactsAndMessagesPath)
          .child(receiverId)
          .child(senderId)
          .child(message.sentAt?.toString() ?? "")
          .set(message.toJson());
    });
  }

  @override
  Stream<List<MessageVO>> getMessages(String senderId, String receiverId) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(senderId)
        .child(receiverId)
        .onValue
        .map((event) {
      return event.snapshot.children.map<MessageVO>((element) {
        return MessageVO.fromJson(
            Map<String, dynamic>.from(element.value as Map));
      }).toList();
    });
  }

  @override
  Stream<List<Future<ChatHistoryVO>>> getChatHistories(String senderId) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(senderId)
        .onValue
        .map((event) {
      return event.snapshot.children.map<Future<ChatHistoryVO>>((element) {
        return craftChatHistoryVO(element);
      }).toList();
    });
  }

  Future<ChatHistoryVO> craftChatHistoryVO(DataSnapshot snapshot) async {
    var user = await _cloudFireStoreDataAgentImpl.getUserById(snapshot.key.toString()).first;
    var messages = snapshot.children.map<MessageVO>((element) {
      return MessageVO.fromJson(
          Map<String, dynamic>.from(element.value as Map));
    }).toList();
    return ChatHistoryVO(
      user.id,
      user.name,
      user.profilePicture,
      messages.last.message,
    );
  }

  @override
  Future<void> deleteConversation(String senderId, String receiverId) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(senderId)
        .child(receiverId)
        .remove().then((value) {
      databaseRef
          .child(contactsAndMessagesPath)
          .child(receiverId)
          .child(senderId)
          .remove();
    });
  }

}
