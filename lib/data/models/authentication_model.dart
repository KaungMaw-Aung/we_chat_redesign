import 'dart:io';

import 'package:we_chat_redesign/data/vos/user_vo.dart';

abstract class AuthenticationModel {

  Future<void> registerNewUser(UserVO newUser, File? profileImageFile);
  Future<void> login(String email, String password);
  bool isLoggedIn();
  Stream<UserVO> getLoggedInUser();
  Future<void> logout();

}