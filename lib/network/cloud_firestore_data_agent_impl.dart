import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat_redesign/data/vos/moment_vo.dart';
import 'package:we_chat_redesign/data/vos/user_vo.dart';
import 'package:we_chat_redesign/fcm/fcm_service.dart';
import 'package:we_chat_redesign/network/we_chat_data_agent.dart';
import 'package:we_chat_redesign/viewitems/post_item_view.dart';

const momentsCollection = "moments";
const usersCollection = "users";
const fileUploadRef = "uploads";

class CloudFirestoreDataAgentImpl extends WeChatDataAgent {
  static final CloudFirestoreDataAgentImpl _singleton =
      CloudFirestoreDataAgentImpl._internal();

  factory CloudFirestoreDataAgentImpl() => _singleton;

  CloudFirestoreDataAgentImpl._internal();

  /// FireStore
  final FirebaseFirestore _cloudFirestore = FirebaseFirestore.instance;

  /// Firebase Storage
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  /// Auth
  var auth = FirebaseAuth.instance;

  /// FCM
  var fcmService = FCMService();

  @override
  Stream<List<MomentVO>> getMoments() {
    return _cloudFirestore.collection(momentsCollection).snapshots().map(
        (event) => event.docs
            .map((document) => MomentVO.fromJson(document.data()))
            .toList());
  }

  @override
  Future<void> addNewMoment(MomentVO moment) {
    return _cloudFirestore
        .collection(momentsCollection)
        .doc(moment.id ?? "-1")
        .set(moment.toJson());
  }

  @override
  Future<void> deleteMoment(String momentId) {
    return _cloudFirestore.collection(momentsCollection).doc(momentId).delete();
  }

  @override
  Future<String> uploadFileToStorage(File chosenMedia) {
    return _firebaseStorage
        .ref(fileUploadRef)
        .child(DateTime.now().millisecondsSinceEpoch.toString() +
            getFileExtension(chosenMedia.path))
        .putFile(chosenMedia)
        .then((snapshot) => snapshot.ref.getDownloadURL());
  }

  String getFileExtension(String url) {
    return getUrlType(url) == UrlType.OTHER ? ".jpg" : ".mp4";
  }

  @override
  Stream<MomentVO> getMomentById(String momentId) {
    return _cloudFirestore
        .collection(momentsCollection)
        .doc(momentId)
        .get()
        .asStream()
        .where((event) => event.data() != null)
        .map((event) => MomentVO.fromJson(event.data()!));
  }

  @override
  Stream<UserVO> getUserById(String uid) {
    return _cloudFirestore
        .collection(usersCollection)
        .doc(uid)
        .get()
        .asStream()
        .where((event) => event.data() != null)
        .map((event) => UserVO.fromJson(event.data()!));
  }

  @override
  Future<void> registerNewUser(UserVO newUser, File? profileImageFile) {
    return auth
        .createUserWithEmailAndPassword(
            email: newUser.email ?? "", password: newUser.password ?? "")
        .then((credential) =>
            credential.user?..updateDisplayName(newUser.name ?? ""))
        .then((user) async {
      newUser.id = user?.uid;
      newUser.qrCode = user?.uid;
      newUser.fcmToken = await fcmService.getFCMTokenForDevice();
      if (profileImageFile != null) {
        newUser.profilePicture = await uploadFileToStorage(profileImageFile);
      }
      _addNewUser(newUser);
    });
  }

  Future<void> _addNewUser(UserVO newUser) {
    return _cloudFirestore
        .collection(usersCollection)
        .doc(newUser.id ?? "-1")
        .set(newUser.toJson());
  }

  @override
  Future<void> login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  Stream<UserVO> getLoggedInUser() {
    return getUserById(auth.currentUser?.uid ?? "-1");
  }

  @override
  Future<void> logout() {
    return auth.signOut();
  }


}
