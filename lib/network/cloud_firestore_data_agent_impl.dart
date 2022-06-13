import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat_redesign/data/vos/moment_vo.dart';
import 'package:we_chat_redesign/network/we_chat_data_agent.dart';
import 'package:we_chat_redesign/viewitems/post_item_view.dart';

const momentsCollection = "moments";
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
}
