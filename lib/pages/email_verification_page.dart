import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_redesign/blocs/email_verification_bloc.dart';
import 'package:we_chat_redesign/pages/home_page.dart';
import 'package:we_chat_redesign/pages/host_page.dart';
import 'package:we_chat_redesign/utils/extensions.dart';

import '../data/vos/user_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/loading_view.dart';

class EmailVerificationPage extends StatelessWidget {
  final UserVO newUser;
  final File? profileImageFile;

  EmailVerificationPage({
    required this.newUser,
    required this.profileImageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GET_USER_DATA_PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: GET_USER_DATA_PAGE_BACKGROUND_COLOR,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.cancel_outlined,
            color: Colors.white70,
          ),
        ),
      ),
      body: ChangeNotifierProvider<EmailVerificationBloc>(
        create: (context) => EmailVerificationBloc(),
        child: Stack(
          children: [
            Column(
              children: [
                const Text(
                  EMAIL_VERIFICATION,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: TEXT_CARD_REGULAR_2X,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 50),
                const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: MARGIN_LARGE,
                    ),
                    child: Text(
                      ENTER_VERIFICATION_INFO,
                      style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: MARGIN_MEDIUM_2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: const Padding(
                        padding: EdgeInsets.only(left: MARGIN_LARGE),
                        child: Text(
                          EMAIL,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                            fontSize: TEXT_REGULAR_2X,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM_2),
                        child: Builder(
                          builder: (context) {
                            EmailVerificationBloc bloc = Provider.of(
                              context,
                              listen: false,
                            );
                            return TextField(
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                border: InputBorder.none,
                                hintText: ENTER_EMAIL_ADDRESS,
                                hintStyle: TextStyle(
                                  color: Colors.white24,
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                              onChanged: (text) {
                                bloc.onChangeEmail(text);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Selector<EmailVerificationBloc, bool>(
                  selector: (context, bloc) => bloc.isOkButtonEnable,
                  builder: (context, isEnable, child) {
                    return GestureDetector(
                      onTap: () {
                        if (isEnable) {
                          EmailVerificationBloc bloc = Provider.of(
                            context,
                            listen: false,
                          );
                          bloc
                              .onTapConfirmButton(newUser, profileImageFile)
                              .then((_) {
                                navigateToScreen(context, const HostPage());
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: MARGIN_MEDIUM_2,
                          horizontal: 80,
                        ),
                        decoration: BoxDecoration(
                          color: isEnable ? PRIMARY_COLOR : Colors.black54,
                          borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                        ),
                        child: Text(
                          OK,
                          style: TextStyle(
                            color: isEnable ? Colors.white : Colors.white24,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 100),
              ],
            ),
            Selector<EmailVerificationBloc, bool>(
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
    );
  }
}
