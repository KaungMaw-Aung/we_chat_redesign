import 'dart:io';

import 'package:we_chat_redesign/data/vos/user_vo.dart';

import '../vos/moment_vo.dart';

abstract class WeChatModel {

  /// Moment
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewMoment(String description, File? chosenMedia);
  Future<void> deleteMoment(String momentId);
  Stream<MomentVO> getMomentById(String momentId);
  Future<void> editMoment(MomentVO? moment, File? chosenMedia);

  /// User
  Future<String> addNewToCurrentUserContacts(String newContactUid);
  Future<void> addCurrentUserToScannedUserContacts(String otherUserId, UserVO currentUser);
  Stream<List<UserVO>> getContacts();

}