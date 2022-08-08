import 'package:flutter/material.dart';

import '../providers/app_data.dart';

class OnlineUser extends StatelessWidget {
  final String uuid;
  OnlineUser(this.uuid);
  @override
  Widget build(BuildContext context) {
    var user = AppData.getUserById(uuid);
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          width: 40,
          height: 40,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: CircleAvatar(
            backgroundImage: AssetImage(user.profileUrl!),
          ),
        ),
        SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${user.name}${user.uuid == AppData.currentUser!.uuid ? '(You)' : ''}',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }
}
