import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat_redesign/blocs/conversation_bloc.dart';

import '../data/vos/message_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/chat_message_item_view.dart';
import '../viewitems/post_item_view.dart';
import '../widgets/contacts_feature_item_view.dart';

class ConversationPage extends StatelessWidget {
  final String currentUserId;
  final String receiverId;
  final String receiverProfileUrl;
  final String receiverName;

  ConversationPage({
    required this.currentUserId,
    required this.receiverId,
    required this.receiverProfileUrl,
    required this.receiverName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Text(
          receiverName,
          style: const TextStyle(color: Colors.white70),
        ),
        centerTitle: true,
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: const [
              Icon(
                Icons.chevron_left,
                color: Colors.white70,
                size: MARGIN_XLARGE,
              ),
              Text(
                APP_NAME,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: TEXT_CARD_REGULAR_2X,
                ),
              ),
            ],
          ),
        ),
        actions: const [
          Icon(
            Icons.person_outline,
            color: Colors.white70,
            size: MARGIN_XLARGE,
          ),
          SizedBox(width: MARGIN_MEDIUM),
        ],
      ),
      body: ChangeNotifierProvider<ConversationBloc>(
        create: (context) => ConversationBloc(
          receiverId: receiverId,
          senderId: currentUserId,
        ),
        child: Consumer<ConversationBloc>(
          builder: (context, bloc, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VerticalChatMessagesListView(
                  messages: bloc.messages,
                  senderId: currentUserId,
                ),
                ChatInputBoxWithFeaturesSectionView(
                  isExpanded: bloc.isChatFeaturesShown,
                  onTapToggle: () {
                    ConversationBloc bloc =
                    Provider.of(context, listen: false);
                    bloc.onTapChatFeaturesToggle();
                  },
                  media: bloc.chosenMedia,
                  onTapFilePicker: () async {
                    FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                    if (result != null) {
                      File file = File(result.files.single.path ?? "");
                      bloc.onChooseMedia(file);
                    }
                  },
                  onTapSubmit: (message) {
                    bloc.onTapSend(message).then((_) {
                      bloc.onMessageSent();
                      bloc.removeMedia();
                    });
                  },
                  isMessageSent: bloc.isMessageSent,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class VerticalChatMessagesListView extends StatelessWidget {
  const VerticalChatMessagesListView({
    Key? key,
    required this.messages,
    required this.senderId,
  }) : super(key: key);

  final List<MessageVO>? messages;
  final String senderId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
        itemCount: messages?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return ChatMessageItemView(
            isOwnMessage: messages?[index].userId == senderId,
            message: messages?[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: MARGIN_MEDIUM_2);
        },
      ),
    );
  }
}

class ChatInputBoxWithFeaturesSectionView extends StatelessWidget {
  final bool isExpanded;
  final Function onTapToggle;
  final Function onTapFilePicker;
  final File? media;
  final Function(String) onTapSubmit;
  final bool isMessageSent;

  var kAnimationDuration = const Duration(milliseconds: 300);

  ChatInputBoxWithFeaturesSectionView({
    required this.isExpanded,
    required this.onTapToggle,
    required this.onTapFilePicker,
    required this.media,
    required this.onTapSubmit,
    required this.isMessageSent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChatInputBoxView(
          isExpanded: isExpanded,
          onTapToggle: onTapToggle,
          media: media,
          onTapSubmit: onTapSubmit,
          isMessageSent: isMessageSent,
        ),
        AnimatedSize(
          duration: kAnimationDuration,
          curve: Curves.fastLinearToSlowEaseIn,
          child: SizedBox(
            height: isExpanded ? null : 0,
            child: ChatFeaturesView(
              onTapFilePicker: onTapFilePicker,
            ),
          ),
        ),
      ],
    );
  }
}

class ChatFeaturesView extends StatelessWidget {
  final Function onTapFilePicker;

  ChatFeaturesView({required this.onTapFilePicker});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: CHAT_BOX_TEXT_FIELD_BACKGROUND_COLOR,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: MARGIN_XLARGE,
              ),
              child: Row(
                children: [
                  ContactsFeatureItemView(
                    label: PHOTOS,
                    icon: Icons.photo_outlined,
                    onTap: onTapFilePicker,
                  ),
                  ContactsFeatureItemView(
                    label: CAMERA,
                    icon: Icons.camera_enhance_outlined,
                  ),
                  ContactsFeatureItemView(
                    label: SIGHT,
                    icon: Icons.insights,
                  ),
                  ContactsFeatureItemView(
                    label: VIDEO_CALL,
                    icon: Icons.video_call_outlined,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: MARGIN_XLARGE,
              ),
              child: Row(
                children: [
                  ContactsFeatureItemView(
                    label: LUCK_MONEY,
                    icon: Icons.money,
                  ),
                  ContactsFeatureItemView(
                    label: TRANSFER,
                    icon: Icons.compare_arrows,
                  ),
                  ContactsFeatureItemView(
                    label: FAVORITES,
                    icon: Icons.favorite_outline,
                  ),
                  ContactsFeatureItemView(
                    label: LOCATION,
                    icon: Icons.location_on_outlined,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class ChatInputBoxView extends StatefulWidget {
  final bool isExpanded;
  final Function onTapToggle;
  final File? media;
  final Function(String) onTapSubmit;
  final bool isMessageSent;

  ChatInputBoxView({
    required this.isExpanded,
    required this.onTapToggle,
    required this.media,
    required this.onTapSubmit,
    required this.isMessageSent,
  });

  @override
  State<ChatInputBoxView> createState() => _ChatInputBoxViewState();
}

class _ChatInputBoxViewState extends State<ChatInputBoxView> {
  late FlickManager _flickManager;

  @override
  void initState() {
    super.initState();
    _flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.file(
        widget.media ?? File(""),
      ),
      autoPlay: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SEARCH_BAR_BACKGROUND_COLOR,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: (widget.media != null),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 160,
                  margin: const EdgeInsets.only(
                    top: MARGIN_MEDIUM,
                    left: MARGIN_XXLARGE,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
                  ),
                  child: (getUrlType(widget.media?.uri.path ?? "") ==
                          UrlType.OTHER)
                      ? Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                MARGIN_MEDIUM_2,
                              ),
                              image: DecorationImage(
                                image: FileImage(
                                  widget.media ?? File(""),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : FlickVideoPlayer(
                          flickManager: _flickManager,
                        ),
                ),
                const Spacer(),
                Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      ConversationBloc bloc =
                          Provider.of(context, listen: false);
                      bloc.removeMedia();
                    },
                    icon: const Icon(
                      Icons.highlight_remove_outlined,
                      size: MARGIN_XLARGE,
                      color: Colors.black54,
                    ),
                  );
                }),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mic_none_outlined,
                  size: MARGIN_XLARGE,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: MARGIN_CARD_MEDIUM_2,
                  ),
                  decoration: BoxDecoration(
                    color: CHAT_BOX_TEXT_FIELD_BACKGROUND_COLOR,
                    borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
                  ),
                  child: TextField(
                    controller: widget.isMessageSent
                        ? TextEditingController(text: "")
                        : null,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                      hintText: CHAT_BOX_TEXT_FIELD_HINT,
                      hintStyle: TextStyle(
                        color: Colors.black12,
                      ),
                      suffixIcon: Icon(Icons.emoji_emotions),
                    ),
                    onChanged: (_) {
                      ConversationBloc bloc = Provider.of(
                        context,
                        listen: false,
                      );
                      bloc.onTypedMessage();
                    },
                    onSubmitted: (text) => widget.onTapSubmit(text),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => widget.onTapToggle(),
                icon: Icon(
                  widget.isExpanded ? Icons.clear : Icons.add,
                  size: MARGIN_XLARGE,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _flickManager.dispose();
  }
}
