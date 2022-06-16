import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../data/vos/message_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class ChatHistoryItemView extends StatelessWidget {
  final int index;
  final MessageVO messageVO;
  final Function(int) onTapDismiss;
  final Function onTap;

  ChatHistoryItemView({
    required this.index,
    required this.messageVO,
    required this.onTapDismiss,
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
            onPressed: (context) => onTapDismiss(index),
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
                  messageVO.profileUrl ?? "",
                ),
                radius: CHAT_HISTORY_ITEM_PROFILE_RADIUS,
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: MARGIN_MEDIUM),
                    Row(
                      children: [
                        const SizedBox(width: MARGIN_MEDIUM),
                        Padding(
                          padding: const EdgeInsets.only(top: MARGIN_MEDIUM),
                          child: Text(
                            messageVO.username ?? "",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: TEXT_CARD_REGULAR_2X,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          messageVO.sentAt ?? "",
                          style: const TextStyle(
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
                        messageVO.message ?? "",
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