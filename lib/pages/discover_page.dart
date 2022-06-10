import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_redesign/blocs/discover_bloc.dart';
import 'package:we_chat_redesign/data/vos/moment_vo.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/post_item_view.dart';

class DiscoverPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          MOMENTS,
          style: TextStyle(color: Colors.white70),
        ),
        centerTitle: true,
        actions: const [
          Icon(
            Icons.camera_alt_outlined,
            color: Colors.white70,
            size: MARGIN_XLARGE,
          ),
          SizedBox(width: MARGIN_MEDIUM),
        ],
      ),
      body: ChangeNotifierProvider<DiscoverBloc>(
        create: (context) => DiscoverBloc(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MomentProfileView(),
              Consumer<DiscoverBloc>(
                builder: (context, bloc, child) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: bloc.moments?.length ?? 0,
                    itemBuilder: (context, index) {
                      return PostItemView(momentVO: bloc.moments?[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class MomentProfileView extends StatelessWidget {
  const MomentProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ProfileCoverNameDateAndMomentsCountView(),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.278,
          left: MediaQuery.of(context).size.width * 0.2,
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://i.pinimg.com/originals/39/e9/b3/39e9b39628e745a39f900dc14ee4d9a7.jpg"),
            radius: PROFILE_COVER_IMAGE_RADIUS,
          ),
        ),
      ],
    );
  }
}

class ProfileCoverNameDateAndMomentsCountView extends StatelessWidget {
  const ProfileCoverNameDateAndMomentsCountView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileCoverAndNameView(),
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
  const ProfileCoverAndNameView({
    Key? key,
  }) : super(key: key);

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
      child: const Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.all(MARGIN_CARD_MEDIUM_2),
          child: Text(
            "Nina Rocha",
            style: TextStyle(
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
