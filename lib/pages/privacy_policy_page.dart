import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_redesign/blocs/privacy_policy_bloc.dart';
import 'package:we_chat_redesign/pages/email_verification_page.dart';
import 'package:we_chat_redesign/resources/colors.dart';
import 'package:we_chat_redesign/utils/extensions.dart';

import '../data/vos/user_vo.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class PrivacyPolicyPage extends StatelessWidget {
  final UserVO newUser;
  final File? profileImageFile;

  PrivacyPolicyPage({
    required this.newUser,
    required this.profileImageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GET_USER_DATA_PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: PRIVACY_POLICY_PAGE_APP_BAR_COLOR,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.cancel_outlined,
            color: Colors.white70,
          ),
        ),
        title: const Text(
          PRIVACY_POLICY,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<PrivacyPolicyBloc>(
        create: (context) => PrivacyPolicyBloc(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: GET_USER_DATA_PAGE_BACKGROUND_COLOR,
                child: const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MARGIN_LARGE,
                      vertical: MARGIN_MEDIUM_2,
                    ),
                    child: Text(
                      "SUMMARY\n\nThank you for using WeChat! We respect your concerns about privacy and appreciate your trust and confidence in us.\nHere is a summary of the information contained in this privacy policy (\"Privacy Policy\"). This summary is to help you navigate the Privacy Policy and it is not a substitute for reading everything! You can use the hyperlinks below to jump directly to particular sections in the Privacy Policy.\n\nDOES THIS PRIVACY POLICY APPLY TO YOU?\n\nThis Privacy Policy only applies to you if you are a WeChat user, meaning that you have registered by linking a mobile number that uses an international dialing code other than +86 (\"non-Chinese Mainland mobile number\").\nThis Privacy Policy does not apply to you if you are a Weixin user. You are a Weixin user if you have either:\n\n- registered by linking a mobile number that uses international dialing code +86 (\"Chinese Mainland mobile number\"); or\n\n- contracted with 深圳市腾讯计算机系统有限公司(Shenzhen Tencent Computer Systems Company Limited) for Weixin.\n\nIf you are a Weixin user, you are subject to the Weixin Agreement on Software License and Service of Tencent Weixin and Weixin Privacy Protection Guidelines and not this Privacy Policy.\n\nYou can also check whether you are a WeChat or Weixin user by clicking \"Me\" > \"Settings\" > \"About\" and then clicking the link to the \"Terms of Service\". If you see the WeChat – Terms of Service then you are a WeChat user. If you see the Agreement on Software License and Service of Tencent Weixin then you are a Weixin user.",
                      style: TextStyle(
                        height: 1.4,
                        fontSize: TEXT_REGULAR_2X,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              color: GET_USER_DATA_PAGE_BACKGROUND_COLOR,
              child: Center(
                child: Selector<PrivacyPolicyBloc, bool>(
                  selector: (context, bloc) => bloc.areTermsAccepted,
                  builder: (context, areTermsAccepted, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: areTermsAccepted,
                              fillColor:
                                  MaterialStateProperty.all(PRIMARY_COLOR),
                              onChanged: (isChecked) {
                                PrivacyPolicyBloc bloc = Provider.of(
                                  context,
                                  listen: false,
                                );
                                bloc.onTapCheckBox(isChecked ?? false);
                              },
                            ),
                            const Text(
                              HAVE_READ_AND_ACCEPT_TERMS,
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: TEXT_REGULAR,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: MARGIN_MEDIUM_3),
                        GestureDetector(
                          onTap: () {
                            if (areTermsAccepted) {
                              navigateToScreen(
                                context,
                                EmailVerificationPage(
                                  newUser: newUser,
                                  profileImageFile: profileImageFile,
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: MARGIN_MEDIUM_2,
                              horizontal: 80,
                            ),
                            decoration: BoxDecoration(
                              color: areTermsAccepted
                                  ? PRIMARY_COLOR
                                  : Colors.black54,
                              borderRadius:
                                  BorderRadius.circular(MARGIN_MEDIUM),
                            ),
                            child: Text(
                              NEXT,
                              style: TextStyle(
                                color: areTermsAccepted
                                    ? Colors.white
                                    : Colors.white24,
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
          ],
        ),
      ),
    );
  }
}
