class ChatHistoryVO {

  String? uid;
  String? name;
  String? profileUrl;
  String? lastMessage;

  ChatHistoryVO(this.uid, this.name, this.profileUrl, this.lastMessage);

  @override
  String toString() {
    return 'ChatHistoryVO{uid: $uid, name: $name, profileUrl: $profileUrl, lastMessage: $lastMessage}';
  }

}