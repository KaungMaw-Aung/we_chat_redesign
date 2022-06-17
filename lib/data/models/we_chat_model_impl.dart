import 'dart:io';

import 'package:we_chat_redesign/data/models/we_chat_model.dart';
import 'package:we_chat_redesign/data/vos/moment_vo.dart';
import 'package:we_chat_redesign/network/cloud_firestore_data_agent_impl.dart';

import '../../network/we_chat_data_agent.dart';

class WeChatModelImpl extends WeChatModel {

  static final WeChatModelImpl _singleton = WeChatModelImpl._internal();

  factory WeChatModelImpl() => _singleton;

  WeChatModelImpl._internal();

  /// DataAgent
  final WeChatDataAgent _dataAgent = CloudFirestoreDataAgentImpl();

  @override
  Stream<List<MomentVO>> getMoments() {
    return _dataAgent.getMoments();
  }

  @override
  Future<void> addNewMoment(String description, File? chosenMedia) {
    if (chosenMedia != null) {
      return _dataAgent
          .uploadFileToStorage(chosenMedia)
          .then((downloadUrl) => craftNewMoment(description, downloadUrl))
          .then((value) => _dataAgent.addNewMoment(value));
    } else {
      return craftNewMoment(description, "")
          .then((moment) => _dataAgent.addNewMoment(moment));
    }
  }

  Future<MomentVO> craftNewMoment(String description, String chosenMediaUrl) {
    return Future.value(
      MomentVO(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        description: description,
        profilePicture:
            "https://i.pinimg.com/originals/39/e9/b3/39e9b39628e745a39f900dc14ee4d9a7.jpg",
        username: "Nina Rocha",
        postMedia: chosenMediaUrl,
      ),
    );
  }

  @override
  Future<void> deleteMoment(String momentId) {
    return _dataAgent.deleteMoment(momentId);
  }

  @override
  Stream<MomentVO> getMomentById(String momentId) {
    return _dataAgent.getMomentById(momentId);
  }

  @override
  Future<void> editMoment(MomentVO? moment, File? chosenMedia) {
    if (chosenMedia != null) {
      return _dataAgent.uploadFileToStorage(chosenMedia).then((downloadUrl) {
        moment?.postMedia = downloadUrl;
        return moment;
      }).then((value) {
        if (value != null) {
          _dataAgent.addNewMoment(value);
        } else {
          return Future.error("Error");
        }
      });
    } else {
      if (moment != null) {
        return _dataAgent.addNewMoment(moment);
      } else {
        return Future.error("Error");
      }
    }
  }
}
