import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:we_chat_redesign/data/vos/moment_vo.dart';
import 'package:we_chat_redesign/network/we_chat_data_agent.dart';

const momentsCollection = "moments";

class CloudFirestoreDataAgentImpl extends WeChatDataAgent {
  static final CloudFirestoreDataAgentImpl _singleton =
      CloudFirestoreDataAgentImpl._internal();

  factory CloudFirestoreDataAgentImpl() => _singleton;

  CloudFirestoreDataAgentImpl._internal();

  /// FireStore
  final FirebaseFirestore _cloudFirestore = FirebaseFirestore.instance;

  @override
  Stream<List<MomentVO>> getMoments() {
    return _cloudFirestore.collection(momentsCollection).snapshots().map(
        (event) => event.docs
            .map((document) => MomentVO.fromJson(document.data()))
            .toList());
  }
}
