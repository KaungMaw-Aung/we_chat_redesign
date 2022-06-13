import 'dart:io';

import '../vos/moment_vo.dart';

abstract class WeChatModel {

  Stream<List<MomentVO>> getMoments();
  Future<void> addNewMoment(String description, File? chosenMedia);
  Future<void> deleteMoment(String momentId);

}