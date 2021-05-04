import 'package:flutter/material.dart';

import '../providers/app_data.dart';

import 'drawer_header.dart';
import 'drawer_item.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        height: 100,
        child: AppDrawerHeader(
          userName: AppData.currentUser.name,
          description: AppData.currentUser.custom['title'],
          profileUrl: AppData.currentUser.profileUrl,
        ),
      ),
      const SizedBox(height: 20),
      Container(
        padding: EdgeInsets.all(15),
        child: const Text('Spaces',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      ),
      ...List.generate(
        AppData.spaces.length,
        (index) => DrawerListItem(AppData.spaces[index]),
      ),
      const Divider(),
      Container(
        padding: const EdgeInsets.all(15),
        child: const Text('Direct chats',
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold)),
      ),
      ...List.generate(AppData.directChats.length,
          (index) => DrawerListItem(AppData.directChats[index]))
    ]);
  }
}
