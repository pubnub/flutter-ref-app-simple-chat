import 'package:flutter/material.dart';

class AppDrawerHeader extends StatelessWidget {
  final String userName;
  final String description;
  final String profileUrl;
  AppDrawerHeader(
      {required this.userName,
      required this.description,
      required this.profileUrl});
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage(profileUrl),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(description,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .apply(color: Colors.grey))
            ],
          ),
        ],
      ),
    );
  }
}
