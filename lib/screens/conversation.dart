import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/endDrawer.dart';
import '../widgets/chat_body.dart';
import '../widgets/chat_title.dart';
import '../widgets/drawer.dart';
import '../providers/app_data.dart';
import '../providers/presence.dart';
import '../providers/messages.dart';

class Conversation extends StatefulWidget {
  static const routeName = '/conversation';
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var messageProvider;

  @override
  Widget build(BuildContext context) {
    messageProvider = Provider.of<MessageProvider>(context, listen: false);
    final space = AppData.getSpaceById(
        ModalRoute.of(context).settings.arguments as String);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<PresenceProvider>(
                  builder: (_, presence, __) => Text(
                    '${presence.occupancy}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            IconButton(
                icon: Icon(Icons.people_outline),
                onPressed: () {
                  _scaffoldKey.currentState.openEndDrawer();
                })
          ],
          leading: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  }),
            ],
          ),
          title: ChatTitle(space),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        drawer: Drawer(child: AppDrawer()),
        endDrawer: Drawer(child: EndDrawer()),
        body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: ChatBody(space)));
  }
}
