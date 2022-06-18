import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_redesign/data/models/authentication_model.dart';
import 'package:we_chat_redesign/pages/email_verification_page.dart';
import 'package:we_chat_redesign/pages/login_or_sign_up_page.dart';
import 'package:we_chat_redesign/pages/privacy_policy_page.dart';

import 'data/models/authentication_model_impl.dart';
import 'pages/host_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _authenticationModel.isLoggedIn()
          ? HostPage()
          : const LoginOrSignUpPage(),
    );
  }
}
