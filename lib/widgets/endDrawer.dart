import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'onlineUser.dart';
import '../providers/presence.dart';

class EndDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onlineUsers =
        Provider.of<PresenceProvider>(context).onlineUsers.toList();

    return Center(
      child: ListView(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.all(15),
            child: const DrawerHeader(
              child: const Text(
                'Online Users',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(
              onlineUsers.length, (i) => OnlineUser(onlineUsers[i]))
        ],
      ),
    );
  } // build
}
