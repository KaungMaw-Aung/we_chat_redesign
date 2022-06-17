import 'dart:io';

import 'package:flutter/material.dart';

import '../data/vos/user_vo.dart';

class PrivacyPolicyPage extends StatelessWidget {
  final UserVO newUser;
  final File? profileImageFile;

  PrivacyPolicyPage({
    required this.newUser,
    required this.profileImageFile,
  });

  @override
  Widget build(BuildContext context) {
    print("user ==> " + newUser.toString());
    print("image file ==> ${profileImageFile?.path ?? ""}");
    return Container(
      color: Colors.blue,
    );
  }
}
