import 'package:flutter/material.dart';

import '../screens/conversation.dart';
import '../providers/models.dart';

class DrawerListItem extends StatelessWidget {
  final Space space;

  DrawerListItem(this.space);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Conversation.routeName, arguments: space.id);
      },
      title: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage(space.custom!['thumb']),
            ),
          ),
          SizedBox(width: 5),
          Text(space.name, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
