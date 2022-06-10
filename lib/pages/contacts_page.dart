import 'package:flutter/material.dart';
import 'package:we_chat_redesign/data/vos/contact_vo.dart';
import 'package:we_chat_redesign/widgets/vertical_divider_view.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/horizontal_divider_view.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  /// State Variables
  bool showHint = true;

  /// Dummy Contacts
  var dummyContacts = [
    ContactVO(
      id: "0",
      profileUrl:
          "https://i.pinimg.com/originals/39/e9/b3/39e9b39628e745a39f900dc14ee4d9a7.jpg",
      name: "Aung Aung",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "1",
      profileUrl:
          "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&w=1000&q=80",
      name: "Aung Pyae",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "2",
      profileUrl:
          "https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg?w=2000",
      name: "Aung Kyaw Htun",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "3",
      profileUrl:
          "https://img.freepik.com/free-photo/dreamy-young-woman-sunglasses-looking-front_197531-16739.jpg?w=2000",
      name: "Aung Kaung Myat",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "4",
      profileUrl:
          "https://images.squarespace-cdn.com/content/v1/54d96fcde4b0af07ca2a8871/1616629467192-HQSTI9MSL8ES895CWWCK/Linked+in_-3.jpg",
      name: "Aung Myat",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "5",
      profileUrl:
          "https://i.pinimg.com/originals/39/e9/b3/39e9b39628e745a39f900dc14ee4d9a7.jpg",
      name: "Bo Bo",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "6",
      profileUrl:
          "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&w=1000&q=80",
      name: "Bhone Htet",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "7",
      profileUrl:
          "https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg?w=2000",
      name: "Bhone Han Kyaw",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "8",
      profileUrl:
          "https://img.freepik.com/free-photo/dreamy-young-woman-sunglasses-looking-front_197531-16739.jpg?w=2000",
      name: "Chris",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "9",
      profileUrl:
          "https://images.squarespace-cdn.com/content/v1/54d96fcde4b0af07ca2a8871/1616629467192-HQSTI9MSL8ES895CWWCK/Linked+in_-3.jpg",
      name: "Charlie",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "10",
      profileUrl:
          "https://images.squarespace-cdn.com/content/v1/54d96fcde4b0af07ca2a8871/1616629467192-HQSTI9MSL8ES895CWWCK/Linked+in_-3.jpg",
      name: "Kaung Maw Aung",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "11",
      profileUrl:
          "https://i.pinimg.com/originals/39/e9/b3/39e9b39628e745a39f900dc14ee4d9a7.jpg",
      name: "Kaung Htet Myint",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "12",
      profileUrl:
          "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&w=1000&q=80",
      name: "Yu Ya Htay",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "14",
      profileUrl:
          "https://img.freepik.com/free-photo/dreamy-young-woman-sunglasses-looking-front_197531-16739.jpg?w=2000",
      name: "Ei Ngon Phoo",
      label: "Blah Corporation",
    ),
    ContactVO(
      id: "15",
      profileUrl:
          "https://images.squarespace-cdn.com/content/v1/54d96fcde4b0af07ca2a8871/1616629467192-HQSTI9MSL8ES895CWWCK/Linked+in_-3.jpg",
      name: "Zin Bo",
      label: "Blah Corporation",
    ),
  ];

  @override
  void initState() {
    [
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
      "Z",
    ].forEach((alphabet) {
      var result = dummyContacts.firstWhere(
        (element) => element.name?.startsWith(alphabet) ?? false,
        orElse: () => ContactVO(
          id: null,
          profileUrl: null,
          name: null,
          label: null,
          showTopAlphabetBar: false,
        ),
      );
      if (result.id != null) {
        result.showTopAlphabetBar = true;
        result.alphabet = alphabet;
        result.contactsCount = dummyContacts.where((element) => element.name?.startsWith(alphabet) ?? false).length;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // dummyContacts.forEach((element) {
    //   print(element.toString());
    // });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          BOT_NAV_CONTACTS_LABEL,
          style: TextStyle(color: Colors.white70),
        ),
        centerTitle: true,
        actions: const [
          Icon(
            Icons.add,
            color: Colors.white70,
            size: MARGIN_XLARGE,
          ),
          SizedBox(width: MARGIN_MEDIUM),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SearchBarView(
              showHint: showHint,
              onTextChange: (text) {
                setState(() {
                  showHint = text.isEmpty;
                });
              },
            ),
            const HorizontalDividerView(),
            const ContactsFeaturesBarView(),
            Expanded(
              child: ListView.builder(
                itemCount: dummyContacts.length,
                itemBuilder: (context, index) {
                  return ContactItemView(contact: dummyContacts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class ContactsFeaturesBarView extends StatelessWidget {
  const ContactsFeaturesBarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: CONTACTS_FEATURES_BAR_HEIGHT,
          child: Row(
            children: [
              ContactsFeatureItemView(
                label: NEW_FRIENDS,
                icon: Icons.account_circle_outlined,
              ),
              const VerticalDividerView(),
              ContactsFeatureItemView(
                label: GROUP_CHATS,
                icon: Icons.group,
              ),
              const VerticalDividerView(),
              ContactsFeatureItemView(
                label: TAGS,
                icon: Icons.tag,
              ),
              const VerticalDividerView(),
              ContactsFeatureItemView(
                label: OFFICIAL_ACCOUNTS,
                icon: Icons.devices,
              ),
            ],
          ),
        ),
        Container(
          height: MARGIN_MEDIUM,
          color: SEARCH_BAR_BACKGROUND_COLOR,
        )
      ],
    );
  }
}

class ContactsFeatureItemView extends StatelessWidget {
  final IconData icon;
  final String label;

  ContactsFeatureItemView({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.black38,
              size: MARGIN_XLARGE,
            ),
            const SizedBox(height: MARGIN_MEDIUM),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBarView extends StatelessWidget {
  final bool showHint;
  final Function(String) onTextChange;

  SearchBarView({
    required this.showHint,
    required this.onTextChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SEARCH_BAR_HEIGHT,
      padding: const EdgeInsets.all(MARGIN_CARD_MEDIUM_2),
      child: Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
          decoration: BoxDecoration(
            color: SEARCH_BAR_BACKGROUND_COLOR,
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  cursorColor: PRIMARY_COLOR,
                  onChanged: (text) => onTextChange(text),
                ),
              ),
              SearchBarHintView(showHint: showHint),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBarHintView extends StatelessWidget {
  final bool showHint;

  SearchBarHintView({required this.showHint});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: showHint,
            child: const Icon(
              Icons.search,
              color: Colors.black38,
              size: MARGIN_MEDIUM_3,
            ),
          ),
          const SizedBox(width: MARGIN_SMALL),
          Text(
            showHint ? SEARCH : "",
            style: const TextStyle(
              color: Colors.black38,
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
        ],
      ),
    );
  }
}
