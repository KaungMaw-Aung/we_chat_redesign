import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:we_chat_redesign/data/models/we_chat_model_impl.dart';
import 'package:we_chat_redesign/data/vos/moment_vo.dart';

import '../data/models/we_chat_model.dart';

class AddNewMomentBloc extends ChangeNotifier {
  /// State Variables
  bool isLoading = false;
  bool isDisposed = false;
  bool isPostButtonEnable = true;
  bool isInEditMode = false;

  /// App Data
  String momentDescription = "";
  File? chosenMedia;
  MomentVO? loadedMoment;
  String? loadedMediaUrl;
  String username;
  String profileUrl;

  /// Models
  final WeChatModel _model = WeChatModelImpl();

  AddNewMomentBloc({
    String? momentId,
    required this.username,
    required this.profileUrl,
  }) {
    if (momentId != null) {
      isInEditMode = true;
      prepopulateDataForEditMode(momentId);
      safelyNotifyListeners();
    }
  }

  void prepopulateDataForEditMode(String momentId) {
    _model.getMomentById(momentId).listen((moment) {
      loadedMoment = moment;
      momentDescription = moment.description ?? "";
      loadedMediaUrl = moment.postMedia;
      safelyNotifyListeners();
    });
  }

  Future<void> onTapPostButton() {
    isLoading = true;
    safelyNotifyListeners();
    if (isInEditMode) {
      return editMoment().whenComplete(() {
        isLoading = false;
        safelyNotifyListeners();
      });
    } else {
      return addNewMoment().whenComplete(() {
        isLoading = false;
        safelyNotifyListeners();
      });
    }
  }

  Future<void> addNewMoment() {
    return _model.addNewMoment(
      momentDescription,
      chosenMedia,
      username,
      profileUrl,
    );
  }

  Future<void> editMoment() {
    loadedMoment?.description = momentDescription;
    loadedMoment?.postMedia = loadedMediaUrl;
    return _model.editMoment(loadedMoment, chosenMedia);
  }

  void onDescriptionChanged(String text) {
    momentDescription = text;
    // isPostButtonEnable = momentDescription.isNotEmpty || chosenMedia != null;
    // safelyNotifyListeners();
  }

  void onChooseMedia(File chosenMedia) {
    loadedMediaUrl = null;
    this.chosenMedia = chosenMedia;
    // isPostButtonEnable = true;
    safelyNotifyListeners();
  }

  void onDeleteMedia() {
    chosenMedia = null;
    loadedMediaUrl = null;
    // isPostButtonEnable = momentDescription.isNotEmpty;
    safelyNotifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void safelyNotifyListeners() {
    if (isDisposed == false) {
      notifyListeners();
    }
  }
}
