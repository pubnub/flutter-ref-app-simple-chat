import 'package:flutter/material.dart';

import '../providers/models.dart';

class ChatTitle extends StatelessWidget {
  final Space space;

  ChatTitle(this.space);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: space.description.isNotEmpty
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Text(
              space.name,
              style: TextStyle(color: Colors.black),
            ),
            space.description.isNotEmpty
                ? Text(space.description,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .apply(color: Colors.grey))
                : Container()
          ],
        ),
      ],
    );
  }
}
