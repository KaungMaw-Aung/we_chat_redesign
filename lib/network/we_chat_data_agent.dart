import 'dart:io';

import 'package:we_chat_redesign/data/vos/moment_vo.dart';
import 'package:we_chat_redesign/data/vos/user_vo.dart';

abstract class WeChatDataAgent {

  /// Moment
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewMoment(MomentVO moment);
  Future<void> deleteMoment(String momentId);
  Stream<MomentVO> getMomentById(String momentId);

  /// User
  Stream<UserVO> getUserById(String uid);
  Future<void> addContact(String ownerId, UserVO newContact);
  Stream<List<UserVO>> getContacts();

  /// Storage
  Future<String> uploadFileToStorage(File chosenMedia);

  /// Auth
  Future<void> registerNewUser(UserVO newUser, File? profileImageFile);
  Future<void> login(String email, String password);
  bool isLoggedIn();
  Stream<UserVO> getLoggedInUser();
  Future<void> logout();
  String getCurrentUserId();
}