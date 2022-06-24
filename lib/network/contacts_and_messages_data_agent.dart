import 'package:we_chat_redesign/data/vos/chat_history_vo.dart';
import 'package:we_chat_redesign/data/vos/message_vo.dart';

abstract class ContactsAndMessagesDataAgent {

  Future<void> addMessageToContacts(String senderId, String receiverId, MessageVO message);

  Stream<List<MessageVO>> getMessages(String senderId, String receiverId);

  Stream<List<Future<ChatHistoryVO>>> getChatHistories(String senderId);

  Future<void> deleteConversation(String senderId, String receiverId);

}