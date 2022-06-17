import 'package:flutter/material.dart';
import 'package:we_chat_redesign/pages/get_user_data_page.dart';
import 'package:we_chat_redesign/resources/dimens.dart';
import 'package:we_chat_redesign/utils/extensions.dart';

import '../resources/colors.dart';
import '../resources/strings.dart';
import 'login_page.dart';

class LoginOrSignUpPage extends StatelessWidget {
  const LoginOrSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/we_chat_auth_screen_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: MARGIN_LARGE,
              ),
              child: LoginAndSignUpButtonsView(
                onTapSignUp: () => showBottomSheet(context),
                onTapLogin: () {
                  navigateToScreen(context, const LoginPage());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AUTH_BUTTON_SHEET_BACKGROUND_COLOR,
      builder: (context) {
        return Wrap(
          children: [
            // Container(
            //   height: MARGIN_LARGE,
            //   decoration: const BoxDecoration(
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(MARGIN_MEDIUM_2),
            //       topRight: Radius.circular(MARGIN_MEDIUM_2),
            //     ),
            //     color: AUTH_BUTTON_SHEET_BACKGROUND_COLOR,
            //   ),
            // ),
            SizedBox(
              height: MARGIN_XXLARGE,
              child: Stack(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.highlight_remove,
                      color: Colors.white70,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      SELECT_SIGN_UP_METHOD,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: TEXT_REGULAR_2X,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () => navigateToScreen(
                    context,
                    const GetUserDataPage(),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                          vertical: MARGIN_CARD_MEDIUM_2),
                    ),
                    backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(width: MARGIN_XXLARGE),
                      Icon(
                        Icons.phone_android_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: MARGIN_SMALL),
                      Text(
                        SIGN_UP_WITH_MOBILE,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: TEXT_REGULAR_2X,
                        ),
                      ),
                      SizedBox(width: MARGIN_XXLARGE),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 65),
            const Center(
              child: Text(
                OR,
                style: TextStyle(
                  color: Colors.white24,
                ),
              ),
            ),
            const SizedBox(height: 35),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Respond to button press
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        vertical: MARGIN_MEDIUM_2,
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.white70),
                    ),
                  ),
                  icon: const Icon(
                    Icons.apple,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: const Text(
                    SIGN_UP_WITH_APPLE,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 65),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Respond to button press
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        vertical: MARGIN_MEDIUM_2,
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.white70),
                    ),
                  ),
                  icon: const Icon(
                    Icons.facebook,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: const Text(
                    SIGN_UP_WITH_FACEBOOK,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        );
      },
    );
  }
}

class LoginAndSignUpButtonsView extends StatelessWidget {
  final Function onTapSignUp;
  final Function onTapLogin;

  LoginAndSignUpButtonsView({
    required this.onTapSignUp,
    required this.onTapLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: MARGIN_LARGE),
        Expanded(
          child: ElevatedButton(
            onPressed: () => onTapLogin(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: MARGIN_MEDIUM_2,
                ),
              ),
            ),
            child: const Text(
              LOGIN,
              style: TextStyle(
                color: PRIMARY_COLOR,
              ),
            ),
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM_2),
        Expanded(
          child: ElevatedButton(
            onPressed: () => onTapSignUp(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: MARGIN_MEDIUM_2,
                ),
              ),
            ),
            child: const Text(
              SIGN_UP,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: MARGIN_LARGE),
      ],
    );
  }
}
