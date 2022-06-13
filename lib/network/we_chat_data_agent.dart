import 'dart:io';

import 'package:we_chat_redesign/data/vos/moment_vo.dart';

abstract class WeChatDataAgent {

  /// Moment
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewMoment(MomentVO moment);
  Future<void> deleteMoment(String momentId);

  /// Storage
  Future<String> uploadFileToStorage(File chosenMedia);

}