import 'package:we_chat_redesign/data/vos/moment_vo.dart';

abstract class WeChatDataAgent {

  /// Moment
  Stream<List<MomentVO>> getMoments();

}