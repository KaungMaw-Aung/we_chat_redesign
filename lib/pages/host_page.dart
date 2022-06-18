import 'package:flutter/material.dart';
import 'package:we_chat_redesign/pages/contacts_page.dart';
import 'package:we_chat_redesign/pages/discover_page.dart';
import 'package:we_chat_redesign/pages/profile_page.dart';
import 'package:we_chat_redesign/resources/strings.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import 'home_page.dart';

class HostPage extends StatefulWidget {
  int? selectedIndex;

  HostPage({this.selectedIndex});

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  final List<Widget> mainPages = [
    const HomePage(),
    const ContactsPage(),
    DiscoverPage(),
    const ProfilePage(),
  ];
  int currentBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: mainPages[(widget.selectedIndex == null)
                  ? currentBottomNavIndex
                  : widget.selectedIndex!]),
          BottomNavBarView(
            onTapItem: (index) {
              setState(() {
                currentBottomNavIndex = index;
                widget.selectedIndex = null;
              });
            },
            selectedIndex: (widget.selectedIndex == null)
                ? currentBottomNavIndex
                : widget.selectedIndex!,
          ),
        ],
      ),
    );
  }
}

class BottomNavBarView extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTapItem;

  BottomNavBarView({
    required this.selectedIndex,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: BOT_NAV_HEIGHT,
      color: Colors.white,
      child: Column(
        children: [
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: MARGIN_XLARGE),
              BotNavBarItemView(
                icon: Icons.chat_outlined,
                isSelected: selectedIndex == 0,
                label: BOT_NAV_HOME_LABEL,
                onTap: () {
                  onTapItem(0);
                },
              ),
              const Spacer(),
              BotNavBarItemView(
                icon: Icons.perm_contact_cal_outlined,
                isSelected: selectedIndex == 1,
                label: BOT_NAV_CONTACTS_LABEL,
                onTap: () {
                  onTapItem(1);
                },
              ),
              const Spacer(),
              BotNavBarItemView(
                icon: Icons.add_circle_outline,
                isSelected: selectedIndex == 2,
                label: BOT_NAV_DISCOVER_LABEL,
                onTap: () {
                  onTapItem(2);
                },
              ),
              const Spacer(),
              BotNavBarItemView(
                icon: Icons.account_circle_outlined,
                isSelected: selectedIndex == 3,
                label: BOT_NAV_PROFILE_LABEL,
                onTap: () {
                  onTapItem(3);
                },
              ),
              const SizedBox(width: MARGIN_XLARGE),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class BotNavBarItemView extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Function onTap;

  BotNavBarItemView({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        children: [
          Icon(
            icon,
            size: MARGIN_XLARGE,
            color: isSelected
                ? BOT_NAV_ITEM_SELECTED_COLOR
                : BOT_NAV_ITEM_UNSELECTED_COLOR,
          ),
          const SizedBox(height: MARGIN_SMALL),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? BOT_NAV_ITEM_SELECTED_COLOR
                  : BOT_NAV_ITEM_UNSELECTED_COLOR,
              fontWeight: FontWeight.w600,
              fontSize: TEXT_SMALL_2,
            ),
          ),
        ],
      ),
    );
  }
}
