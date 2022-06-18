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

  /// Storage
  var firebaseStorage = FirebaseStorage.instance;

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
}
