import 'dart:io';

import 'package:we_chat_redesign/data/vos/user_vo.dart';
import 'package:we_chat_redesign/network/cloud_firestore_data_agent_impl.dart';

import '../../network/we_chat_data_agent.dart';
import 'authentication_model.dart';

class AuthenticationModelImpl extends AuthenticationModel {
  static final AuthenticationModelImpl _singleton =
      AuthenticationModelImpl._internal();

  factory AuthenticationModelImpl() => _singleton;

  AuthenticationModelImpl._internal();

  /// Data Agents
  final WeChatDataAgent _dataAgent = CloudFirestoreDataAgentImpl();

  @override
  Future<void> registerNewUser(UserVO newUser, File? profileImageFile) {
    return _dataAgent.registerNewUser(newUser, profileImageFile);
  }

  @override
  Future<void> login(String email, String password) {
      return _dataAgent.login(email, password);
  }

  @override
  bool isLoggedIn() {
    return _dataAgent.isLoggedIn();
  }

  @override
  Stream<UserVO> getLoggedInUser() {
    return _dataAgent.getLoggedInUser();
  }

  @override
  Future<void> logout() {
    return _dataAgent.logout();
  }

}
