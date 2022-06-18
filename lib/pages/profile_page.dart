import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_redesign/blocs/profile_bloc.dart';
import 'package:we_chat_redesign/pages/qr_code_and_scanner_page.dart';
import 'package:we_chat_redesign/resources/colors.dart';
import 'package:we_chat_redesign/utils/extensions.dart';

import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/contacts_feature_item_view.dart';
import '../widgets/vertical_divider_view.dart';
import 'login_or_sign_up_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: ChangeNotifierProvider<ProfileBloc>(
        create: (context) => ProfileBloc(),
        child: SafeArea(
          child: Consumer<ProfileBloc>(
            builder: (context, bloc, child) {
              return Column(
                children: [
                  SizedBox(
                    height: USER_PROFILE_TOP_BACKGROUND_HEIGHT,
                    child: UserProfileSectionView(
                      name: bloc.name,
                      profileUrl: bloc.profileUrl,
                      onTapQR: () {
                        navigateToScreen(
                          context,
                          QRCodeAndScannerPage(
                            qrCode: bloc.qrCode ?? "",
                          ),
                        );
                      },
                    ),
                  ),
                  const ProfileFeaturesSectionView(),
                  Expanded(
                    child: Container(
                      color: CONTACT_TOP_BAR_BACKGROUND_COLOR,
                      child: Center(
                        child: LogoutButtonView(
                          onTapLogout: () {
                            bloc.logout().then((_) {
                              navigateToScreen(
                                context,
                                const LoginOrSignUpPage(),
                              );
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LogoutButtonView extends StatelessWidget {
  final Function onTapLogout;

  LogoutButtonView({required this.onTapLogout});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapLogout(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MARGIN_XXLARGE,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(MARGIN_LARGE),
        ),
        child: const Center(
          child: Text(
            LOGOUT,
            style: TextStyle(
              fontSize: MARGIN_MEDIUM_3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileFeaturesSectionView extends StatelessWidget {
  const ProfileFeaturesSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: USER_PROFILE_FEATURES_BAR_HEIGHT,
          color: Colors.white,
          child: Row(
            children: [
              ContactsFeatureItemView(
                label: PHOTOS,
                icon: Icons.photo_outlined,
              ),
              const VerticalDividerView(),
              ContactsFeatureItemView(
                label: FAVORITES,
                icon: Icons.favorite_outline,
              ),
              const VerticalDividerView(),
              ContactsFeatureItemView(
                label: WALLET,
                icon: Icons.account_balance_wallet_outlined,
              ),
            ],
          ),
        ),
        Container(
          height: USER_PROFILE_FEATURES_BAR_HEIGHT,
          color: Colors.white,
          child: Row(
            children: [
              ContactsFeatureItemView(
                label: CARDS,
                icon: Icons.credit_card_sharp,
              ),
              const VerticalDividerView(),
              ContactsFeatureItemView(
                label: STICKERS,
                icon: Icons.emoji_emotions_outlined,
              ),
              const VerticalDividerView(),
              ContactsFeatureItemView(
                label: SETTINGS,
                icon: Icons.settings,
              ),
            ],
          ),
        ),
        Container(
          height: MARGIN_MEDIUM,
          color: SEARCH_BAR_BACKGROUND_COLOR,
        ),
      ],
    );
  }
}

class UserProfileSectionView extends StatelessWidget {
  final String? name;
  final String? profileUrl;
  final Function onTapQR;

  UserProfileSectionView({
    required this.name,
    required this.profileUrl,
    required this.onTapQR,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: USER_PROFILE_TOP_BACKGROUND_HEIGHT,
          child: Column(
            children: [
              NameAndQRScanButtonView(
                name: name,
                onTapQR: onTapQR,
              ),
              const UserMottoView(),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: USER_PROFILE_SIZE,
            height: USER_PROFILE_SIZE,
            padding: const EdgeInsets.all(MARGIN_SMALL),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(USER_PROFILE_SIZE * 0.5),
            ),
            child: CircleAvatar(
              radius: USER_PROFILE_SIZE * 0.5,
              backgroundImage: NetworkImage(
                profileUrl ?? "",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UserMottoView extends StatelessWidget {
  const UserMottoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: CONTACT_TOP_BAR_BACKGROUND_COLOR,
        child: const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              left: MARGIN_XXLARGE,
              right: MARGIN_XXLARGE,
              bottom: MARGIN_MEDIUM_2,
            ),
            child: Text(
              "The worst of all possible universes and the best of all possible earths.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: TEXT_REGULAR_2X,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NameAndQRScanButtonView extends StatelessWidget {
  final String? name;
  final Function onTapQR;

  NameAndQRScanButtonView({
    required this.name,
    required this.onTapQR,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: PRIMARY_COLOR,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: MARGIN_MEDIUM_2,
                ),
                child: Text(
                  name ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR_3X,
                  ),
                ),
              ),
            ),
            Positioned(
              top: MARGIN_MEDIUM_2,
              right: MARGIN_MEDIUM_2,
              child: GestureDetector(
                onTap: () => onTapQR(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.qr_code,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
