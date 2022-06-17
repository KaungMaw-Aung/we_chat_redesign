import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {

  static final FCMService _singleton = FCMService._internal();

  factory FCMService() => _singleton;

  FCMService._internal();

  /// Firebase Messaging Instance
  var messaging = FirebaseMessaging.instance;

  Future<String?> getFCMTokenForDevice() {
    return messaging.getToken();
  }

}