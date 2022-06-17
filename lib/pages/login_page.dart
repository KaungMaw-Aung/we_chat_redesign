import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_redesign/blocs/login_bloc.dart';
import 'package:we_chat_redesign/pages/host_page.dart';
import 'package:we_chat_redesign/utils/extensions.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/loading_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GET_USER_DATA_PAGE_BACKGROUND_COLOR,
      body: ChangeNotifierProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const Icon(
                    Icons.wechat_outlined,
                    color: Colors.grey,
                    size: 300,
                  ),
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                          child: Builder(
                            builder: (context) {
                              LoginBloc bloc = Provider.of(context, listen: false);
                              return TextField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  hintText: ENTER_EMAIL,
                                  hintStyle: TextStyle(
                                    color: Colors.white24,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                                onChanged: (text) {
                                  bloc.onEmailTextChange(text);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: const Padding(
                          padding: EdgeInsets.only(left: MARGIN_LARGE),
                          child: Text(
                            PASSWORD,
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                          child: Builder(
                            builder: (context) {
                              LoginBloc bloc = Provider.of(context, listen: false);
                              return TextField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  hintText: ENTER_PASSWORD,
                                  hintStyle: TextStyle(
                                    color: Colors.white24,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                                onChanged: (text) {
                                  bloc.onPasswordTextChange(text);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: MARGIN_LARGE),
                  Selector<LoginBloc, bool>(
                    selector: (context, bloc) => bloc.isLoginButtonEnable,
                    builder: (context, isEnable, child) {
                      return GestureDetector(
                        onTap: () {
                          if (isEnable) {
                            LoginBloc bloc = Provider.of(context, listen: false);
                            bloc.onTapLogin().then((_) {
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
                            LOGIN,
                            style: TextStyle(
                              color: isEnable ? Colors.white : Colors.white24,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Selector<LoginBloc, bool>(
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
