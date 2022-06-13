import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat_redesign/data/vos/moment_vo.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class PostItemView extends StatelessWidget {
  final MomentVO? momentVO;
  final Function(String) onTapDelete;
  final Function(String) onTapEdit;

  PostItemView({
    required this.momentVO,
    required this.onTapDelete,
    required this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostItemProfileUsernameAndCreatedAtView(
          username: momentVO?.username,
          profileUrl: momentVO?.profilePicture,
        ),
        PostDescriptionMediaLikeCommentAndMoreSectionView(
          mediaUrl: momentVO?.postMedia,
          description: momentVO?.description,
          onTapDelete: () {
            onTapDelete(momentVO?.id ?? "-1");
          },
          onTapEdit: () {
            onTapEdit(momentVO?.id ?? "-1");
          },
        ),
        Container(
          height: MARGIN_MEDIUM,
          color: Colors.black12,
        ),
        const PostLikeAndCommentSectionView(),
      ],
    );
  }
}

class PostLikeAndCommentSectionView extends StatelessWidget {
  const PostLikeAndCommentSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CONTACT_TOP_BAR_BACKGROUND_COLOR,
      child: Column(
        children: const [
          SizedBox(height: MARGIN_MEDIUM_2),
          LikedPeopleSectionView(),
          SizedBox(height: MARGIN_MEDIUM_2),
          CommentSectionView(),
          SizedBox(height: MARGIN_MEDIUM_2),
        ],
      ),
    );
  }
}

class CommentSectionView extends StatelessWidget {
  const CommentSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: MARGIN_XXLARGE),
        const Icon(
          Icons.messenger,
          size: MARGIN_MEDIUM_2,
          color: POST_LIKE_AND_COMMENT_ICON_COLOR,
        ),
        const SizedBox(width: MARGIN_MEDIUM),
        Expanded(
          child: Column(
            children: [
              UsernameAndCommentView(
                username: "Andy",
                comment: "I have read all his books.",
              ),
              const SizedBox(height: MARGIN_SMALL),
              UsernameAndCommentView(
                username: "Nina Rocha",
                comment:
                    "As usual, recent history is less exciting than the distant past.",
              ),
            ],
          ),
        ),
        const SizedBox(width: MARGIN_XXLARGE),
      ],
    );
  }
}

class LikedPeopleSectionView extends StatelessWidget {
  const LikedPeopleSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(width: MARGIN_XXLARGE),
        Icon(
          Icons.favorite,
          size: MARGIN_MEDIUM_3,
          color: POST_LIKE_AND_COMMENT_ICON_COLOR,
        ),
        SizedBox(width: MARGIN_MEDIUM),
        Expanded(
          child: Text(
            "Nuno Rocha, Amie Deane, Alan Lu, Sam Deane, Ale Munoz",
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: MARGIN_XXLARGE),
      ],
    );
  }
}

class UsernameAndCommentView extends StatelessWidget {
  final String username;
  final String comment;

  UsernameAndCommentView({
    required this.username,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          username,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM),
        Expanded(
          child: Text(
            comment,
            style: const TextStyle(
              color: POST_DESCRIPTION_FONT_COLOR,
              fontWeight: FontWeight.w400,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}

class PostDescriptionMediaLikeCommentAndMoreSectionView extends StatefulWidget {
  final String? description;
  final String? mediaUrl;
  final Function onTapDelete;
  final Function onTapEdit;

  PostDescriptionMediaLikeCommentAndMoreSectionView({
    required this.description,
    required this.mediaUrl,
    required this.onTapDelete,
    required this.onTapEdit,
  });

  @override
  State<PostDescriptionMediaLikeCommentAndMoreSectionView> createState() =>
      _PostDescriptionMediaLikeCommentAndMoreSectionViewState();
}

class _PostDescriptionMediaLikeCommentAndMoreSectionViewState
    extends State<PostDescriptionMediaLikeCommentAndMoreSectionView> {
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.network(widget.mediaUrl ?? ""),
      autoPlay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: MARGIN_MEDIUM),
          PostDescriptionView(description: widget.description),
          const SizedBox(height: MARGIN_MEDIUM_3),
          Visibility(
            visible: widget.mediaUrl?.isNotEmpty == true,
            child: Column(
              children: [
                (getUrlType(widget.mediaUrl ?? "") == UrlType.OTHER)
                    ? Container(
                        height: POST_MEDIA_VIEW_HEIGHT,
                        margin: const EdgeInsets.symmetric(
                          horizontal: MARGIN_CARD_MEDIUM_2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            MARGIN_MEDIUM,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.mediaUrl ?? "",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        height: POST_VIDEO_PLAYER_VIEW_HEIGHT,
                        margin: const EdgeInsets.symmetric(
                          horizontal: MARGIN_CARD_MEDIUM_2,
                        ),
                        child: FlickVideoPlayer(
                          flickManager: flickManager,
                        ),
                      ),
                const SizedBox(height: MARGIN_CARD_MEDIUM_2),
              ],
            ),
          ),
          LikeCommentAndMoreSectionView(
            onTapDelete: widget.onTapDelete,
            onTapEdit: widget.onTapEdit,
          ),
          const SizedBox(height: MARGIN_CARD_MEDIUM_2),
        ],
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }
}

enum UrlType { VIDEO, OTHER }

UrlType getUrlType(String url) {
  Uri uri = Uri.parse(url);
  if (uri.path.contains(".mp4")) {
    return UrlType.VIDEO;
  } else {
    return UrlType.OTHER;
  }
}

class LikeCommentAndMoreSectionView extends StatelessWidget {
  final Function onTapDelete;
  final Function onTapEdit;

  LikeCommentAndMoreSectionView({
    required this.onTapDelete,
    required this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.favorite_outline,
            color: Colors.black38,
            size: MARGIN_XLARGE,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: MARGIN_SMALL),
        IconButton(
          icon: const Icon(
            Icons.messenger_outline,
            color: Colors.black38,
            size: MARGIN_XLARGE,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: MARGIN_SMALL),
        MoreButtonView(
          onTapEdit: onTapEdit,
          onTapDelete: onTapDelete,
        ),
        const SizedBox(width: MARGIN_LARGE),
      ],
    );
  }
}

class MoreButtonView extends StatelessWidget {
  final Function onTapDelete;
  final Function onTapEdit;

  MoreButtonView({
    required this.onTapDelete,
    required this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_horiz,
        color: Colors.black38,
        size: MARGIN_XLARGE,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            onTapEdit();
          },
          value: 1,
          child: const Text("Edit"),
        ),
        PopupMenuItem(
          onTap: () {
            onTapDelete();
          },
          value: 2,
          child: const Text("Delete"),
        )
      ],
    );
  }
}

class PostDescriptionView extends StatelessWidget {
  final String? description;

  PostDescriptionView({required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_XXLARGE,
      ),
      child: Text(
        description ?? "",
        style: const TextStyle(
          color: POST_DESCRIPTION_FONT_COLOR,
          fontWeight: FontWeight.w400,
          height: 1.3,
        ),
      ),
    );
  }
}

class PostItemProfileUsernameAndCreatedAtView extends StatelessWidget {
  final String? username;
  final String? profileUrl;

  PostItemProfileUsernameAndCreatedAtView({
    required this.username,
    required this.profileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: CONTACT_TOP_BAR_BACKGROUND_COLOR,
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: MARGIN_MEDIUM,
                        bottom: MARGIN_SMALL,
                      ),
                      child: Text(
                        "12 mins ago",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(width: MARGIN_LARGE),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      profileUrl ?? "",
                    ),
                    radius: CONTACT_ITEM_PROFILE_RADIUS,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: MARGIN_MEDIUM_2,
                      bottom: MARGIN_SMALL,
                    ),
                    child: Text(
                      username ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: TEXT_REGULAR_3X,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
