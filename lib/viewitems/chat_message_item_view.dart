import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat_redesign/viewitems/post_item_view.dart';

import '../data/vos/message_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class ChatMessageItemView extends StatefulWidget {
  final bool isOwnMessage;
  final MessageVO? message;

  ChatMessageItemView({
    required this.isOwnMessage,
    required this.message,
  });

  @override
  State<ChatMessageItemView> createState() => _ChatMessageItemViewState();
}

class _ChatMessageItemViewState extends State<ChatMessageItemView> {
  late FlickManager _flickManager;

  @override
  void initState() {
    super.initState();
    _flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        widget.message?.mediaUrl ?? "",
      ),
      autoPlay: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.isOwnMessage
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.isOwnMessage
                ? Container()
                : (widget.message?.message?.isEmpty == true)
                  ? Row(
                  children: [
                    const SizedBox(width: MARGIN_MEDIUM),
                    CircleAvatar(
                      radius: MARGIN_MEDIUM_3,
                      backgroundImage: NetworkImage(
                        widget.message?.profileUrl ?? "",
                      ),
                    ),
                  ],
                )
                  : const SizedBox(width: MARGIN_XXLARGE),
            Visibility(
              visible: (widget.message?.mediaUrl?.isNotEmpty == true),
              child: (getUrlType(widget.message?.mediaUrl ?? "") ==
                      UrlType.OTHER)
                  ? Container(
                      width: 200,
                      height: 130,
                      margin: const EdgeInsets.only(
                        left: MARGIN_CARD_MEDIUM_2,
                        right: MARGIN_MEDIUM_2,
                        bottom: MARGIN_MEDIUM,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(
                          MARGIN_MEDIUM,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(widget.message?.mediaUrl ?? ""),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      height: 130,
                      margin: const EdgeInsets.only(
                        left: MARGIN_CARD_MEDIUM_2,
                        right: MARGIN_MEDIUM_2,
                        bottom: MARGIN_MEDIUM,
                      ),
                      child: FlickVideoPlayer(flickManager: _flickManager),
                    ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            widget.isOwnMessage ? const Spacer() : Container(),
            Visibility(
              visible: (widget.isOwnMessage == false &&
                  widget.message?.message?.isNotEmpty == true),
              child: Row(
                children: [
                  const SizedBox(width: MARGIN_MEDIUM),
                  CircleAvatar(
                    radius: MARGIN_MEDIUM_3,
                    backgroundImage: NetworkImage(
                      widget.message?.profileUrl ?? "",
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: (widget.message?.message?.isNotEmpty == true),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                margin: const EdgeInsets.only(
                  left: MARGIN_MEDIUM,
                  right: MARGIN_MEDIUM_2,
                ),
                decoration: BoxDecoration(
                  color: SLIDABLE_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.circular(MARGIN_LARGE),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_2,
                    vertical: MARGIN_CARD_MEDIUM_2,
                  ),
                  child: Text(
                    widget.message?.message ?? "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: TEXT_REGULAR_2X,
                    ),
                  ),
                ),
              ),
            ),
            widget.isOwnMessage ? Container() : const Spacer(),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _flickManager.dispose();
  }
}
