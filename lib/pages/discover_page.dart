import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_redesign/blocs/discover_bloc.dart';
import 'package:we_chat_redesign/data/vos/moment_vo.dart';
import 'package:we_chat_redesign/utils/extensions.dart';

import '../data/vos/user_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/post_item_view.dart';
import 'add_or_edit_moment_page.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiscoverBloc>(
      create: (context) => DiscoverBloc(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: PRIMARY_COLOR,
              title: const Text(
                MOMENTS,
                style: TextStyle(color: Colors.white70),
              ),
              centerTitle: true,
              actions: [
                Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: MARGIN_XLARGE,
                    ),
                    color: Colors.white70,
                    onPressed: () {
                      DiscoverBloc bloc = Provider.of(context, listen: false);
                      navigateToScreen(
                        context,
                        AddOrEditMomentPage(
                          username: bloc.profileData?.name ?? "",
                          profileUrl: bloc.profileData?.profilePicture ?? "",
                        ),
                      );
                    },
                  );
                }),
                const SizedBox(width: MARGIN_MEDIUM),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Selector<DiscoverBloc, UserVO?>(
                    selector: (context, bloc) => bloc.profileData,
                    builder: (context, profile, child) {
                      return MomentProfileView(profileData: profile);
                    },
                  ),
                  Selector<DiscoverBloc, List<MomentVO>?>(
                    selector: (context, bloc) => bloc.moments,
                    builder: (context, moments, child) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: moments?.length ?? 0,
                        itemBuilder: (context, index) {
                          return PostItemView(
                            momentVO: moments?[index],
                            onTapDelete: (momentId) {
                              DiscoverBloc bloc =
                                  Provider.of(context, listen: false);
                              bloc.deleteMoment(momentId);
                            },
                            onTapEdit: (momentId) {
                              Future.delayed(const Duration(milliseconds: 1000))
                                  .then((value) {
                                DiscoverBloc bloc = Provider.of(
                                  context,
                                  listen: false,
                                );
                                navigateToScreen(
                                  context,
                                  AddOrEditMomentPage(
                                    momentId: momentId,
                                    username: bloc.profileData?.name ?? "",
                                    profileUrl:
                                        bloc.profileData?.profilePicture ?? "",
                                  ),
                                );
                              });
                            },
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          Selector<DiscoverBloc, bool>(
            selector: (context, bloc) => bloc.isCommandTextBoxOverlayShowing,
            builder: (context, isCommandOverlayShowing, child) {
              return Visibility(
                visible: isCommandOverlayShowing,
                child: Container(
                  color: Colors.black87,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(left: MARGIN_XXLARGE),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.chevron_right,
                              color: TEXT_BOX_TOP_ICON_COLOR,
                              size: MARGIN_XLARGE,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: MARGIN_MEDIUM_2,
                                      bottom: MARGIN_MEDIUM,
                                    ),
                                    child: Container(
                                      height: 0.5,
                                      color: PRIMARY_COLOR,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: MARGIN_CARD_MEDIUM_2,
                                        ),
                                        child: Text(
                                          "Alan Lu",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            suffixIcon: Icon(
                                              Icons.emoji_emotions_outlined,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          cursorColor: TEXT_BOX_TOP_ICON_COLOR,
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MomentProfileView extends StatelessWidget {
  final UserVO? profileData;

  MomentProfileView({required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ProfileCoverNameDateAndMomentsCountView(
          name: profileData?.name,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.278,
          left: MediaQuery.of(context).size.width * 0.2,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              profileData?.profilePicture ?? "",
            ),
            radius: PROFILE_COVER_IMAGE_RADIUS,
          ),
        ),
      ],
    );
  }
}

class ProfileCoverNameDateAndMomentsCountView extends StatelessWidget {
  final String? name;

  ProfileCoverNameDateAndMomentsCountView({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileCoverAndNameView(
          name: name,
        ),
        Container(
          height: MARGIN_MEDIUM,
          color: PROFILE_COVER_DIVIDER_COLOR,
        ),
        const ProfileNameAndMomentsCountView(),
      ],
    );
  }
}

class ProfileNameAndMomentsCountView extends StatelessWidget {
  const ProfileNameAndMomentsCountView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CONTACT_TOP_BAR_BACKGROUND_COLOR,
      height: NAME_AND_MOMENTS_COUNT_VIEW_HEIGHT,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(
            top: MARGIN_MEDIUM,
            right: MARGIN_MEDIUM_2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                "Sunday, Sept 14, 2015",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: MARGIN_SMALL),
              Text(
                "23 new moments",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCoverAndNameView extends StatelessWidget {
  final String? name;

  ProfileCoverAndNameView({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      decoration: const BoxDecoration(
        color: Colors.blue,
        image: DecorationImage(
          image: NetworkImage(
            "https://cdn.britannica.com/84/73184-004-E5A450B5/Sunflower-field-Fargo-North-Dakota.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(MARGIN_CARD_MEDIUM_2),
          child: Text(
            name ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_3X,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
