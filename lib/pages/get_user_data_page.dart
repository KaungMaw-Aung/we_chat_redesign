import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_redesign/pages/privacy_policy_page.dart';
import 'package:we_chat_redesign/utils/extensions.dart';

import '../blocs/get_user_data_bloc.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class GetUserDataPage extends StatelessWidget {
  const GetUserDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GET_USER_DATA_PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.highlight_remove_rounded,
            color: Colors.white70,
          ),
        ),
        backgroundColor: GET_USER_DATA_PAGE_BACKGROUND_COLOR,
        elevation: 0,
      ),
      body: ChangeNotifierProvider(
        create: (context) => GetUserDataBloc(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: MARGIN_XXLARGE),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  SIGN_UP_WITH_MOBILE,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: TEXT_REGULAR_3X,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: MARGIN_LARGE),
              Selector<GetUserDataBloc, File?>(
                selector: (context, bloc) => bloc.chosenImage,
                builder: (context, imageFile, child) {
                  return (imageFile != null)
                      ? ProfileImageWithRemoveIconView(
                          imageFile: imageFile,
                          onTapRemoveImage: () {
                            GetUserDataBloc bloc = Provider.of(
                              context,
                              listen: false,
                            );
                            bloc.onDeleteImage();
                          },
                        )
                      : GestureDetector(
                          onTap: () => showPickPhotoOptions(context),
                          child: Container(
                            width: CHOSE_PROFILE_CONTAINER_SIZE,
                            height: CHOSE_PROFILE_CONTAINER_SIZE,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.circular(MARGIN_MEDIUM),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                },
              ),
              const SizedBox(height: MARGIN_XXLARGE),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Padding(
                      padding: EdgeInsets.only(left: MARGIN_LARGE),
                      child: Text(
                        FULL_NAME,
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
                      child: Builder(builder: (context) {
                        return TextField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            hintText: ENTER_ALIAS,
                            hintStyle: TextStyle(
                              color: Colors.white24,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                          onChanged: (text) {
                            GetUserDataBloc bloc = Provider.of(
                              context,
                              listen: false,
                            );
                            bloc.onFullNameTextChanged(text);
                          },
                        );
                      }),
                    ),
                  ),
                ],
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
                        REGION,
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
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ],
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
                        PHONE,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                          fontSize: TEXT_REGULAR_2X,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: MARGIN_LARGE),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.08,
                        child: const Text(
                          "+95",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: TEXT_REGULAR_2X,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Builder(builder: (context) {
                          return TextField(
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                            onChanged: (text) {
                              GetUserDataBloc bloc = Provider.of(
                                context,
                                listen: false,
                              );
                              bloc.onPhoneTextChanged(text);
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ],
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2),
                      child: Builder(builder: (context) {
                        return TextField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                          onChanged: (text) {
                            GetUserDataBloc bloc = Provider.of(
                              context,
                              listen: false,
                            );
                            bloc.onPasswordTextChanged(text);
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MARGIN_LARGE),
              Center(
                child: Selector<GetUserDataBloc, bool>(
                  selector: (context, bloc) => bloc.areTermsAccepted,
                  builder: (context, areTermsSelected, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: areTermsSelected,
                              fillColor:
                                  MaterialStateProperty.all(PRIMARY_COLOR),
                              onChanged: (isChecked) {
                                GetUserDataBloc bloc = Provider.of(
                                  context,
                                  listen: false,
                                );
                                bloc.onTapCheckBox(isChecked!);
                              },
                            ),
                            const Text(
                              HAVED_READ_TERMS,
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: TEXT_REGULAR,
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MARGIN_XXLARGE,
                          ),
                          child: Text(
                            TOOK_INFO_WARNING,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: TEXT_REGULAR,
                              height: 1.8,
                            ),
                          ),
                        ),
                        const SizedBox(height: MARGIN_LARGE),
                        GestureDetector(
                          onTap: () {
                            if (areTermsSelected) {
                              GetUserDataBloc bloc = Provider.of(
                                context,
                                listen: false,
                              );
                              bloc.craftUserVO().then((value) {
                                navigateToScreen(
                                  context,
                                  PrivacyPolicyPage(
                                    profileImageFile: value[1],
                                    newUser: value.first,
                                  ),
                                );
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: MARGIN_MEDIUM_2,
                              horizontal: MARGIN_LARGE,
                            ),
                            decoration: BoxDecoration(
                              color: areTermsSelected
                                  ? PRIMARY_COLOR
                                  : Colors.black54,
                              borderRadius:
                                  BorderRadius.circular(MARGIN_MEDIUM),
                            ),
                            child: Text(
                              ACCEPT_AND_CONTINUE,
                              style: TextStyle(
                                color: areTermsSelected
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void showPickPhotoOptions(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (context) {
        GetUserDataBloc bloc = Provider.of(buildContext, listen: false);
        return Wrap(
          children: [
            ListTile(
              title: const Text(
                TAKE_PHOTO,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              tileColor: AUTH_BUTTON_SHEET_BACKGROUND_COLOR,
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  bloc.onChooseImage(File(image.path));
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                CHOOSE_FROM_ALBUM,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              tileColor: AUTH_BUTTON_SHEET_BACKGROUND_COLOR,
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  bloc.onChooseImage(File(image.path));
                }
                Navigator.pop(context);
              },
            ),
            Container(
              height: MARGIN_MEDIUM,
              color: Colors.black87,
            ),
            ListTile(
              title: const Text(
                CANCEL,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              tileColor: AUTH_BUTTON_SHEET_BACKGROUND_COLOR,
              onTap: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}

class ProfileImageWithRemoveIconView extends StatelessWidget {
  final File? imageFile;
  final Function onTapRemoveImage;

  ProfileImageWithRemoveIconView({
    required this.imageFile,
    required this.onTapRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: CHOSE_PROFILE_CONTAINER_SIZE,
          height: CHOSE_PROFILE_CONTAINER_SIZE,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            image: DecorationImage(
              image: FileImage(imageFile ?? File("")),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => onTapRemoveImage(),
            child: const Icon(
              Icons.highlight_remove_rounded,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
