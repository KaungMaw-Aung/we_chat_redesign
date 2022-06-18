import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:we_chat_redesign/data/vos/message_vo.dart';
import 'package:we_chat_redesign/pages/conversation_page.dart';
import 'package:we_chat_redesign/resources/colors.dart';
import 'package:we_chat_redesign/resources/dimens.dart';
import 'package:we_chat_redesign/utils/extensions.dart';

import '../resources/strings.dart';
import '../viewitems/chat_history_item_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Dummy Chat History
  var dummyChatHistory = [
    MessageVO(
      "https://i.pinimg.com/originals/39/e9/b3/39e9b39628e745a39f900dc14ee4d9a7.jpg",
      "John",
      "n publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.",
      "",
      "3:21 PM",
      1,
    ),
    MessageVO(
      "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&w=1000&q=80",
      "Tester",
      "n publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.",
      "",
      "3:21 PM",
      1,
    ),
    MessageVO(
      "https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg?w=2000",
      "Test User",
      "n publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.",
      "",
      "3:21 PM",
      1,
    ),
    MessageVO(
      "https://img.freepik.com/free-photo/dreamy-young-woman-sunglasses-looking-front_197531-16739.jpg?w=2000",
      "Blah Blah",
      "n publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.",
      "",
      "3:21 PM",
      1,
    ),
    MessageVO(
      "https://images.squarespace-cdn.com/content/v1/54d96fcde4b0af07ca2a8871/1616629467192-HQSTI9MSL8ES895CWWCK/Linked+in_-3.jpg",
      "Doe",
      "n publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.",
      "",
      "3:21 PM",
      1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          APP_NAME,
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
      body: ListView.separated(
        itemCount: dummyChatHistory.length,
        itemBuilder: (BuildContext context, int index) {
          return ChatHistoryItemView(
            index: index,
            messageVO: dummyChatHistory[index],
            onTapDismiss: (index) {
              setState(() {
                dummyChatHistory.removeAt(index);
              });
            },
            onTap: () => navigateToConversationPage(context),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: 0.5,
            color: Colors.black38,
          );
        },
      ),
    );
  }

  void navigateToConversationPage(BuildContext context) {
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConversationPage(),),);*/
  }

}


