import '../vos/moment_vo.dart';

abstract class WeChatModel {

  Stream<List<MomentVO>> getMoments();

}