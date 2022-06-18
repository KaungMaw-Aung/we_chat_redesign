import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat_redesign/data/vos/message_vo.dart';
import 'package:we_chat_redesign/network/contacts_and_messages_data_agent.dart';

const contactsAndMessagesPath = "contactsAndMessages";

class RealtimeDatabaseDataAgentImpl extends ContactsAndMessagesDataAgent {
  static final RealtimeDatabaseDataAgentImpl _singleton =
      RealtimeDatabaseDataAgentImpl._internal();

  factory RealtimeDatabaseDataAgentImpl() => _singleton;

  RealtimeDatabaseDataAgentImpl._internal();

  /// Realtime Database
  var databaseRef = FirebaseDatabase.instance.ref();

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
        .set(message.toJson()).then((_) {
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
}
