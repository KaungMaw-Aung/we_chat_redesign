import 'package:flutter/foundation.dart';
import 'package:we_chat_redesign/data/models/we_chat_model_impl.dart';

import '../data/models/we_chat_model.dart';
import '../data/vos/contact_vo.dart';

class ContactsBloc extends ChangeNotifier {
  /// State Variables
  bool isDisposed = false;
  List<ContactVO>? contacts;

  /// Models
  final WeChatModel _model = WeChatModelImpl();

  ContactsBloc() {
    /// Get Contacts
    _model.getContacts().listen((contacts) {
      this.contacts = contacts
          .map(
            (value) => ContactVO(
              id: value.id,
              profileUrl: value.profilePicture,
              name: value.name,
            ),
          ).toList();

      ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
          .forEach((alphabet) {
        var result = this.contacts?.firstWhere(
              (element) => element.name?.startsWith(alphabet) ?? false,
              orElse: () => ContactVO(
                id: null,
                profileUrl: null,
                name: null,
                label: null,
                showTopAlphabetBar: false,
              ),
            );
        if (result?.id != null) {
          result?.showTopAlphabetBar = true;
          result?.alphabet = alphabet;
          result?.contactsCount = this
              .contacts
              ?.where((element) => element.name?.startsWith(alphabet) ?? false)
              .length;
        }
      });

      safelyNotifyListeners();
    }).onError((error) => debugPrint(error.toString()));
  }

  void safelyNotifyListeners() {
    if (isDisposed == false) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
