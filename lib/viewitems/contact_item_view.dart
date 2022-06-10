import 'package:flutter/material.dart';

import '../data/vos/contact_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../widgets/horizontal_divider_view.dart';

class ContactItemView extends StatelessWidget {
  final ContactVO contact;

  ContactItemView({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: contact.showTopAlphabetBar,
          child: AlphabetTopBarView(
            contactsCount: contact.contactsCount ?? 0,
            alphabet: contact.alphabet ?? "",
          ),
        ),
        SizedBox(
          height: CONTACT_ITEM_VIEW_HEIGHT,
          child: Row(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    contact.profileUrl ?? "",
                  ),
                  radius: CONTACT_ITEM_PROFILE_RADIUS,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: MARGIN_LARGE),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contact.name ?? "",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: TEXT_REGULAR_3X,
                            ),
                          ),
                          const SizedBox(height: MARGIN_SMALL),
                          Text(
                            contact.label ?? "",
                            maxLines: 2,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const HorizontalDividerView(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class AlphabetTopBarView extends StatelessWidget {
  final String alphabet;
  final int contactsCount;

  AlphabetTopBarView({
    required this.alphabet,
    required this.contactsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CONTACT_TOP_BAR_BACKGROUND_COLOR,
      height: CONTACT_ALPHABET_TOP_BAR_HEIGHT,
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.25),
          Text(
            alphabet,
            style: const TextStyle(
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.w500,
              color: Colors.black38,
            ),
          ),
          const Spacer(),
          Text(
            "$contactsCount FRIENDS",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black12,
            ),
          ),
          const SizedBox(width: MARGIN_XXLARGE),
        ],
      ),
    );
  }
}