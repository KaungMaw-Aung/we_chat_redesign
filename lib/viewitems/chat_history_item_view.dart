import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:we_chat_redesign/data/vos/chat_history_vo.dart';

import '../data/vos/message_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class ChatHistoryItemView extends StatelessWidget {
  final int index;
  final ChatHistoryVO? chatHistory;
  final Function(String, int) onTapDelete;
  final Function onTap;

  ChatHistoryItemView({
    required this.index,
    required this.chatHistory,
    required this.onTapDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(Key(index.toString())),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: SLIDABLE_BACKGROUND_COLOR,
            foregroundColor: SLIDABLE_CONFIRM_ICON_COLOR,
            icon: Icons.check_circle,
          ),
          SlidableAction(
            onPressed: (context) => onTapDelete(chatHistory?.uid ?? "", index),
            backgroundColor: SLIDABLE_BACKGROUND_COLOR,
            foregroundColor: SLIDABLE_DISMISS_ICON_COLOR,
            icon: Icons.cancel,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => onTap(),
        child: SizedBox(
          height: CHAT_HISTORY_ITEM_HEIGHT,
          child: Row(
            children: [
              const SizedBox(width: MARGIN_MEDIUM_2),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  chatHistory?.profileUrl ?? "",
                ),
                radius: CHAT_HISTORY_ITEM_PROFILE_RADIUS,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: MARGIN_MEDIUM),
                    Row(
                      children: [
                        const SizedBox(width: MARGIN_MEDIUM),
                        Padding(
                          padding: const EdgeInsets.only(top: MARGIN_MEDIUM),
                          child: Text(
                            chatHistory?.name ?? "",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: TEXT_CARD_REGULAR_2X,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "2:22",
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: TEXT_REGULAR,
                          ),
                        ),
                        const SizedBox(width: MARGIN_MEDIUM),
                      ],
                    ),
                    const SizedBox(height: MARGIN_SMALL),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                      child: Text(
                        chatHistory?.lastMessage ?? "",
                        maxLines: 2,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    const SizedBox(height: MARGIN_MEDIUM),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}