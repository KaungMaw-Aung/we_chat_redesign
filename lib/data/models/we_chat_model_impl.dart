import 'package:we_chat_redesign/data/models/we_chat_model.dart';
import 'package:we_chat_redesign/data/vos/moment_vo.dart';
import 'package:we_chat_redesign/network/cloud_firestore_data_agent_impl.dart';

import '../../network/we_chat_data_agent.dart';

class WeChatModelImpl extends WeChatModel {

  /// DataAgent
  final WeChatDataAgent _dataAgent = CloudFirestoreDataAgentImpl();

  @override
  Stream<List<MomentVO>> getMoments() {
    return _dataAgent.getMoments();
  }

}