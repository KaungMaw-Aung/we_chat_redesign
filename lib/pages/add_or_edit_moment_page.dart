import 'dart:io';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat_redesign/blocs/add_new_moment_bloc.dart';
import 'package:we_chat_redesign/resources/dimens.dart';
import 'package:we_chat_redesign/widgets/horizontal_divider_view.dart';

import '../resources/colors.dart';
import '../resources/strings.dart';
import '../viewitems/post_item_view.dart';

class AddOrEditMomentPage extends StatefulWidget {
  const AddOrEditMomentPage({Key? key}) : super(key: key);

  @override
  State<AddOrEditMomentPage> createState() => _AddOrEditMomentPageState();
}

class _AddOrEditMomentPageState extends State<AddOrEditMomentPage> {
  late FlickManager _flickManager;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<AddNewMomentBloc>(
        create: (context) => AddNewMomentBloc(),
        child: SafeArea(
          child: Stack(
            children: [
              ExpandableBottomSheet(
                background: Column(
                  children: [
                    Selector<AddNewMomentBloc, bool>(
                      selector: (context, bloc) => bloc.isPostButtonEnable,
                      builder: (context, isPostButtonEnable, child) {
                        return AppBarView(
                          isPostButtonEnable: isPostButtonEnable,
                          onTapPostButton: () {
                            AddNewMomentBloc bloc = Provider.of(
                              context,
                              listen: false,
                            );
                            bloc
                                .onTapPostButton()
                                .then((value) => Navigator.pop(context));
                          },
                        );
                      },
                    ),
                    const SizedBox(height: MARGIN_SMALL),
                    const HorizontalDividerView(),
                    const SizedBox(height: MARGIN_CARD_MEDIUM_2),
                    const UserProfileAndNameSectionView(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: MARGIN_MEDIUM_2,
                        right: MARGIN_MEDIUM_2,
                        top: MARGIN_MEDIUM,
                      ),
                      child: Builder(
                        builder: (BuildContext context) {
                          return TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: WHAT_IS_ON_YOUR_MIND,
                              hintStyle: TextStyle(
                                fontSize: TEXT_REGULAR_3X,
                                color: Colors.black38,
                              ),
                            ),
                            onChanged: (input) {
                              AddNewMomentBloc bloc =
                                  Provider.of(context, listen: false);
                              bloc.onDescriptionChanged(input);
                            },
                            cursorWidth: 0.8,
                            cursorHeight: MARGIN_MEDIUM_3,
                          );
                        },
                      ),
                    ),
                    Selector<AddNewMomentBloc, File?>(
                      selector: (context, bloc) => bloc.chosenMedia,
                      builder: (context, chosenMedia, child) {
                        return Visibility(
                          visible: chosenMedia != null,
                          child: Column(
                            children: [
                              (getUrlType(chosenMedia?.uri.path ?? "") ==
                                      UrlType.OTHER)
                                  ? Stack(
                                      children: [
                                        Container(
                                          height: POST_MEDIA_VIEW_HEIGHT,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: MARGIN_CARD_MEDIUM_2,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              MARGIN_MEDIUM,
                                            ),
                                            image: DecorationImage(
                                              image: FileImage(
                                                chosenMedia ?? File(""),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: MARGIN_SMALL,
                                          child: IconButton(
                                            onPressed: () {
                                              AddNewMomentBloc bloc = Provider.of(context, listen: false);
                                              bloc.onDeleteMedia();
                                            },
                                            icon: const Icon(
                                              Icons.delete_forever,
                                              color: Colors.red,
                                              size: MARGIN_XLARGE,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Stack(
                                    children: [
                                      Container(
                                        height: POST_VIDEO_PLAYER_VIEW_HEIGHT,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: MARGIN_CARD_MEDIUM_2,
                                        ),
                                        child: (chosenMedia != null)
                                            ? FlickVideoPlayer(
                                          flickManager:
                                          initializeFlickManager(
                                            chosenMedia,
                                          ),
                                        )
                                            : null,
                                      ),
                                      Positioned(
                                        right: MARGIN_SMALL,
                                        child: IconButton(
                                          onPressed: () {
                                            AddNewMomentBloc bloc = Provider.of(context, listen: false);
                                            bloc.onDeleteMedia();
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                            size: MARGIN_XLARGE,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              const SizedBox(height: MARGIN_CARD_MEDIUM_2),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                persistentHeader: const SizedBox(
                  height: MARGIN_XXLARGE,
                  child: Center(
                    child: Icon(
                      Icons.expand_less,
                      size: MARGIN_XLARGE,
                    ),
                  ),
                ),
                expandableContent: Builder(
                  builder: (context) => ExpandableContentsView(
                    onTapChooseMedia: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        File file = File(result.files.single.path ?? "");
                        AddNewMomentBloc bloc =
                            Provider.of(context, listen: false);
                        bloc.onChooseMedia(file);
                      }
                    },
                  ),
                ),
              ),
              Selector<AddNewMomentBloc, bool>(
                selector: (context, bloc) => bloc.isLoading,
                builder: (context, isLoading, child) {
                  return Visibility(
                    visible: isLoading,
                    child: const LoadingView(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  FlickManager initializeFlickManager(File chosenVideoFile) {
    return _flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.file(chosenVideoFile),
      autoPlay: false,
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: const Center(
        child: SizedBox(
          width: MARGIN_XXLARGE,
          height: MARGIN_XXLARGE,
          child: LoadingIndicator(
            indicatorType: Indicator.orbit,
            colors: [Colors.white],
            strokeWidth: 2,
            backgroundColor: Colors.transparent,
            pathBackgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}

class ExpandableContentsView extends StatelessWidget {
  final Function onTapChooseMedia;

  ExpandableContentsView({required this.onTapChooseMedia});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomSheetListTileView(
          label: PHOTO_VIDEO,
          leading: Icons.photo,
          leadingColor: PHOTO_VIDEO_ICON_COLOR,
          onTap: onTapChooseMedia,
        ),
        BottomSheetListTileView(
          label: TAG_PEOPLE,
          leading: Icons.people,
          leadingColor: TAG_PEOPLE_ICON_COLOR,
          onTap: () {},
        ),
        BottomSheetListTileView(
          label: FEELING_ACTIVITY,
          leading: Icons.sentiment_very_satisfied_outlined,
          leadingColor: FEELING_ACTIVITY_ICON_COLOR,
          onTap: () {},
        ),
        BottomSheetListTileView(
          label: CHECK_IN,
          leading: Icons.location_on,
          leadingColor: CHECK_IN_ICON_COLOR,
          onTap: () {},
        ),
        BottomSheetListTileView(
          label: LIVE_VIDEO,
          leading: Icons.video_call_rounded,
          leadingColor: LIVE_VIDEO_ICON_COLOR,
          onTap: () {},
        ),
        BottomSheetListTileView(
          label: BACKGROUND_COLOR,
          leading: Icons.sort_by_alpha,
          leadingColor: BACKGROUND_COLOR_ICON_COLOR,
          onTap: () {},
        ),
        BottomSheetListTileView(
          label: CAMERA,
          leading: Icons.camera_alt_rounded,
          leadingColor: CAMERA_ICON_COLOR,
          onTap: () {},
        ),
        BottomSheetListTileView(
          label: GIF,
          leading: Icons.gif,
          leadingColor: GIF_ICON_COLOR,
          onTap: () {},
        ),
        BottomSheetListTileView(
          label: HOST_Q_AND_A,
          leading: Icons.mic_rounded,
          leadingColor: LIVE_VIDEO_ICON_COLOR,
          onTap: () {},
        ),
      ],
    );
  }
}

class BottomSheetListTileView extends StatelessWidget {
  final String label;
  final IconData leading;
  final Color leadingColor;
  final Function onTap;

  BottomSheetListTileView({
    required this.label,
    required this.leading,
    required this.leadingColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const HorizontalDividerView(),
          ListTile(
            onTap: () => onTap(),
            style: ListTileStyle.list,
            leading: Icon(
              leading,
              size: MARGIN_XLARGE,
              color: leadingColor,
            ),
            title: Text(
              label,
              style: const TextStyle(
                fontSize: TEXT_CARD_REGULAR_2X,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileAndNameSectionView extends StatelessWidget {
  const UserProfileAndNameSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(width: MARGIN_CARD_MEDIUM_2),
        CircleAvatar(
          backgroundImage: NetworkImage(
            "https://i.pinimg.com/originals/39/e9/b3/39e9b39628e745a39f900dc14ee4d9a7.jpg",
          ),
          radius: MARGIN_LARGE,
        ),
        SizedBox(width: MARGIN_CARD_MEDIUM_2),
        UsernameAndFriendsButtonView(),
      ],
    );
  }
}

class UsernameAndFriendsButtonView extends StatelessWidget {
  const UsernameAndFriendsButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: MARGIN_SMALL),
        const Text(
          "Nina Rocha",
          style: TextStyle(
            color: Colors.black54,
            fontSize: TEXT_CARD_REGULAR_2X,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: MARGIN_SMALL),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            border: Border.all(color: Colors.black54),
          ),
          child: Row(
            children: const [
              SizedBox(width: MARGIN_SMALL),
              Icon(
                Icons.people,
                size: MARGIN_MEDIUM_2,
                color: Colors.black54,
              ),
              SizedBox(width: MARGIN_SMALL),
              Text(
                FRIENDS,
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AppBarView extends StatelessWidget {
  final bool isPostButtonEnable;
  final Function onTapPostButton;

  AppBarView({
    required this.isPostButtonEnable,
    required this.onTapPostButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black54,
            size: MARGIN_XLARGE,
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM),
        const Text(
          CREATE_POST,
          style: TextStyle(
            fontSize: TEXT_REGULAR_3X,
            color: Colors.black38,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            if (isPostButtonEnable) {
              onTapPostButton();
            }
          },
          style: ButtonStyle(
            backgroundColor: isPostButtonEnable
                ? POST_BUTTON_BACKGROUND_COLOR
                : POST_BUTTON_DISABLE_COLOR,
            elevation: MaterialStateProperty.all(0.0),
          ),
          child: Text(
            POST,
            style: TextStyle(
              color: isPostButtonEnable ? null : POST_BUTTON_TEXT_DISABLE_COLOR,
            ),
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM),
      ],
    );
  }
}
